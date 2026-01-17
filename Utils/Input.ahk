#Requires AutoHotkey v2.0

#Include Inventory.ahk
#Include TimeUtils.ahk
#Include WindHumanMouse.ahk

dpi := DllCall("GetDpiForSystem", "UInt")
scale := dpi / 96.0
ONE_TICK := 600

ShiftClick()
{
    Send "{Shift Down}"
	Sleep 75
	click
	Sleep 75
	Send "{Shift Up}"
}

HandleRuneLiteInstruction(payload) {
	instructions := payload['instructions']
	for (instruction in instructions) {
		type := instruction['type']
		parameters := instruction['parameters']

		if (type == 'CLICK') {
			HandleClickCommand(parameters)
		} else if (type == 'SLEEP') {
			HandleSleepCommand(parameters)
		} else if (type == 'DROP') {
			HandleDropCommand(parameters)
		} else if (type == 'TYPE') {
			HandleTypeCommand(parameters)
		} else if (type == 'PRAY') {
			HandlePrayCommand(parameters)
		} else {
			MsgBox("Unknown instruction received: " . type)
		}
	}
}

HandleClickCommand(params) {
	; Pull out relavent parameters (x, y, radius, minWait, maxWait, shift, right, speed)
	x := GetOr(params, 'x', 0) * scale
	y := GetOr(params, 'y', 0) * scale
	radius := GetOr(params, 'radius', 10)
	minWait := GetOr(params, 'waitMinMillis', ONE_TICK)
	maxWait := GetOr(params, 'waitMaxMillis', ONE_TICK * 2)
	isShift := GetOr(params, 'isShift', 0)
	clickButton := GetOr(params, "clickButton", 0)
	speed := GetOr(params, 'speed', 60)


	; Perform action
	
	; Shift modifier
	if (isShift == 1) {
		Send "{Shift Down}"
	}

	; Move mouse
	;MsgBox("Moving mouse to x: " . x . " y: " . y . " speed: " . speed)
	MoveMouse(x, y, speed / 100, true, radius)

	; Click
	Click clickButton

	; Lift shift
	if (isShift == 1) {
		Send "{Shift Up}"
	}

	; Sleep
	RandomSleep(minWait, maxWait)
}

HandleSleepCommand(params) {
	; Pull out relavent parameters (minWait, maxWait)
	minWait := GetOr(params, 'waitMinMillis', ONE_TICK)
	maxWait := GetOr(params, 'waitMaxMillis', ONE_TICK * 2)

	; Perform action
	RandomSleep(minWait, maxWait)
}

HandleDropCommand(params) {
	; Pull out relavent parameters (keepTools)
	keepTools := GetOr(params, 'keepTools', 1) ; Default to on to protect tools unless sure

	; Perform action
	if (keepTools := 1) {
		DropInventoryKeepTools()
	} else {
		DropInventory()
	}
}

HandleTypeCommand(params) {
	; Pull out relavent parameters
	keys := GetOr(params, 'keys', [])

	; Perform action
	for (key in keys) {
		Send key
		Sleep 50
	}
}

HandlePrayCommand(params) {
	; Pull out relavent parameters

	; Perform action
}

GetOr(map, key, default) {
    return map.Has(key) ? map[key] : default
}
