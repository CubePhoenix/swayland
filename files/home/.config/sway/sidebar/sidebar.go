package main

import (
    "fmt"
    "errors"
//    "image"
//    "image/color"
//    "image/draw"
    "github.com/veandco/go-sdl2/sdl"
    "github.com/veandco/go-sdl2/ttf"
//    "github.com/golang/freetype"
)

// Assign enums used for item alignment
type Align int
const (
    Top Align = 0
    Left Align = 0
    Center Align = 1
    Bottom Align = 2
    Right Align = 2
)

// Background color for the Sidebar
const BackgroundColor uint32 = 0x000f1a

// The size of the display
var display_bounds sdl.Rect

func main() {
    // Initialize a window
    surface, window, err := InitWindow()
    if err != nil {
        fmt.Println(err)
        return
    }
    defer window.Destroy()
    defer sdl.Quit()

    // Set the background color
    surface.FillRect(nil, BackgroundColor)

    // Render some text
    dst_rect := sdl.Rect{0, 0, surface.W, 200}
    text, err := DrawText("Test", 64, int32(surface.W), int32(200), Center, Center, sdl.Color{0xff, 0xff, 0xff, 0x00}, sdl.Color{0x00, 0x0f, 0x1a, 0x00}, false)
    if err != nil {
        fmt.Println(err)
        return
    }
    text.Blit(&sdl.Rect{0, 0, text.W, text.H}, surface, &dst_rect)

    // Make window visible
    window.UpdateSurface()

    // The main loop
    running := true
	for running {
		for event := sdl.PollEvent(); event != nil; event = sdl.PollEvent() {
			switch event.(type) {
			case *sdl.QuitEvent:
				println("Quit")
				running = false
				break
			}
		}
	}
}

func InitWindow() (surface *sdl.Surface, window *sdl.Window, err error) {
    if err := sdl.Init(sdl.INIT_EVERYTHING); err != nil {
        return nil, nil, err
	}

    if err := ttf.Init(); err != nil {
        return nil, nil, err
    }

    // Get the screen size
    display_bounds, err = sdl.GetDisplayBounds(0)
    if err != nil {
        return nil, nil, err
    }
    
    // Initialize the window
    window, err = sdl.CreateWindow("Sidebar", 0, 0,
		display_bounds.W / 4, display_bounds.H, sdl.WINDOW_TOOLTIP)
	if err != nil {
        return nil, nil, err
	}

    surface, err = window.GetSurface()
	if err != nil {
        return nil, nil, err
	}

    return surface, window, err
}

func DrawText(text string, size int, width int32, height int32, halignment Align, valignment Align,
    fcolor sdl.Color, bcolor sdl.Color, bold bool) (drawn_text *sdl.Surface, err error) {

        var font *ttf.Font

        // load font
        if (bold) {
            font, err = ttf.OpenFont("/usr/share/fonts/TTF/DejaVuSans-Bold.ttf", size)
        } else {
            font, err = ttf.OpenFont("/usr/share/fonts/TTF/DejaVuSans.ttf", size)
        }
        if err != nil {
            return nil, err
        }

        // Render text to surface
        text_surface, err := font.RenderUTF8Shaded(text, fcolor, bcolor)
        if err != nil {
            return nil, err
        }

        // validate surface size
        if (text_surface.W > width || text_surface.H > height) {
            return nil, errors.New("Specified surface size is too small to hold text")
        } 

        // Calculate vertical and horizontal position on surface
        var coordinate_x int32
        var coordinate_y int32
        
        switch halignment {
        case Left:
            coordinate_x = 0
        case Center:
            coordinate_x = (width - text_surface.W) / 2
        case Right:
            coordinate_x = width - text_surface.W
        }

        switch valignment {
        case Top:
            coordinate_y = 0
        case Center:
            coordinate_y = (height - text_surface.H) / 2
        case Bottom:
            coordinate_y = height - text_surface.H
        }

        dst_rect := sdl.Rect{coordinate_x, coordinate_y, coordinate_x + text_surface.W, coordinate_y + text_surface.H}

        // Prepare final surface
        drawn_text, err = sdl.CreateRGBSurface(0, width, height, 32, 0, 0, 0, 0)
        if err != nil {
            return nil, err
        }
        drawn_text.FillRect(nil, bcolor.Uint32())

        // Draw onto final surface (Text aligned)
        text_surface.Blit(&sdl.Rect{0, 0, text_surface.W, text_surface.H}, drawn_text, &dst_rect)
        
        return drawn_text, nil
}
