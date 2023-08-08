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
    superCombatCounter := 0
    absorptionCounter := 0

    __New(timeLimit)
    {
        this.timeLimit := timeLimit
        this.currentState := this.Attack
        this.absorptionCounter := 10 * 60
        this.superCombatCounter := 14 * 60
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

        ; drink combat every 14 minutes
        if this.superCombatCounter > 14 * 60 {
            this.DrinkSuperCombat()
        }

        ; drink absorption every 15 minutes
        if this.absorptionCounter > 7 * 60 {
            this.DrinkAbsorption()
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
            || ImageSearch(&FoundX, &FoundY, 0, 0, 750, 525, "*15 *TransBlack ./Resources/ui/StrengthXpIconTrans.png")
    }

    FlickPrayer()
    {
        ; TODO Click prayer, wait, click prayer
        ; 555 , 95
        MoveMouse(550, 90, 0.6, true)
        Click
        Sleep(100)
        Click
        
        Sleep(200)
        this.prayerFlickCounter := 0
    }

    DrinkSuperCombat()
    {
        if ClickImage(5, 5, "*45 *TransBlack ./Resources/items/potions/Super_combat_potion(1).png", false, false)
            this.superCombatCounter := 0    
        else if ClickImage(5, 5, "*45 *TransBlack ./Resources/items/potions/Super_combat_potion(2).png", false, false)
            this.superCombatCounter := 0    
        else if ClickImage(5, 5, "*45 *TransBlack ./Resources/items/potions/Super_combat_potion(3).png", false, false)
            this.superCombatCounter := 0    
        else if ClickImage(5, 5, "*45 *TransBlack ./Resources/items/potions/Super_combat_potion(4).png", false, false)
            this.superCombatCounter := 0    
        else
        {
            this.superCombatCounter := -100000
            MsgBox("Could find super combat potion")
        }

        Sleep(200)
    }

    DrinkAbsorption()
    {
        if ClickImage(5, 5, "*45 *TransBlack ./Resources/items/potions/Absorption_(1).png", false, false)
            this.absorptionCounter := 0    
        else if ClickImage(5, 5, "*45 *TransBlack ./Resources/items/potions/Absorption_(2).png", false, false)
            this.absorptionCounter := 0    
        else if ClickImage(5, 5, "*45 *TransBlack ./Resources/items/potions/Absorption_(3).png", false, false)
            this.absorptionCounter := 0    
        else if ClickImage(5, 5, "*45 *TransBlack ./Resources/items/potions/Absorption_(4).png", false, false)
            this.absorptionCounter := 0    
        else
        {
            this.absorptionCounter := -100000
            MsgBox("Could find absorption potion")
        }

        Sleep(200)
    }

    Wait()
    {
        sleepTime := 2
        Sleep(sleepTime * 1000)
        this.currentTime := this.currentTime + sleepTime
        this.prayerFlickCounter := this.prayerFlickCounter + sleepTime
        this.superCombatCounter := this.superCombatCounter + sleepTime
        this.absorptionCounter := this.absorptionCounter + sleepTime
    }
}

nmz := NightmareZone(500)

^d::
{
    nmz.DrinkSuperCombat()
}
