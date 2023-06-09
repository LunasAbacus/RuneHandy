#Requires AutoHotkey v2.0
#Include ../Utils/WindHumanMouse.ahk
#Include ../Utils/TimeUtils.ahk
#Include ../Utils/Input.ahk
#SingleInstance Force
#HotIf WinActive("ahk_exe RuneLite.exe")

ClickImage(offSetx, offSety, imagePath, rightClick:=false, isShift:=false)
{
    if ImageSearch(&FoundX, &FoundY, 0, 0, 1150, 800, imagePath)
    {
        ; MsgBox "The icon was found at " FoundX "x" FoundY
        MoveMouse(FoundX + offSetx, FoundY + offSety, 0.4, true)
        if (isShift) 
            ShiftClick()
        else if (rightClick)
            Click "Right"
        else
            Click
        return true
    }
    else
    {
        return false
    }
}
