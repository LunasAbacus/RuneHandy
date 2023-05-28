#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ../Utils/WindHumanMouse.ahk
#Include ../Utils/TimeUtils.ahk
#Include ../Utils/Bank.ahk
#Include ../Utils/Inventory.ahk
#Include ../Utils/Magic.ahk

TeleAlch()
{
    Alch()
    RandomSleep(400,500)
    CamelotTeleport()
    RandomSleep(2700, 3000, True)
}