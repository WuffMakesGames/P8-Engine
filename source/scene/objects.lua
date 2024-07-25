scene_objects = {}
__object_edit_mode = "init"
__objects_list_scroll,__objects_list_scroll_max = 0,0

function scene_objects.update()
    if inrect(mouse_x,mouse_y,12,0,86,8) then
        __objects_list_scroll -= mouse_wheel_y*4
        mouse_spr = 2
    end

    __objects_list_scroll = clamp(__objects_list_scroll, 0, __objects_list_scroll_max-24)

    -- edit
    local object_loaded = __objects[__object_id]
    if object_loaded then
        update_code_editor(0,17,128,111,object_loaded[__object_edit_mode])
    end
end

function scene_objects.draw()
    local object_loaded = __objects[__object_id]

    -- edit
    if draw_button(1,9,"new",false,1,6) then 
        add(__objects, new_object())
        __object_id = #__objects
    end

    if #__objects > 0 then
        if draw_button(21,9,"delete",false,1,6) then
            modal_confirm("delete object?", function()
                del(__objects, object_loaded)
                __object_id = clamp(__object_id, 1, #__objects)
            end)
        end

        -- edit modes
        if draw_button(54,9,"init",false,1,6,__object_edit_mode == "init") then __object_edit_mode = "init" end
        if draw_button(77,9,"update",false,1,6,__object_edit_mode == "update") then __object_edit_mode = "update" end
        if draw_button(108,9,"draw",false,1,6,__object_edit_mode == "draw") then __object_edit_mode = "draw" end

        -- lines
        line(16,9,16,13,1)
        line(48,9,48,13,1)
    end

    -- border
    line(0,15,128,15,1)

    -- editor
    if object_loaded then
        draw_code_editor(0,17,128,111,object_loaded[__object_edit_mode])
    end
end

function scene_objects.draw_menu()
    local offset,length = 0, #__objects
    clip(12,0,74,8)
    camera(__objects_list_scroll,0)

    for i = 0,length-1 do
        local title = __objects[i+1].init.lines[1]
        local label = sub(title,1,2) == "--" and sub(title,3) or tostr(i)

        local left,width = 14+offset, max(8, 4 + #label*4)
        local selected = i+1 == __object_id

        pal(7,selected and 7 or 14)

        spr(32,14+offset,1)
        rectfill(left+4,1,left+width-1,7,7)

        pal(7,7)
        ?label,left+3,2,8

        if mouse_lp and inrect(mouse_x,mouse_y,max(left-__objects_list_scroll, 12),0,min(left+width-__objects_list_scroll, 86),8) then
            __object_id = i+1
        end

        offset += width + 1
    end

    if #__objects > 0 and draw_button(14+offset,0,"",34,14,14) then
        add(__objects, new_object())
        __object_id = #__objects
    end

    __objects_list_scroll_max = offset
    
    camera()
    clip()
end

function new_object()
    return {
        init    = new_text_editor(),
        update  = new_text_editor(),
        draw    = new_text_editor(),
    }
end

__objects = {}
__object_id = -1