#Requires AutoHotkey v2.0
#SingleInstance Force
#Include ../Utils/World.ahk
#Include ../Utils/Inventory.ahk

class MiningStateMachine
{
	estMineTime := 3500

    currentOre := 0
    oreLimit := 1

	estimatedTimePerIteration := 0

	currentState := ""

    __New()
    {
		this.estimatedTimePerIteration := this.estMineTime * 28 + 10000
		this.currentState := this.Mine
    }

    SetIterations(oreLimit) {
        this.oreLimit := oreLimit
    }

    Progress() {
        if this.currentOre >= this.oreLimit
            return 1
        else
            return this.currentOre / this.oreLimit
    }

	Run() {
		this.currentState.Call(this)
	}

	Mine() {
        loop 7
        {
            ClickTile(Direction.North)
            RandomSleep(3000, 4000)
            ClickTile(Direction.East)
            RandomSleep(3000, 4000)
            ClickTile(Direction.South)
            RandomSleep(2500, 3000)
        }

		this.currentState := this.Drop
	}

	Drop() {
        DropInventory()
		
        this.currentOre := this.currentOre + 28
		this.currentState := this.Mine
	}

}
