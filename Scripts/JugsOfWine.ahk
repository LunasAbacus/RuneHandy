#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ../Utils/WindHumanMouse.ahk
#Include ../Utils/TimeUtils.ahk
#Include ../Utils/Bank.ahk
#Include ../Utils/Inventory.ahk

CookWine()
{
    OpenBank()
    ClearInventory()
    WithDrawItem(2, 2, True)
    WithDrawItem(4, 1, True)
    CloseBank()
    CombineSlots(14, 15, 20000)
}