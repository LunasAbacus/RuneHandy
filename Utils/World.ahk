#Requires AutoHotkey v2.0

#Include ../Utils/WindHumanMouse.ahk
#Include ../Utils/TimeUtils.ahk
#Include ../Utils/Input.ahk
#Include ../DataTypes/Direction.ahk

; Player Tile client coords 390, 255
; Vertical tile distance to center 120
; Horizontal tile distance to center 120

global tile_distance_pixels := 120
global player_tile_x := 390
global player_tile_y := 255

ClickTile(direction) {
    x_offset := direction.x * tile_distance_pixels
    y_offset := direction.y * tile_distance_pixels

    client_x := player_tile_x + x_offset
    client_y := player_tile_y + y_offset

    MoveMouse(client_x, client_y, 0.6, true)
    Click
    RandomSleep(50,100)
}