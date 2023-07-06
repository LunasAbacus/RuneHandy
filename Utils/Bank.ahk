#Requires AutoHotkey v2.0
#Include ../Utils/WindHumanMouse.ahk
#Include ../Utils/TimeUtils.ahk
#Include ../Utils/Input.ahk
#Include ../Utils/ErrorHandling.ahk
#Include ../DataTypes/Region.ahk

OpenBank()
{
    ClickImageWithConfirmationRetry("*15 ./Resources/butler.png", "*15 ./Resources/ui/bank_confirmation.png", 800, gameRegion)
}

OpenBankTile(sleepMin)
{
    ClickImage(0, 0, "*15 ./Resources/15x15x000000.png", false, false)
    RandomSleep(sleepMin, sleepMin * 1.1, true)
}

OpenBankCoord(xPos, yPos)
{
    MoveMouse(xPos, yPos, 0.4, true)
	Click
	RandomSleep(750, 1000, True)
}

OpenBankImage(image)
{
    if ClickImage(10, 10, image, false, false, false)
        RandomSleep(750, 1000, True)
    else
        OnError("Could not find bank image")
}

CloseBank()
{
    Send "{Escape}"
	RandomSleep(500, 700)
}

ClearInventory()
{
    if ClickImage(10, 10, "*15 ./Resources/ui/bank_deposit.png", false, false)
        RandomSleep(500, 700)
    else
        OnError("Could not find bank deposit")
    
}

DepositItem(item)
{
    if ClickImage(10, 10, item, false, true)
        RandomSleep(300, 400)
    else
        OnError("Could not find item to deposit")
}

WithDrawItem(column, row, isShift:=False)
{
    c1 := 
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
    if ClickImage(5, 5, image, false, isShift)
        RandomSleep(500, 700)
    else
        OnError("Could not find image: " . image)
}
