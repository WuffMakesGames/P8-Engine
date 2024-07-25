__lua_globals = split"setmetatable,getmetatable,circfill,ovalfill,rectfill,cartdata,cocreate,coresume,costatus,rawequal,menuitem,foreach,camera,cursor,ipairs,unpack,cstore,memcpy,memset,reload,serial,cstore,reload,rawget,rawset,select,extcmd,assert,printh,color,fillp,print,tline,count,pairs,music,peek2,peek4,poke2,poke4,atan2,srand,yield,split,tonum,tostr,trace,flip,circ,oval,clip,fget,fset,line,palt,pget,pset,rect,sget,sset,sspr,deli,pack,next,btnp,mget,mset,peek,poke,band,bnot,bxor,ceil,lshr,rotl,rotr,sqrt,dget,dset,type,time,stat,stop,cls,pal,spr,add,all,del,btn,sfx,map,abs,bor,cos,flr,max,mid,min,rnd,sgn,shl,shr,sin,sub,chr,ord,run"
__lua_booleans = split"true,false"
__lua_keys = split"function,elseif,repeat,return,break,false,local,until,while,else,then,true,and,end,for,nil,not,do,if,in,or"

__text_blacklist = "…∧░➡️⧗▤⬆️☉🅾️◆█★⬇️✽●♥웃⌂⬅️▥❎🐱ˇ▒♪😐あいうえおかきくけこさしすせそたちつてとなにぬねのはひうへほまみむもやゆよらりるれろわんっやきゅきょ◜◝アイウエオカキクケコサシスセソタチツテトナニヌネノ"
__token_col_normal,__token_col_global,__token_col_data,__token_col_key,__token_col_comment = "\f6","\fb","\fc","\fe","\fd" -- 11,12,15,13

poke(0x5f5d,5)
function new_text_editor(text)
    return { 
        lines = {text or ""},
        lines_formatted = {text or ""},
        scroll_x = 0,
        scroll_y = 0,
        cursor_x = 0,
        cursor_y = 0,
        time = 0,
        paste = function(self)
            local clip = split(stat(4), "\n")
            for i = 1,#clip do
                local str = clip[i]
            end
        end,
        format = function(self)
            self.lines_formatted = {}
            printh(stat(93)..":"..stat(94)..":"..stat(95),"__debug_output.txt",true)

            
            local inside_comment,comment_start,comment_line = 0,0,0

            for i = 1,#self.lines do
                local line = self.lines[i]
                local newline = line

                -- comment
                if substr(line, "--[[") then
                    inside_comment = 2
                    comment_start = substr(line, "--[[")
                    comment_line = i
                end

                if substr(line, "--") then
                    newline = insert(newline,substr(line, "--")-1,__token_col_comment)
                    goto continue
                end

                if inside_comment > 0 then
                    if i == comment_line then
                        newline = insert(newline,comment_start-1,__token_col_comment)
                    elseif inside_comment == 2 then
                        newline = insert(newline,0,__token_col_comment)
                    end
                    goto continue
                end

                -- newline = insert(newline,comment-1,__token_col_comment)

                -- globals

                -- data

                -- keywords
                for key = 1,#__lua_keys do
                    local keyword,j = __lua_keys[key],1
                    
                    while j < #line do
                        local pos = substr(newline,keyword,j)
                        j += 1

                        if pos then
                            j = max(j,#keyword+pos)
                            newline = insert(newline,pos-1,__token_col_key)
                            newline = insert(newline,#keyword+pos+1,__token_col_normal)
                        end
                    end
                end

                ::continue::

                -- exit comment
                if inside_comment > 0 and (substr(newline, "]]") or inside_comment == 1) then
                    if inside_comment == 2 then
                        newline = insert(newline,substr(newline, "]]")+1,"\f"..__token_col_normal)
                    end
                    inside_comment,comment_start = 0,0
                end

                -- append
                self.lines_formatted[i] = newline
                printh(newline,"__debug_output.txt")
            end

        end,
        draw_line_formatted = function(self)

        end
    }
end

function update_code_editor(x,y,width,height,data)
    local hover = inrect(mouse_x,mouse_y,x,y,x+width,y+height)
    local lines,updated = data.lines, false
    data.time += 1

    if __modal or __menu then return end

    -- mouse
    if mouse_ap then
        data.time = 0
        data.selected = hover
    end

    -- scroll
    if hover then
        if mouse_ap then
            data.cursor_x = max((mouse_x-x-15) \ 4)
            data.cursor_y = ((mouse_y-y) \ 6)
        end
        
        data.scroll_y = clamp(data.scroll_y-mouse_wheel_y*2, 0, #lines - 4)
        data.scroll_x = clamp(data.scroll_x+mouse_wheel_x, 0, 256)
    end

    local cx,cy = data.cursor_x+1, data.cursor_y+1
    local line,key = lines[cy], stat(31)

    if btnp"0" then
        cx -= 1
        if cx < 1 and cy > 1 then
            cx = #lines[cy-1]+1
            cy -= 1
        end
    elseif btnp"1" then
        cx += 1
        if cx > #line+1 and cy < #lines then
            cx = 0
            cy += 1
        end
    elseif btnp"2" then
        cy -= 1
        if cy < 1  then
            cx = 0
        end
    elseif btnp"3" then
        cy += 1
        if cy > #lines then
            cx = #lines[cy-1]+1
        end
    elseif data.selected and key != "" then
        -- pause
        if key == "\r" or key == "p" then
        end
        
        -- modifiers
        if key == "ユ" then -- ctrl+v paste
            data:paste()
        elseif key == "を" then -- ctrl+c copy
        elseif key == "\r" then -- enter
            add(data.lines, sub(line,cx), cy+1)
            data.lines[cy] = sub(line,1,cx-1)
            cx = 1
            cy += 1
        elseif key == "\b" then -- backspace
            if cx == 1 then
                if cy > 1 then
                    cy -= 1
                    cx = #data.lines[cy]+1
                    data.lines[cy] =  data.lines[cy]..line
                    deli(data.lines,cy+1)
                end
            else
                data.lines[cy] =  sub(line,1,cx-2)..sub(line,cx)
                cx -= 1
            end
        elseif key == "\t" then -- tab
            data.lines[cy] = insert(line,cx-1," ")
            cx += 1
        elseif not substr(__text_blacklist,key) then -- keys
            data.lines[cy] = insert(line,cx-1,key)
            cx += 1
        end

        data:format()
        data.time = 0
    end

    data.cursor_y = clamp(cy-1,0,#data.lines-1)
    data.cursor_x = clamp(cx-1,0,#data.lines[data.cursor_y+1])
    poke(0x5f30,1)
end

function draw_code_editor(x,y,width,height,data)
    local lines = data.lines_formatted
    local offset = 15

    data.time += 1

    -- code
    clip(x,y-1,width,height+1)
    camera(-x,-y)
    
    -- sidebar
    line(13,0,13,height,1)

    -- cursor
    if data.selected and data.cursor_x >= data.scroll_x and data.time % 60 < 30 then
        local cx,cy = offset + (data.cursor_x-data.scroll_x)*4, (data.cursor_y-data.scroll_y)*6
        rectfill(cx,cy-1,cx+3,cy+4,8)
    end

    -- lines
    for i = 0,height \ 6 do
        local index = i + data.scroll_y
        local line = lines[index+1]

        if line then
            ?index, offset-#tostr(index)*4-2, i*6, 1
            ?line, offset-data.scroll_x*4, i*6, 6, 1
        end
    end

    camera()
    clip()
end