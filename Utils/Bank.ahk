#Requires AutoHotkey v2.0
#Include ../Utils/WindHumanMouse.ahk
#Include ../Utils/TimeUtils.ahk
#Include ../Utils/Input.ahk
#Include ../Utils/ErrorHandling.ahk

OpenBank()
{
    MoveMouse(120, 275, 0.4, true)
	Click
	RandomSleep(750, 1000, True)
}

OpenBankCoord(xPos, yPos)
{
    MoveMouse(xPos, yPos, 0.4, true)
	Click
	RandomSleep(750, 1000, True)
}

OpenBankImage(image)
{
    if ClickImage(10, 10, image, false, false)
        RandomSleep(750, 1000, True)
    else
        OnError("Could not find bank image")
}

CloseBank()
{
    Send "{Escape}"
	RandomSleep(400, 700)
}

ClearInventory()
{
    if ClickImage(10, 10, "*5 ./Resources/ui/bank_deposit.png", false, false)
        RandomSleep(500, 700)
    else
        OnError("Could not find bank deposit")
    
}

WithDrawItem(column, row, isShift:=False)
{
    c1 := 135
    r1 := 195
    cd := 73
    rd := 53

    x := c1 + cd*(column-1)
    y := r1 + rd*(row-1)

    MoveMouse(x, y, 0.4, true)
    if (isShift) 
        ShiftClick()
    else
        Click
    RandomSleep(150,300)
}

WithdrawItemByImage(image, isShift:=false)
{
    if ClickImage(10, 10, image, false, isShift)
        RandomSleep(500, 700)
    else
        OnError("Could not find image: " . image)
}
