#Requires AutoHotkey v2.0
#Include ../Utils/WindHumanMouse.ahk
#Include ../Utils/TimeUtils.ahk
#Include ../Utils/Input.ahk

global slot := 1

CombineSlots(slotNumberA, slotNumberB, minWait:=10000)
{
    ClickSlot(slotNumberA)
    ClickSlot(slotNumberB)
	RandomSleep(1000, 1100)
	Send "{space}"
	RandomSleep(minWait, minWait*1.1, True)
}

ClickSlot(slotNumber, shift:=False) {
    pos := SlotPosition(slotNumber)
    MoveMouse(pos.x, pos.y, 0.4, true)
    if (shift)
        ShiftClick()
    else
    	Click
	RandomSleep(100, 200)
}

DropInventory() {
    i := 1
    loop 28
    {
        ClickSlot(i)
        RandomSleep(100,150)
        i += 1
    }
}

;d::
;{
;    DropInventory()
;}

SlotPosition(slotNumber)
{
    slotNumber -= 1

    column := slotNumber // 4
    row := Mod(slotNumber, 4)
    x := 870 + row * 64
    y := 380 + column * 61

    return {x:x, y:y}
}
