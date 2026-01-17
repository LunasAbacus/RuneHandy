#Requires AutoHotkey v2.0
#Include Utils/TimeUtils.ahk
#Include Utils/WindHumanMouse.ahk
#Include Utils/JSON.ahk
#Include Utils/Inventory.ahk
#Include Utils/Input.ahk

CoordMode "Pixel", "Client"

endpoint := "http://127.0.0.1:8080/status"

^Up::{
    while (true) {
        try {
            response := ReadStatus()
            obj := JSON.parse(response)
            HandleRuneLiteInstruction(obj)
        } catch Error {
            MsgBox("Failed to parse command")
        }
    }
}

^D:: {
    ; Safety Dump
    WinActivate "RuneLite - Cinnador"
    DropInventoryKeepTools()
}

^Down::{
    WinActivate "RuneLite - Cinnador"
    try {
        response := ReadStatus()
        obj := JSON.parse(response)
        HandleRuneLiteInstruction(obj)
    } catch Error {
        MsgBox("Failed to parse command")
    }
}

ReadStatus() {
    try {
        http := ComObject("WinHttp.WinHttpRequest.5.1")
        http.Open("GET", endpoint, false)
        http.Send()

        if (http.Status != 200)
            return

        return Trim(http.ResponseText)
    } catch Error {
        ; server not running, ignore
        MsgBox("Failed to read from status from runelite server")
        return ""
    }
}

Quit(*) {
    ExitApp
}

Pause::Pause -1
