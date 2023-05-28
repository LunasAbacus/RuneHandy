#Requires AutoHotkey v2.0
#Include ../Utils/WindHumanMouse.ahk
#Include ../Utils/TimeUtils.ahk

global slot := 1

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

    slotNumber -= 1

    column := slotNumber // 4
    row := Mod(slotNumber, 4)
    x := 870 + row * 64
    y := 380 + column * 61

    MoveMouse(x, y, 0.4)
	Click
	RandomSleep(100, 200)
}
