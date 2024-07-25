
function draw_menu()
    rectfill(0,0,127,7,8)

    line(11,0,11,7,2)
    line(87,0,87,7,2)

    -- buttons
    if draw_button(2,1,"",48,2,15,__menu) then 
        new_menu(0,9)
        :add_item("export as...", function() modal_textinput("cart name",export) end)
        :add_item("run cart", function() modal_confirm("run cart?",function() export("picoengine_tempcart",true) end) end)
        :add_bar()
        :add_item("paste")
    end

    -- scenes
    if draw_button(91,1,"",49,2,15,current_scene == scene_code, "code") then current_scene = scene_code end
    if draw_button(101,1,"",50,2,15,current_scene == scene_sprite, "sprites") then current_scene = scene_sprite end
    if draw_button(110,1,"",51,2,15,current_scene == scene_objects, "objects") then current_scene = scene_objects end
    if draw_button(119,1,"",52,2,15,current_scene == scene_map, "map") then current_scene = scene_map end

end
