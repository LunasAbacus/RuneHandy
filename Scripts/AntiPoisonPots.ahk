#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ../Utils/WindHumanMouse.ahk
#Include ../Utils/TimeUtils.ahk


^m::
{
	Send "{space}"
}

#HotIf WinActive("ahk_exe RuneLite.exe")
Numpad0::
{
	; Open Bank
	MoveMouse(143, 310, 0.4)
	Click
	RandomSleep(650, 900, True)
	
	; Deposit
	MoveMouse(675, 510, 0.4)
	Click
	RandomSleep(100, 200, False)
	
	; Withdraw Water
	MoveMouse(208, 240, 0.4)
	Send "+{Click}"
	RandomSleep(100, 300, False)
		
	; Withdraw Marrentil
	MoveMouse(355, 240, 0.4)
	Send "+{Click}"
	RandomSleep(100, 300, False)
	
	; Close Bank
	MoveMouse(737, 74, 0.4)
	Click
	RandomSleep(200, 300, False)
	
	; Combine
	MoveMouse(935, 555, 0.4)
	Click
	RandomSleep(100, 200, False)
	
	MoveMouse(1005, 555, 0.4)
	Click
	RandomSleep(1000, 1100, False)
	Send "{space}"
	RandomSleep(9000, 9500, False)
	
	; Open Bank
	MoveMouse(143, 310, 0.4)
	Click
	RandomSleep(650, 900, False)
	
	; Withdraw Dust
	MoveMouse(495, 240, 0.4)
	Send "+{Click}"
	RandomSleep(100, 300, False)
	
	; Close Bank
	MoveMouse(737, 74, 0.4)
	Click
	RandomSleep(200, 300, False)
	
	; Combine
	MoveMouse(935, 555, 0.4)
	Click
	RandomSleep(50, 150, False)
	
	MoveMouse(1005, 555, 0.4)
	Click
	RandomSleep(1000, 1100, False)
	Send "{space}"

	; Hover Bank
	RandomSleep(250, 300, False)
	MoveMouse(143, 310, 0.4)
	
	RandomSleep(16000, 17500, True)
	SoundBeep
}