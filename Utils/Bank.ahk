#Requires AutoHotkey v2.0
#Include ../Utils/WindHumanMouse.ahk
#Include ../Utils/TimeUtils.ahk

OpenBank()
{
    MoveMouse(120, 275, 0.4)
	Click
	RandomSleep(750, 1000, True)
}

CloseBank()
{
    Send "{Escape}"
	RandomSleep(400, 700)
}

ClearInventory()
{
    MoveMouse(675, 510, 0.4)
    Click
    RandomSleep(500, 700)
}

ShiftClick()
{
    Send "{Shift Down}"
	Sleep 75
	click
	Sleep 75
	Send "{Shift Up}"
}

WithDrawItem(column, row, isShift:=False)
{
    c1 := 135
    r1 := 195
    cd := 73
    rd := 53

    x := c1 + cd*(column-1)
    y := r1 + rd*(row-1)

    MoveMouse(x, y, 0.4)
    if (isShift) 
        ShiftClick()
    else
        Click
    RandomSleep(150,300)
}
