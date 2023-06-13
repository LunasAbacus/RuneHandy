#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ../Utils/WindHumanMouse.ahk
#Include ../Utils/TimeUtils.ahk
#Include ../Utils/Inventory.ahk
#Include ../Utils/ImageClick.ahk
#Include ../Utils/Menu.ahk
#Include ../Utils/Bank.ahk

ShiloSmelt()
{
    ; Bank
    OpenBankImage("./Resources/15x15x000000.png")
    RandomSleep(3500, 3900)
    ClearInventory()
    WithdrawItemByImage("*5 ./Resources/items/gold_ore.png", true)
    CloseBank()

    ; Smelt
    OpenSmelter()
    Send "6"
    RandomSleep(85000, 90000, true)
}

OpenSmelter()
{
    if ClickImage(30, 30, "./Resources/15x15xFFFF00.png", false, false)
        RandomSleep(3700, 4100)
    else
        MsgBox("Could not find smelter")
}
