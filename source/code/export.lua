local code = [[
function _update()
    foreach(objects,function(o);
        (o.type.update or t)(o)
    end)

    if update then update() end
end

function _draw()
    cls()
    foreach(objects,function(o);
        (o.type.draw or t)(o)
    end)

    if draw then draw() end
end]]

local code_objects = [[
-- object code
local _g = _ENV
objects = {}

function new_object(_type,_x,_y)
    local _ENV = {}
    type,x,y =
    _type,_x,_y

    _g.setmetatable(_ENV, {__index=_g})

    if _type then
        _type.init(_ENV)
    end

    add(objects,_ENV)
    return _ENV
end

-- objects]]

function export_object(cartname,obj,id)
    local init_name = obj.init.lines[1]
    local name = sub(init_name,1,2) == "--" and sub(init_name,3) or "actor_"..id
    printh(name.." = {",cartname)

    printh(" init = function(_ENV)",cartname)
        printh(table_to_string(obj.init.lines,"  "),cartname)
    printh(" end,",cartname)

    printh(" update = function(_ENV)",cartname)
        printh(table_to_string(obj.update.lines,"  "),cartname)
    printh(" end,",cartname)

    printh(" draw = function(_ENV)",cartname)
        printh(table_to_string(obj.draw.lines,"  "),cartname)
    printh(" end,",cartname)

    printh("}\n",cartname)
end

function export(cartname,run)
    cartname = (cartname and cartname ~= "") and cartname..".p8l" or "untitled_picoengine_cart.p8l"
    printh("pico-8 cartridge // http://www.pico-8.com\nversion 38\n__lua__",cartname,true)
    printh("-- made with pico-engine\n",cartname)

    -- main code body
    printh(code,cartname)

    -- code tabs
    for i,v in ipairs(__code_tabs) do
        printh(table_to_string(v.lines),cartname)
    end

    -- objects
    printh(code_objects,cartname)

    for i,v in ipairs(__objects) do
        export_object(cartname,v,i)
    end

    if run then load(cartname,"return to editor") end
end
