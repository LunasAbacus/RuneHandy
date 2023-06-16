#Requires AutoHotkey v2.0
#Include ../Utils/WindHumanMouse.ahk
#Include ../Utils/TimeUtils.ahk
#Include ../Utils/Inventory.ahk

; alch
; 1085, 510

OpenSpellbook()
{
    Send "{F4}"
    RandomSleep(100, 150)
}

Alch(item)
{
    SimpleImageClick("*25 ./Resources/magic/hialch.png", 200)
    SimpleImageClick(item, 200)
}

CamelotTeleport()
{
    SimpleImageClick("*25 ./Resources/magic/camelot.png", 200)
}
