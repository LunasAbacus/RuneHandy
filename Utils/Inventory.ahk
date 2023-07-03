#Requires AutoHotkey v2.0
#Include ../Utils/WindHumanMouse.ahk
#Include ../Utils/TimeUtils.ahk
#Include ../Utils/Input.ahk
#Include ../Utils/ImageClick.ahk

global slot := 1


CombineSlots(slotNumberA, slotNumberB, minWait:=10000)
{
    ClickSlot(slotNumberA)
    ClickSlot(slotNumberB)
	RandomSleep(1000, 1100)
	Send "{space}"
	RandomSleep(minWait, minWait*1.1, True)
}

CombineItems(itemA, itemB, minWait)
{
	SimpleImageClick(itemA, 100)
	SimpleImageClick(itemB, 100)
	RandomSleep(1000, 1100)
	Send "{space}"
    RandomSleep(minWait, minWait * 1.1)
}

ClickSlot(slotNumber, shift:=False) {
    pos := SlotPosition(slotNumber)
    MoveMouse(pos.x, pos.y, 0.4, true)
    if (shift)
        ShiftClick()
    else
    	Click
    RandomSleep(50,100)
}

DropInventory() {
    i := 1
    loop 28
    {
        ClickSlot(i++)
        RandomSleep(100,150)
    }
}

;d::
;{
;    DropInventory()
;}


SlotPosition(slotNumber)
{
    slotNumber--

    column := slotNumber // 4
    row := Mod(slotNumber, 4)
    x := 570 + row * 41
    y := 220 + column * 38

    return {x:x, y:y}
}
