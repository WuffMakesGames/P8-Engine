scene_code = {}
__code_tabs_scroll,__code_tabs_scroll_max = 0,0

function scene_code.update()
    if inrect(mouse_x,mouse_y,12,0,86,8) then
        __code_tabs_scroll -= mouse_wheel_y*4
        mouse_spr = 2
    end

    -- clear empty tabs
    for i = #__code_tabs,max(__code_tab_id+1,2),-1 do
        local tab = __code_tabs[i]
        local lines = tab.lines

        if #lines == 1 and lines[1] == "" then
            del(__code_tabs,__code_tabs[i])
        end
    end

    -- edit
    local tab = __code_tabs[__code_tab_id]
    if tab then
        update_code_editor(0,9,128,119,tab)
    end

    __code_tabs_scroll = clamp(__code_tabs_scroll, 0, __code_tabs_scroll_max-24)
end

function scene_code.draw()
    local tab = __code_tabs[__code_tab_id]

    -- editor
    if tab then
        draw_code_editor(0,9,128,119,tab)
    end
end

function scene_code.draw_menu()
    local offset,length = 0, #__code_tabs
    clip(12,0,74,8)
    camera(__code_tabs_scroll,0)

    for i = 0,length-1 do
        local label = tostr(i)
        local title = __code_tabs[i+1].lines[1]

        local left,width = 14+offset, 4 + #label*4
        local selected = i+1 == __code_tab_id

        pal(7,(length > 1 and selected) and 7 or 14)

        spr(32,14+offset,1)
        rectfill(left+4,1,left+width-1,7,7)

        pal(7,7)
        ?label,left+3,2,8

        if inrect(mouse_x,mouse_y,max(left-__code_tabs_scroll, 12),0,min(left+width-__code_tabs_scroll, 86),8) then
            if (mouse_lp) __code_tab_id = i+1
            tooltip = sub(title,1,2) == "--" and title or ""
        end

        offset += width + 1
    end

    if draw_button(14+offset,0,"",34,14,14) then
        add(__code_tabs, new_tab())
        __code_tab_id = #__code_tabs
    end

    __code_tabs_scroll_max = offset
    
    camera()
    clip()
end

function new_tab()
    return new_text_editor()
end

__code_tabs = { new_tab() }
__code_tab_id = 1