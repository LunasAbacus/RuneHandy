#Requires AutoHotkey v2.0
#Include Scripts/TeleAlch.ahk
#Include Scripts/JugsOfWine.ahk
#Include Scripts/OakLarders.ahk

; GUI Setup
MyGui := Gui()
MyGui.Add("Text",, "Pick a script to run")
LB := MyGui.Add("ListBox", "w640 r10 ym")
MyGui.Add("Text",, "Number of runs:")
MyGui.Add("Edit", "vNumberOfRuns")
MyGui.Add("Button", "Default", "OK").OnEvent("Click", RunScript)
MyGui.Add("Progress", "w200 h20 vMyProgress", 0)
MyGui.OnEvent("Close", Quit)
MyGui.OnEvent("Escape", Quit)

; Scripts list
scripts := Map()
scripts["CookingWine"] := CookWine
scripts["TeleAlch"] := TeleAlch
scripts["Larders"] := OakLarders
for k, v in scripts
    LB.Add([k])

MyGui.Show()

RunScript(*) {
    Saved := MyGui.Submit()

    script:= scripts[LB.Text]
    totalLoops := Saved.NumberOfRuns
    currentLoop := 0
    MyGui["MyProgress"].Value := 0

    while (currentLoop <= totalLoops)
    {
        ; Set focus to runelite
        WinActivate "ahk_exe RuneLite.exe"
        currentLoop++
        script.Call()
        MyGui["MyProgress"].Value := currentLoop / totalLoops * 100
    }
    MsgBox("Script completed.")
}

Quit(*) {
    ExitApp
}

Pause::Pause
