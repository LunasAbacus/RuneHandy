#Requires AutoHotkey v2.0
#Include Scripts/TeleAlch.ahk
#Include Scripts/JugsOfWine.ahk
#Include Scripts/OakLarders.ahk
#HotIf WinActive("ahk_exe RuneLite.exe")

scripts := Map()
scripts["CookingWine"] := CookWine
scripts["TeleAlch"] := TeleAlch
scripts["Larders"] := OakLarders

MyGui := Gui()
MyGui.Add("Text",, "Pick a script to run")
LB := MyGui.Add("ListBox", "w640 r10")
LB.OnEvent("DoubleClick", RunScript)

for k, v in scripts
    LB.Add([k])

;MyGui.Add("Button", "Default", "OK").OnEvent("Click", LaunchFile)

MyGui.Add("Progress", "w200 h20 vMyProgress", 0)

MyGui.Show()

^s::
{
    ; RunScript(TeleAlch)
    ; RunScript(OakLarders)
}

RunScript(*) {
    ; Set focus to runelite
    WinActivate "ahk_exe RuneLite.exe"

    script:= scripts[LB.Text]
    totalLoops := 5
    currentLoop := 0

    while (currentLoop <= totalLoops)
    {
        currentLoop++
        script.Call()
        MyGui["MyProgress"].Value += 100/(totalLoops+1)
    }
    MsgBox("Script completed.")
}


Pause::Pause