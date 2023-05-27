#Requires AutoHotkey v2.0
#Include ../Utils/WindHumanMouse.ahk
#Include ../Utils/TimeUtils.ahk

CombineSlots(slotNumberA, slotNumberB, minWait:=10000)
{
    ClickSlot(slotNumberA)
    ClickSlot(slotNumberB)
	RandomSleep(1000, 1100)
	Send "{space}"
	RandomSleep(minWait, minWait*1.1, True)
}

ClickSlot(slotNumber) {
    ; 875, 390 1,1
    ; 935, 445 2,2

    row := slotNumber / 4
    column := Mod(slotNumber, 4)
    x := 875 + (column - 1) * 60
    y := 390 + (row - 1) * 58

    MoveMouse(x, y, 0.4)
	Click
	RandomSleep(100, 200)
}