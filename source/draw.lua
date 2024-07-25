-- [draw]
function _draw()
    cls()

    -- scene draw
    current_scene:draw()

    -- menu
    draw_menu();
    (current_scene.draw_menu or t)()

    if tooltip then
        local tx,ty = clamp(mouse_x+6,0,128-#tooltip*4), clamp(mouse_y+6,0,122)
        ?"\#0"..tooltip,tx,ty,6
        tooltip = nil
    end

    -- modal
    if __modal then
        __modal:draw()
    end

    -- menu
    if __menu then
        __menu:draw()
    end

    -- cursor
    if mouse_spr > 0 and mouse_l then mouse_spr = 3 end
    outline(0, function() spr(mouse_spr,mouse_x-2,mouse_y-2) end)
    mouse_spr = 0

end

function outline(col,func)
    for i = 0,15 do pal(i,col) end
    for x = -1,1 do for y = -1,1 do if x&y == 0 then
        camera(x,y)
        func()
    end end end
    camera()
    pal()

    func()
end