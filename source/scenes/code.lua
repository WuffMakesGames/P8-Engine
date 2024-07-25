-- [@scene-code]
scene_code = { tabs={} }

scene_code_codebox = codebox(0,8,128,120,0)
scene_code_codebox.insert(0,0,"--empty project")
scene_code_codebox.insert(2,1,"--end")
scene_code_codebox.insert(24,0,"\n"..[[
-- demo???
local _g = _ENV

function _init()
	player = obj()
end

function _update()
	obj()
end

function _draw()
	cls()
	line(0,0,128,128,7)

	for i=0,1 do
		print("string",0,0,8)
	end
end

function obj()
	local _ENV = {}
	x,y = 64,64

	function draw(_ENV)
		circ(x,y,4,8)
	end

	return _ENV
end

str = [=[wrgwrwiorng
strinngnainoubrwg
]=] ]])
function scene_code.init()
end
function scene_code.update()
	scene_code_codebox.update()
end
function scene_code.draw()
	scene_code_codebox.draw()
end