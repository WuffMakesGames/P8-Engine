function draw_button(x,y,text,icon,col1,col2,active,tip,disabled)
    local width,height = (icon and 8 or 0) + #text*4, icon and 8 or 6
    local hover = not __modal and not __menu and inrect(mouse_x+peek2"0x5f28",mouse_y+peek2"0x5f2a",x,y,x+width,y+height)

    -- not visible
    if not inrect(x-peek2"0x5f28",y-peek2"0x5f2a",peek"0x5f20"-1,peek"0x5f21"-1,peek"0x5f22",peek"0x5f23") then
        return
    end

    -- draw
    pal(7, (active or hover) and col2 or col1)

    local offset = 0
    if icon then
        spr(icon,x,y)
        offset = 8 
    end
    ?text,x+offset,y,7

    pal(7,7)

    -- hover/press
    if not disabled and hover then
        if (tip) tooltip = tip

        mouse_spr = 2
        return mouse_lp
    end
end

function modal_confirm(title,callback)
    local width,height = 64,18
    local x1,y1 = 64-width*0.5,64-height*0.5
    local x2,y2 = x1+width, y1+height

    __modal = {
        draw = function(self)
            rectfill(x1+1,y1,x2-1,y2,8)
            rectfill(x1,y1+1,x2,y2-1,8)

            ?title,65-#title*2,y1+2,2
            line(x1+1,y1+8,x2-1,y1+8,2)

            __modal = nil
            if draw_button(x1+12,y2-6,"yes",false,2,15) then 
                if callback then callback() end
                return
            end
            if draw_button(x2-20,y2-6,"no",false,2,15) then 
                return
            end

            __modal = self
        end
    }
end

function modal_textinput(title,callback)
    local width,height = 64,24
    local x1,y1 = 64-width*0.5,64-height*0.5
    local x2,y2 = x1+width, y1+height
    local text,cursor_x = "", 0

    __modal = {
        draw = function(self)
            rectfill(x1+1,y1,x2-1,y2,8)
            rectfill(x1,y1+1,x2,y2-1,8)

            ?title,65-#title*2,y1+2,2
            line(x1+1,y1+8,x2-1,y1+8,2)
            
            __modal = nil
            if draw_button(x1+12,y2-6,"yes",false,2,15) then 
                if callback then callback(text) end
                return
            end
            if draw_button(x2-20,y2-6,"no",false,2,15) then 
                return
            end
            __modal = self
        end
    }
end

function new_menu(x,y)
    local tt,width = t(),32

    __menu = {
        items = {},
        add_item = function(self,name,callback)
            add(self.items, {"item",name,callback})
            width = max(#name*4+4,width)
            return self
        end,
        add_bar = function(self)
            add(self.items, {"bar"})
            return self
        end,
        draw = function(self)
            local off = 0
            for i,v in ipairs(self.items) do
                local top = y + off

                if v[1] == "item" then
                    local hover = inrect(mouse_x,mouse_y,x,top,x+width,top+8)

                    rectfill(x,top,x+width,top+6,hover and 7 or 6)
                    ?v[2],x+1,top+1,5

                    if mouse_lp and hover and v[3] then
                        v[3]()
                    end
                    off += 7
                elseif v[1] == "bar" then
                    rectfill(x,top,x+width,top,5)
                    off += 1
                end
            end

            if mouse_lp and tt ~= t() then
                __menu = nil
            end
        end
    }

    return __menu
end
