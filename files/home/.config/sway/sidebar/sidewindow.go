package sidewindow

/*
##############################################################
# Section: Imports
##############################################################
*/

import (
    "github.com/veandco/go-sdl2/sdl"
    "github.com/veandco/go-sdl2/img"
    "github.com/veandco/go-sdl2/ttf"
    "errors"
)

/*
##############################################################
# Section: Constants & Fields
##############################################################
*/

var display_size Vector

/*
##############################################################
# Section: Basic Types
##############################################################
*/

type Vector struct {
    x int,
    y int,
}

type FractionVector struct {
    x float32,
    y float32,
}

// This wants to be an enum
type Align int
const (
    LEFT Align = 0
    TOP Align = 0
    CENTER Align = 1
    RIGHT Align = 2
    BOTTOM Align = 2
)

/*
###############################################################
# Section: Initialization
###############################################################
*/

func init() {
    // Get the display size
    bounds := sdl.GetDisplayBounds(0)
    display_size = Vector{bounds.W, bounds.H}
}

/*
###############################################################
# Section: Item & Container
###############################################################
*/

// Every type with a position and scale is considered an item.
type Item interface {
    position Vector,
    size Vector,
    Draw(*sdl.Surface) (error)
}

// This is the first (and the most important) item.
// It is used to group other items.
type Container struct {
    position Vector,
    size Vector,
    items map[string]Item,
    bgcolor uint32
}

// Move the item to a pixel position
func (cont Container) MoveItem(item string, pos Vector) {
    cont.items[item].position = pos
}

// Move the item to a fraction of the parent container size
func (cont Container) MoveItem(item string, pos FractionVector) {
    cont.items[item].position = Vector{pos.x * cont.size.x, pos.y * cont.size.y}
}

// Resize an Item to a specific pixel size
func (cont Container) ResizeItem(item string, size Vector) {
    cont.items[item].size = size
}

// Resize an Item to a fraction of the parent container size
func (cont Container) ResizeItem(item string, size FractionVector) {
    cont.items[item].size = Vector{size.x * cont.size.x, size.y * cont.size.y}
}

// draw a container
// The container will let each item draw onto its own surface and then draw that onto the main surface
func (cont Container) Draw(surf *sdl.Surface) (err error) {
    csurface, err := sdl.CreateRGBSurface(0, cont.size.x, cont.size.y, 32, 0, 0, 0, 0)
    if err != nil {
        return err
    }
    defer csurface.Free()

    // color the surface according to background color
    csurface.FillRect(nil, cont.bgcolor)

    // let each item draw onto the surface
    for _, val := range cont.items {
        err := val.Draw(csurface)
        if err != nil {
            return err
        }
    }

    // draw the surface onto the surface of the parent
    src_rect := sdl.Rect{0, 0, cont.size.x, cont.size.y}
    dst_rect := sdl.Rect{cont.position.x, cont.position.y, cont.position.x + cont.size.x, cont.position.y + cont.size.y}
    csurface.Blit(&src_rect, surf, &dst_rect)

}

// Addd an item to the container
func (cont Container) AddItem(name string, item Item) {
    cont.items[name] = item
}

// Get an item from the container
func (cont Container) GetItem(name string) (item *Item) {
    return &cont.items[name]
}


/*
####################################################################
# Section: Basic item types
####################################################################
*/

type Label struct {
    position Vector,
    size Vector,
    text string,
    textsize int,
    valign Align,
    halign Align,
    color uint32,
    bold bool
}

func (label Label) Draw(surf *sdl.Surface) (err error) {
    
}
