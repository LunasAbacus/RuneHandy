#Requires AutoHotkey v2.0
#SingleInstance Force

class StatusOverlay
{
    overlay := ""

    __New()
    {
        this.overlay := ""
    }

    Update()
    {

    }

    IsInCombat()
    {
        ; TODO find a more respondant way to check
        ; TODO do for other combat styles
        return ImageSearch(&FoundX, &FoundY, 0, 0, 750, 525, "*15 *TransBlack ./Resources/ui/AttackXpIconTrans.png")
    }
}

status := StatusOverlay()