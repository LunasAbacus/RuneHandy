#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ../Utils/WindHumanMouse.ahk
#Include ../Utils/TimeUtils.ahk
#Include ../Utils/Inventory.ahk
#Include ../Utils/ImageClick.ahk
#Include ../Utils/Menu.ahk
#Include ../Utils/Bank.ahk

class SmeltingStateMachine
{
	primary := ""
	secondary := ""
	smeltWaitTime := 0
	iterations := 0
	estimatedTimePerIteration := 0

	currentState := ""

    __New(primary, secondary, finished, smeltWaitTime)
    {
        this.primary := primary
		this.secondary := secondary
        this.finished := finished
		this.smeltWaitTime := smeltWaitTime

		this.estimatedTimePerIteration := smeltWaitTime + 5000
		this.currentState := this.WithdrawIngredients
    }

	IterationNumber()
    {
        return this.iterations
    }

	Run() {
		this.currentState.Call(this)
	}

	WithdrawIngredients() {
		OpenBankTile(4000)

		; ClearInventory()
        DepositItem(this.finished)

		WithdrawItemByImage(this.primary, true)

		if (this.secondary)
		    WithdrawItemByImage(this.secondary, true)
		
		CloseBank()

		this.currentState := this.Smelt
	}

	Smelt() {
        SimpleImageClick("*15 ./Resources/items/sapphire.png", 4000)
        Send "{Space}"
        RandomSleep(this.smeltWaitTime, this.smeltWaitTime * 1.1, true)
		
		this.currentState := this.WithdrawIngredients
	}

}

ShiloSmeltGold()
{
    ; Bank
    OpenBankImage("./Resources/15x15x000000.png")
    RandomSleep(3500, 3900)
    ClearInventory()
    WithdrawItemByImage("*25 ./Resources/items/gold_ore.png", true)
    CloseBank()

    ; Smelt
    OpenSmelter()
    Send "6"
    RandomSleep(85000, 90000, true)
}

ShiloJewleryMake()
{
    ; Bank
    OpenBankImage("./Resources/15x15x000000.png")
    RandomSleep(3500, 3900)

    ; Deposit jewelery

    WithdrawItemByImage("*25 ./Resources/items/sapphire.png", true)
    WithdrawItemByImage("*25 ./Resources/items/gold_bar.png", true)
    CloseBank()

    ; Smelt
    OpenSmelter()
    Send "{Space}"
    RandomSleep(20000, 21000, true)
}

OpenSmelter()
{
    if ClickImage(30, 30, "./Resources/15x15xFFFF00.png", false, false)
        RandomSleep(3900, 4200)
    else
        MsgBox("Could not find smelter")
}
