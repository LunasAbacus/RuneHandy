#Requires AutoHotkey v2.0

ShiftClick()
{
    Send "{Shift Down}"
	Sleep 75
	click
	Sleep 75
	Send "{Shift Up}"
}