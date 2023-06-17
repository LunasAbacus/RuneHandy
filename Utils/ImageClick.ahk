#Requires AutoHotkey v2.0
#Include ../Utils/WindHumanMouse.ahk
#Include ../Utils/TimeUtils.ahk
#Include ../Utils/Input.ahk

class Region
{
    __New(x, y, w, h)
    {
        this.x = x
        this.y = y
        this.w = w
        this.h = h
    }

    x => this.x
    y => this.y
    w => this.w
    h => this.h
}

global inventoryRegion := Region(10, 10, 10, 10)
global bankRegion := Region(10, 10, 10, 10)
global textRegion := Region(10, 10, 10, 10)

ClickImageInRagion(region)
{

}


ClickImage(offSetx, offSety, imagePath, rightClick:=false, isShift:=false, offset:=true)
{
    if ImageSearch(&FoundX, &FoundY, 0, 0, 1150, 800, imagePath)
    {
        ; MsgBox "The icon was found at " FoundX "x" FoundY
        MoveMouse(FoundX + offSetx, FoundY + offSety, 0.4, offset)
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

SimpleImageClick(imagePath, minSleep)
{
    if ClickImage(7, 7, imagePath, false, false, true)
        RandomSleep(minSleep, 1.1 * minSleep)
    else
        OnError("Could not find image: " . imagePath)
}