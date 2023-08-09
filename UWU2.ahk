#Requires AutoHotkey v2.0
#Include Scripts/OakLardersAdvanced.ahk

CoordMode "Pixel", "Client"

; GUI Setup
MyGui := Gui()
MyGui.Add("Text",, "Pick a script to run")
LB := MyGui.Add("ListBox", "w640 r10 ym")
MyGui.Add("Text",, "Number of runs:")
MyGui.Add("Edit", "vNumberOfRuns")
MyGui.Add("Button", "Default", "OK").OnEvent("Click", RunScript)
MyGui.OnEvent("Close", Quit)
MyGui.OnEvent("Escape", Quit)

; Scripts list
scripts := Map()

larders := OakLardersAdvanced()
scripts["Larders"] := larders

for k, v in scripts
    LB.Add([k])

MyGui.Show()

RunScript(*) {
    Saved := MyGui.Submit()
    ; TODO bring up new gui for progress bar
    ; MyGui.Add("Progress", "w200 h20 vMyProgress", 0)

    totalLoops := Saved.NumberOfRuns
    script:= scripts[LB.Text]
    script.SetIterations(totalLoops)
    
    currentLoop := 0
    ;MyGui["MyProgress"].Value := 0
    RandomSleep(1000,1500)

    while (script.Progress() <= 1)
    {
        ; Set focus to runelite
        WinActivate "RuneLite - Lunas Butkus"
        ;script.Call(nmz)
        script.Run()
        ;MyGui["MyProgress"].Value := currentLoop / totalLoops * 100
    }
    MsgBox("Script completed.")
    ; TODO Open original gui for script selection
}

Quit(*) {
    ExitApp
}

Pause::Pause -1
