#Requires AutoHotkey v2.0
#Include Scripts/TeleAlch.ahk
#Include Scripts/JugsOfWine.ahk
#Include Scripts/OakLarders.ahk
#Include Scripts/Smelting.ahk

#Include Utils/Bank.ahk

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
scripts["CookingWine"] := CookWine
scripts["TeleAlch"] := TeleAlch
scripts["Larders"] := OakLarders
scripts["ShiloSmelt"] := ShiloSmelt
for k, v in scripts
    LB.Add([k])

MyGui.Show()

RunScript(*) {
    Saved := MyGui.Submit()
    ; TODO bring up new gui for progress bar
    ; MyGui.Add("Progress", "w200 h20 vMyProgress", 0)

    script:= scripts[LB.Text]
    totalLoops := Saved.NumberOfRuns
    currentLoop := 0
    ;MyGui["MyProgress"].Value := 0
    RandomSleep(2000,2500)

    while (currentLoop < totalLoops)
    {
        ; Set focus to runelite
        WinActivate "ahk_exe RuneLite.exe"
        currentLoop++
        script.Call()
        ;MyGui["MyProgress"].Value := currentLoop / totalLoops * 100
    }
    MsgBox("Script completed.")
    ; TODO Open original gui for script selection
}

Quit(*) {
    ExitApp
}

^k::
{
    WinActivate "ahk_exe RuneLite.exe"
    WinGetPos &X, &Y, &W, &H, "ahk_exe RuneLite.exe"
    OpenBankImage("./Resources/15x15x000000.png")
}

Pause::Pause -1
