
function inrect(px,py,x1,y1,x2,y2)
    return px > x1 and px < x2 and py > y1 and py < y2
end

function clamp(val,mn,mx)
    return max(mn, min(val, mx))
end

function insert(str,index,value)
    return sub(str,1,index)..value..sub(str,index+1)
end

function substr(str,substr,start)
    local len = #substr
    start = start or 1

    for i = start,#str-len+1 do
        if sub(str,i,i+len-1) == substr then return i end
    end
    -- return -1
end

function find(tbl,value)
    for i,v in ipairs(tbl) do
        if v == value then return i end
    end
end

function table_to_string(tbl,prefix,suffix)
    local str = ""
    prefix = prefix or ""
    suffix = suffix or ""

    for i,v in ipairs(tbl) do
        str = prefix..str..v..suffix.."\n"
    end
    return str
end

-- function split_ext(string,separators,convert_numbers)
--     local output = {}

--     for i = 1,#separators do
--         local sep = separators[i]
--         printh(sep,"__debug_split_ext.txt")
--     end

--     return output
-- end