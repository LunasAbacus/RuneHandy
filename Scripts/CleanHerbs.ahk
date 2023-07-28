#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ../Utils/WindHumanMouse.ahk
#Include ../Utils/TimeUtils.ahk
#Include ../Utils/Bank.ahk
#Include ../Utils/ImageClick.ahk
#Include ../Utils/Inventory.ahk

class HerbCleanStateMachine
{
	herb := ""
	iterations := 0
	estimatedTimePerIteration := 0

	currentState := ""

    __New(herb)
    {
		this.herb := herb

		this.estimatedTimePerIteration := 15500
		this.currentState := this.WithdrawHerbs
    }

    IterationNumber()
    {
        return this.iterations
    }

	Run() {
		this.currentState.Call(this)
	}

	WithdrawHerbs() {
		OpenBank(800)
		ClearInventory()

		; Withdraw herb
		WithdrawItemByImage(this.herb, true)
		
		CloseBank()
        this.currentState := this.CleanHerbs
	}

    CleanHerbs() {
        i := 1
        loop 28
        {
            ClickSlot(i++)
        }

		this.iterations++
        this.currentState := this.WithdrawHerbs
    }
}
