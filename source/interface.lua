-- [user-interface] --
function ui_panel(x,y,w,h,c)
	local hovered = inrect(mouse_x-x,mouse_y-y,0,0,w,h)
	rectfill(x,y,x+w-1,y+h-1,c)
	ui_hovered = ui_hovered or hovered
end