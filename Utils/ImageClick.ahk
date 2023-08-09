#Requires AutoHotkey v2.0
#Include ../Utils/WindHumanMouse.ahk
#Include ../Utils/TimeUtils.ahk
#Include ../Utils/Input.ahk

ClickImage(offSetx, offSety, imagePath, rightClick:=false, isShift:=false, offset:=true)
{
    if ImageSearch(&FoundX, &FoundY, 0, 0, 750, 525, imagePath)
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
        return false
}

ClickImageInRegion(image, region, rightClick:=false, isShift:=false, offset:=true)
{
    ; if ImageSearch(&FoundX, &FoundY, region.x, region.y, region.w, region.y, image)
    if ImageSearch(&FoundX, &FoundY, 0, 0, 800, 500, image)
    {
        ; MsgBox "The icon was found at " FoundX "x" FoundY
        MoveMouse(FoundX, FoundY, 0.5, offset)
        if (isShift) 
            ShiftClick()
        else if (rightClick)
            Click "Right"
        else
            Click
        return true
    }
    else
        return false
}

SimpleImageClick(imagePath, minSleep)
{
    if ClickImage(7, 7, imagePath, false, false, true)
        RandomSleep(minSleep, 1.1 * minSleep)
    else
        OnError("Could not find image: " . imagePath)
}

SimpleImageShiftClick(imagePath, minSleep)
{
    if ClickImage(7, 7, imagePath, false, true, true)
        RandomSleep(minSleep, 1.1 * minSleep)
    else
        OnError("Could not find image: " . imagePath)
}

ClickImageWithConfirmationRetry(image, confirmationImage, minWait, region, tryNumber:=1)
{
    if ClickImageInRegion(image, region) {
        RandomSleep(minWait, 1.1 * minWait)
        ; if not ImageSearch(&FoundX, &FoundY, region.x, region.y, region.w, region.y, confirmationImage)
        if not ImageSearch(&FoundX, &FoundY, 0, 0, 800, 500, confirmationImage)
            ClickImageWithConfirmationRetry(image, confirmationImage, minWait, region, 2)
    } else if (tryNumber > 1) {
        OnError("Could not find image: " . image)
    } else {
        ClickImageWithConfirmationRetry(image, confirmationImage, minWait, region, 2)
    }
}

ConfirmImage(image) {
    return ImageSearch(&FoundX, &FoundY, 0, 0, 800, 500, image)
}

; New methods to make life easier

WaitForImage(image, timeout, pollRate := 300) {
    timeWaited := 0
    while timeWaited < timeout {
        if ConfirmImage(image) {
            return true
        } else {
            Sleep(pollRate)
            timeWaited := timeWaited + pollRate
        }
    }
}

WaitToClickImage(image, timeout, pollRate) {

}