#Requires AutoHotkey v2.0
#Include Utils/TimeUtils.ahk
#Include Utils/WindHumanMouse.ahk
#Include Utils/JSON.ahk
#Include Utils/Inventory.ahk
#Include Utils/Input.ahk

CoordMode "Pixel", "Client"
CoordMode "Mouse", "Client" 

endpoint := "http://127.0.0.1:8081/status"

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

^Down::{
    Send "{F3}"
}

^Right::{
    Loop {
        ; Wait between 5 and 10 minutes (in milliseconds)
        waitTime := Random(300000, 600000)
        Sleep waitTime

        ; Get current mouse position
        MouseGetPos &x, &y

        ; Move slightly (1–2 pixels in a random direction)
        offsetX := Random(-2, 2)
        offsetY := Random(-2, 2)

        ; Avoid no movement (0,0)
        if (offsetX = 0 && offsetY = 0)
            offsetX := 1

        ;MouseMove x + offsetX, y + offsetY, 0
        MoveMouse(x + offsetX, y + offsetY)
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
