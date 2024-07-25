-- [update]
function _update60()
    local p = stat(34)
    mouse_x,mouse_y = stat(32),stat(33)
    mouse_wheel_x,mouse_wheel_y = stat(35),stat(36)
    
    mouse_lp,mouse_rp,mouse_mp,mouse_ap = not mouse_l and p==1, not mouse_r and p==2, not mouse_m and p==4, not mouse_p and p > 0
    mouse_l,mouse_r,mouse_m,mouse_p = p==1, p==2, p==4, p > 0

    -- scene update
    current_scene:update()
end