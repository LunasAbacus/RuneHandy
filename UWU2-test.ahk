#Requires AutoHotkey v2.0
#Include Utils/World.ahk
#Include Utils/Inventory.ahk

CoordMode "Pixel", "Client"

^Up:: ClickTile(Direction.North)
^Down:: ClickTile(Direction.South)
^Left:: ClickTile(Direction.West)
^Right:: ClickTile(Direction.East)

^D:: DropInventory()