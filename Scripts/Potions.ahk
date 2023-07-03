#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ../Utils/WindHumanMouse.ahk
#Include ../Utils/TimeUtils.ahk
#Include ../Utils/Bank.ahk
#Include ../Utils/ImageClick.ahk
#Include ../Utils/Inventory.ahk

class PotionStateMachine
{
	vial := ""
	herb := ""
	unfPot := ""
	unfWaitTime := 0
	secondary := ""
	potWaitTime := 0
	iterations := 0
	estimatedTimePerIteration := 0

	currentState := ""

    __New(vial, herb, unfPot, secondary, unfWaitTime, potWaitTime)
    {
        this.vial := vial
		this.herb := herb
		this.unfPot := unfPot
		this.unfWaitTime := unfWaitTime
		this.secondary := secondary
		this.potWaitTime := potWaitTime

		this.estimatedTimePerIteration := unfWaitTime + potWaitTime + 5000
		this.currentState := this.WithdrawUnfIngredients
    }

	IterationNumber()
    {
        return this.iterations
    }

	Run() {
		this.currentState.Call(this)
	}

	WithdrawUnfIngredients() {
		; MsgBox("WithdrawUnfIngredients")
		OpenBank()
		ClearInventory()

		; Withdraw vial
		WithdrawItemByImage(this.vial, true)

		; Withdraw herb
		WithdrawItemByImage(this.herb, true)
		
		CloseBank()

		this.currentState := this.MakeUnfs
	}

	WithdrawPotIngredients() {
		; MsgBox("WithdrawPotIngredients")
		OpenBank()

		; Withdraw Secondary
		WithdrawItemByImage(this.secondary, true)
		
		CloseBank()
		this.currentState := this.MakePots
	}

	MakeUnfs() {
		; MsgBox("MakeUnfs")
		CombineItems(this.vial, this.herb, this.unfWaitTime)
		this.currentState := this.WithdrawPotIngredients
	}

	MakePots() {
		; MsgBox("MakePots")
		CombineItems(this.unfPot, this.secondary, this.potWaitTime)

		this.currentState := this.WithdrawUnfIngredients
		this.iterations++
		; MsgBox("Iteration #:" . this.iterations)
	}

}
