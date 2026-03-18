#Requires AutoHotkey v2.0

#Include Inventory.ahk
#Include TimeUtils.ahk
#Include WindHumanMouse.ahk

dpi := DllCall("GetDpiForSystem", "UInt")
; dpi := 96.0
scale := dpi / 96.0
ONE_TICK := 600

last_id := ''

ShiftClick()
{
    Send "{Shift Down}"
	Sleep 75
	click
	Sleep 75
	Send "{Shift Up}"
}

HandleRuneLiteInstruction(payload) {
	global last_id

	instructions := payload['instructions']
	id := payload['id']

	; if ran command already, wait for new one
	if (id == last_id) {
		Sleep 50
		return
	}

	last_id := id

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
		} else if (type == 'HOVER') {
			HandleHoverCommand(parameters)
		} else {
			MsgBox("Unknown instruction received: " . type)
		}
	}
}

SaveUserState() {
    ; Mouse position (always save in Screen coords)
    CoordMode "Mouse", "Screen"
    MouseGetPos &mx, &my, &mHwnd

    ; Active window
    aHwnd := WinExist("A")

    ; Fullscreen heuristic: active window roughly equals its monitor bounds
    fs := IsFullscreen(aHwnd)

	CoordMode "Mouse", "Client"

    return Map(
        "mx", mx, "my", my,
        "activeHwnd", aHwnd,
        "wasFullscreen", fs
    )
}

IsFullscreen(hwnd) {
    if !hwnd
        return false

    ; Get window rect
    WinGetPos &wx, &wy, &ww, &wh, hwnd

    ; Get monitor rect nearest the window
    hMon := DllCall("MonitorFromWindow", "ptr", hwnd, "uint", 2, "ptr") ; MONITOR_DEFAULTTONEAREST
    mi := Buffer(40, 0) ; MONITORINFO size = 40
    NumPut("uint", 40, mi, 0)
    if !DllCall("GetMonitorInfo", "ptr", hMon, "ptr", mi)
        return false

    left   := NumGet(mi, 4,  "int")
    top    := NumGet(mi, 8,  "int")
    right  := NumGet(mi, 12, "int")
    bottom := NumGet(mi, 16, "int")

    mw := right - left
    mh := bottom - top

    ; Heuristic tolerance (borders, DPI, etc.)
    tol := 4
    return (Abs(wx - left) <= tol
        && Abs(wy - top) <= tol
        && Abs(ww - mw) <= tol
        && Abs(wh - mh) <= tol)
}

RestoreUserState(state) {
    ; Restore focus first (some apps ignore cursor warps when not foreground)
    if state.Has("activeHwnd") && state["activeHwnd"]
        WinActivate state["activeHwnd"]

    ; Give it a moment to come foreground (esp. fullscreen apps)
    WinWaitActive state["activeHwnd"], , 1

    ; Restore mouse
    CoordMode "Mouse", "Screen"
    MouseMove state["mx"], state["my"], 0

    ; If it *was* fullscreen and your automation may have disturbed it,
    ; you can optionally enforce fullscreen via Alt+Enter (common in games).
    ; WARNING: Not universal. Only enable if you actually need it.
    ; if state["wasFullscreen"]
    ;     Send "!{Enter}"
}

HandleClickCommand(params) {
	saved := SaveUserState()

    hwnd := WinExist("RuneLite - Cinnador")
	WinActivate hwnd
	WinWaitActive hwnd

	; Pull out relavent parameters (x, y, radius, minWait, maxWait, shift, right, speed)
	x := GetOr(params, 'x', 0) * scale
	y := GetOr(params, 'y', 0) * scale
	radius := GetOr(params, 'radius', 7)
	isShift := GetOr(params, 'isShift', 0)
	clickButton := GetOr(params, "clickButton", 0)
	speed := GetOr(params, 'speed', 60)


	; Perform action
	
	; Shift modifier
	if (isShift == 1) {
		Send "{Shift Down}"
		sleep 50
	}

	; Move mouse
	MoveMouse(x, y, speed / 100, true, radius)

	; Click
	Click clickButton

	; Lift shift
	if (isShift == 1) {
		sleep 50
		Send "{Shift Up}"
	}

	; RestoreUserState(saved)

}

HandleHoverCommand(params) {
	; Pull out relavent parameters (x, y, radius, minWait, maxWait, shift, right, speed)
	x := GetOr(params, 'x', 0) * scale
	y := GetOr(params, 'y', 0) * scale
	radius := GetOr(params, 'radius', 10)
	minWait := GetOr(params, 'waitMinMillis', ONE_TICK)
	maxWait := GetOr(params, 'waitMaxMillis', ONE_TICK * 2)
	speed := GetOr(params, 'speed', 60)

	; Move mouse
	MoveMouse(x, y, speed / 100, true, radius)

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
	for _, key in keys {
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
