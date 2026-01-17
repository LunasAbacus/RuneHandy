#Requires AutoHotkey v2.0
#Include Utils/World.ahk
#Include Utils/Inventory.ahk

CoordMode "Pixel", "Client"

bla := 60 / 100

^Up:: MsgBox("Answer: " . bla)
