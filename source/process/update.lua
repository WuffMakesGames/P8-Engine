-- [update] --
poke(0x5f2d, 0x1)
function _update60()
    local p = stat(34)
    mouse_x,mouse_y = stat(32),stat(33)
    wheel_x,wheel_y = stat(35),stat(36)
    
    mouse_lp,mouse_rp,mouse_mp,mouse_pressed = not mouse_l and p==1, not mouse_r and p==2, not mouse_m and p==4, not mouse_any and p > 0
    mouse_l,mouse_r,mouse_m,mouse_any = p==1,p==2,p==4,p > 0

    -- scene update
    current_scene.update()
    ui_hovered = false
end