#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ../Utils/WindHumanMouse.ahk
#Include ../Utils/TimeUtils.ahk
#Include ../Utils/Bank.ahk
#Include ../Utils/ImageClick.ahk
#Include ../Utils/Inventory.ahk

class ChinkGemsStateMachine
{
	chisel := ""
	rawGem := ""
	iterations := 0
	estimatedTimePerIteration := 0

	currentState := ""

    __New(chisel, rawGem, cutGem)
    {
		this.chisel := chisel
		this.rawGem := rawGem
		this.cutGem := cutGem

		this.estimatedTimePerIteration := 35000
		this.currentState := this.WithdrawGems
    }

    IterationNumber()
    {
        return this.iterations
    }

	Run() {
		this.currentState.Call(this)
	}

	WithdrawGems() {
		OpenBank(800)

		; Deposit cut gems
		SimpleImageShiftClick(this.cutGem, 1000)
		
		WithdrawItemByImage(this.rawGem, true)

		CloseBank()
        this.currentState := this.ChinkGems
	}

    ChinkGems() {
        CombineItems(this.chisel, this.rawGem, 32000)

		this.iterations++
        this.currentState := this.WithdrawGems
    }
}
