-- [draw] --
function _draw()
    cls()
    current_scene.draw()

    -- user interface
    ui_panel(0,0,128,8,8)

    -- cursor
    camera()
    line(mouse_x,mouse_y,mouse_x+3,mouse_y+(mouse_any and -3 or 3),7)
    camera(0,-1)
    line(mouse_x,mouse_y,mouse_x+3,mouse_y+(mouse_any and -3 or 3),0)
    camera()
end