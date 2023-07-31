#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ../Utils/WindHumanMouse.ahk
#Include ../Utils/TimeUtils.ahk
#Include ../Utils/Inventory.ahk
#Include ../Utils/ImageClick.ahk
#Include ../Utils/Menu.ahk
#Include ../Utils/Bank.ahk

class NightmareZone
{
    timeLimit := 0
    currentState := ""
    currentTime := 0
    prayerFlickCounter := 0

    __New(timeLimit)
    {
        this.timeLimit := timeLimit
        this.currentState := this.Attack
    }

	IterationNumber()
    {
        return this.currentTime
    }

	Run() { 
        this.currentState.Call(this) 
    }

    Attack()
    {
        if ClickImage(5, 5, "./Resources/butler.png", false, false)
        {
            this.currentState := this.Idle
            this.FlickPrayer()
        }
        this.Wait()
    }

    Idle()
    {
        ; flick prayer if time to do so
        if this.prayerFlickCounter > 30 {
            this.FlickPrayer()
        }

        ; check if in combat
        if not this.IsInCombat()
            this.currentState := this.Attack

        this.Wait()
    }

    IsInCombat()
    {
        ; TODO find a more respondant way to check
        ; TODO do for other combat styles
        return ImageSearch(&FoundX, &FoundY, 0, 0, 750, 525, "*15 *TransBlack ./Resources/ui/AttackXpIconTrans.png")
    }

    FlickPrayer()
    {
        ; TODO Click prayer, wait, click prayer
        ; 555 , 95
        MoveMouse(550, 90, 0.6, true)
        Click
        Sleep(100)
        Click

        this.prayerFlickCounter := 0
    }

    Wait()
    {
        Sleep(2000)
        this.currentTime++
        this.currentTime++
        this.prayerFlickCounter++
        this.prayerFlickCounter++
    }
}

nmz := NightmareZone(500)

^p::
{
    nmz.FlickPrayer()
}

^a::
{
    ClickImage(5, 5, "../Resources/butler.png", false, false)
}
