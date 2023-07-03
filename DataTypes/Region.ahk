class Region
{
    x := 0
    y := 0
    w := 0
    h := 0

    __New(x, y, w, h)
    {
        this.x := Integer(x)
        this.y := Integer(y)
        this.w := Integer(w)
        this.h := Integer(h)
    }
}

; Main game zones
global controlRegion := Region(835, 350, 280, 380) ; 835,350 -> 1115,730
global gameRegion := Region(15, 45, 770, 500) ; 15,45 -> 785,545
global chatRegion := Region(15, 555, 760, 195) ; 15, 555 -> 775,750
