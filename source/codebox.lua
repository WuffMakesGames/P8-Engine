-- [@codebox]
function codebox(x,y,w,h,bg)
	local box={}
	local lines,formatted,to_format_all = {""},""
	local scroll_x,scroll_y = 0,0

	-- methods
	function box.update()
		local hovered = inrect(mouse_x-x,mouse_y-y,0,0,w,h)
		if hovered then
			scroll_x -= wheel_x*12
			scroll_y -= wheel_y*12
		end
		scroll_x = max(scroll_x,0)
		scroll_y = mid(scroll_y,0,max(#lines*6-12,0))

		-- delayed
		if (to_format_all) box.highlight_all()
		to_format_all = false
	end

	function box.draw()
		srectfill(x,y,w,h,bg)
		clip(x,y,w,h)
		print(formatted,x+1-scroll_x,y+1-scroll_y,7)
		clip()
	end

	function box.clear() lines={""} end
	function box.insert(ix,iy,str)
		local dat,lineend=split(str,"\n",false)
		
		-- first line
		for i,lineadd in ipairs(dat) do
			local linecur = lines[iy+i] or ""
			local firstlast = i==1 or i==#dat

			if i==1 then
				lineend,linecur = sub(linecur,ix+1),sub(linecur,1,ix)..lineadd
			end
			if i==#dat do
				linecur=lineadd..lineend
				add(lines,"",iy+i)
			end

			if firstlast then lines[iy+i] = linecur
			else add(lines,lineadd,iy+i) end
		end
		to_format_all = true
	end
	function box.highlight_all()
		formatted = highlight(join("\n",unpack(lines)))
	end

	-- styling
	function box.rect(xx,yy,ww,hh) x,y,w,h = xx,yy,ww,hh end
	function box.bg(col) bg=col end

	return box
end