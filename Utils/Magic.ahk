#Requires AutoHotkey v2.0
#Include ../Utils/WindHumanMouse.ahk
#Include ../Utils/TimeUtils.ahk
#Include ../Utils/Inventory.ahk

; alch
; 1085, 510

Alch()
{
    MoveMouse(1085, 510, 0.4, true)
	Click
	RandomSleep(150, 200)
    ClickSlot(12)
    RandomSleep(150, 200)
}

CamelotTeleport()
{
    ; 1045, 475
    MoveMouse(1045, 475, 0.4, true)
	Click
    RandomSleep(100, 200)
}
