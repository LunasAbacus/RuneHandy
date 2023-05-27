#Requires AutoHotkey v2.0
#Include Scripts/JugsOfWine.ahk
#HotIf WinActive("ahk_exe RuneLite.exe")

^s::
{
    RunScript(CookWine)
}

RunScript(script) {
    totalLoops := 3
    currentLoop := 0

    while (currentLoop <= totalLoops and !GetKeyState("CapsLock", "T"))
    {
        currentLoop++
        script.Call()
    }
    if (GetKeyState("CapsLock", "T"))
    {
        MsgBox("Script ended early due to Caplock enabled.")
    }
    else 
    {
        MsgBox("Script completed.")
    }
}

#x::ExitApp  ; Win+X