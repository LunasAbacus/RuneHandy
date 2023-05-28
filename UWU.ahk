#Requires AutoHotkey v2.0
#Include Scripts/TeleAlch.ahk
#Include Scripts/JugsOfWine.ahk
#HotIf WinActive("ahk_exe RuneLite.exe")

scripts := Map()
scripts["CookingWine"] := CookWine
scripts["TeleAlch"] := TeleAlch

; OpenGui()

^s::
{
    ; RunScript(CookWine)
    ; OpenGui()
    RunScript(TeleAlch)
}

RunScript(script) {
    totalLoops := 20
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

OpenGui() {
    MyGui := Gui()
    MyGui.Add("Text",, "Pick a script to run")
    LB := MyGui.Add("ListBox", "w640 r10")
    ; LB.OnEvent("DoubleClick", LaunchFile)
    
    for k, v in scripts
        LB.Add([k])

    ;MyGui.Add("Button", "Default", "OK").OnEvent("Click", LaunchFile)
    MyGui.Show()
}

#x::ExitApp  ; Win+X