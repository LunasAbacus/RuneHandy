#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ../Utils/WindHumanMouse.ahk
#Include ../Utils/TimeUtils.ahk
#Include ../Utils/Inventory.ahk
#Include ../Utils/ImageClick.ahk
#Include ../Utils/Menu.ahk

OakLarders()
{
    ; Click rope pull get 24 planks
    foundButler:= DemonButler()

    ; Remove larder
    RemoveLarder(true)

    ; Wait ~6 seconds for butler to deliver items (takes 9 seconds total)
    RandomSleep(4000, 4300)
    
    ; Build larder
    BuildLarder()

    ; Remove larder
    RemoveLarder()

    ; Build larder
    BuildLarder()

    ; remove larder
    RemoveLarder()

    ; Build larder
    BuildLarder()

    ; Loop

    ; Every x loops handle paying butler

}

DemonButler()
{
    isButlerNextTile:= false
    if ClickImage(20, 20, "./Resources/butler.png", false, false)
    {
        ifButlerNextTile:= true
        RandomSleep(750, 850)
    } else
    {
        ClickImage(35, 50, "./Resources/20x20xFFFF00.png", false, false)
        RandomSleep(3700, 4000)
    }
    Send "1"
    return isButlerNextTile
}

RemoveLarder(firstTime:=false)
{
    ClickImage(55, 65, "./Resources/25x25x000000.png", true, false)
    SelectMenuItem(4)
    if (firstTime)
        RandomSleep(2000, 2500)

    RandomSleep(750, 850)
    Send "1"
    RandomSleep(1600, 2000)
}

BuildLarder()
{
    ClickImage(55, 65, "./Resources/25x25x000000.png", true, false)
    SelectMenuItem(3)
    RandomSleep(800, 900)
    Send "2"
    RandomSleep(2000, 2500)
}

^b::
{
    ; BuildLarder()
    ; RemoveLarder()
    OakLarders()
}