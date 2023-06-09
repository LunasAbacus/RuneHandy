#Requires AutoHotkey v2.0
#Include ../Utils/WindHumanMouse.ahk
#Include ../Utils/TimeUtils.ahk

SelectMenuItem(itemNumber)
{
    ; Middle of item 1 -> 40px y
    ; Middle of item 2 -> 62px y
    ; Middle of item 3 -> 85px y
    ; Middle of item 4 -> 107px y
    ; Start at 40px offset y
    ; increment 22px offset per item
    
    ; Get current mouse pos
    ; MoveMouse x, y+40+(itemNumber-1)*22
    offSety := 40 + (itemNumber-1) * 22
    MouseGetPos &xpos, &ypos 
    MoveMouse(xpos, ypos + offSety, 0.4)
    Click
}