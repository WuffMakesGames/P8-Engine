
function import_sprite()
    local size = serial(0x802, 0x4300, 0x1000)
    local width,height = peek2(0x4300), peek2(0x4302)

    if not __sprite_data then
        cls(1)
        print("image dropped:",0,0,6)
        print(" width - "..width)
        print(" height - "..height)

        __sprite_data = { offset = 0, width = width, height = height }
    end

    local offset = abs(__sprite_data.offset)

    for i = 0,size do
        local col = peek2(0x4304 + i)
        local index = i + offset
        local x,y = index % __sprite_data.width, 128 + (index \ __sprite_data.width) - __sprite_data.height
        pset(x,y,col)
    end

    __sprite_data.offset += size
    if not stat(121) then
        __sprite_data = nil
    end
end
