#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ../Utils/WindHumanMouse.ahk
#Include ../Utils/TimeUtils.ahk
#Include ../Utils/Inventory.ahk
#Include ../Utils/ImageClick.ahk
#Include ../Utils/Menu.ahk

larder := OakLardersAdvanced()

^1:: larder.TalkToButler()
^2:: larder.BuildLarder()
^3:: larder.RemoveLarder()

class OakLardersAdvanced
{
    currentPlanks := 0
    plankLimit := 1
    currentState := ""

    __New()
    {
        this.currentState := this.TalkToButler
    }

    SetIterations(plankLimit) {
        this.plankLimit := plankLimit
    }

	Progress() {
        if this.currentPlanks >= this.plankLimit
            return 1
        else
            return this.currentPlanks / this.plankLimit
    }

	Run() { 
        this.currentState.Call(this) 
    }

    TalkToButler() {
        tryNum := 0

        while(tryNum < 3) {
            ; Right click to avoid moving randomly
            if ClickImage(5, 5, "*15 ./Resources/colors/5x5xFF0000.png", true, false) {
                ; Found butler
                RandomSleep(150, 250)

                ; if find 'Talk To'
                if ClickImage(5, 3, "*15 ./Resources/ui/talkto.png", false, false) {
                    ; success
                    tryNum := 100    
                } else if ClickImage(5, 3, "*15 ./Resources/ui/cancel.png", false, false) {
                    ; else if find 'Cancel'
                }
                RandomSleep(900, 1000)
            } else if ClickImage(10, 10, "*15 ./Resources/colors/5x5xFFFF00.png", false, false) {
                ; Ring bell
                RandomSleep(3700, 4000)
            }

            if WaitForImage("*15 ./Resources/ui/ButlerConfirm.png", 6000) {
                tryNum := 100
                Send "1"
                RandomSleep(150,300)
                this.currentState := this.RemoveLarder
            } else if tryNum > 2 {
                MsgBox("Could not find Butler. Probably wandered off while trying to talk to him.")
            } else {
                tryNum++
            }
        }
    }

    RemoveLarder() {
        ClickImage(10, 10, "./Resources/25x25x000000.png", true, false)
        Sleep(300)
        if !ClickImage(2, 2, "*15 ./Resources/ui/Remove.png", false, false)
            ClickImage(5, 3, "*15 ./Resources/ui/cancel.png", false, false)
        
        if WaitForImage("*15 ./Resources/ui/RemoveLarderConfirmation.png", 3600) {
            Send "1"
            RandomSleep(1600, 2000)
        }
        this.currentState := this.BuildLarder
    }

    BuildLarder() {
        ; wait for planks to be in inventory
        if WaitForImage("*15 ./Resources/items/oakPlank.png", 4000) {
            ClickImage(10, 10, "./Resources/25x25x000000.png", true, false)
            Sleep(300)
            if !ClickImage(2, 2, "*15 ./Resources/ui/Build.png", false, false)
                ClickImage(5, 3, "*15 ./Resources/ui/cancel.png", false, false)
            
            if WaitForImage("*15 ./Resources/ui/BuildLarderConfirmation.png", 3600) {
                Send "2"
                RandomSleep(2100, 2600)
                this.currentPlanks := this.currentPlanks + 6
                ; TODO Butler or remove next depending on conditions
                if ConfirmImage("*15 ./Resources/items/oakPlank.png")
                    this.currentState := this.RemoveLarder
                else
                    this.currentState := this.TalkToButler
            }
        } else {
            ; if timeout, butler
            this.currentState := this.TalkToButler
        }
    }

}
