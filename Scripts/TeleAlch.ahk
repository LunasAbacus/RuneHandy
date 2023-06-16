#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ../Utils/WindHumanMouse.ahk
#Include ../Utils/TimeUtils.ahk
#Include ../Utils/Bank.ahk
#Include ../Utils/Inventory.ahk
#Include ../Utils/Magic.ahk

TeleAlch()
{
    Alch("*25 ./Resources/items/runeArrows.png")
    OpenSpellbook()
    CamelotTeleport()
    RandomSleep(2300, 2500, False)
}