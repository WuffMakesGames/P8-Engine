-- [helpers] --
function inrect(px,py,x1,y1,x2,y2) return px<x2 and px>=x1 and py<y2 and py>=y1 end

-- strings
function concat(...) return join("",...) end
function join(delim,...)
	local out=""
	for s in all({...}) do out..=s..delim end
	return sub(out,1,#out-#delim)
end

-- drawing
function srect(x,y,w,h,c) rect(x,y,x+w-1,y+h-1,c) end
function srectfill(x,y,w,h,c) rectfill(x,y,x+w-1,y+h-1,c) end
