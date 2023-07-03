#Requires AutoHotkey v2.0

OnError(message) {
	SoundPlay "*-1"
	MsgBox("" . message)
	Pause
}