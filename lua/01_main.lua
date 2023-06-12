--main
local maxNumber = 90

local lastNum = nil

function _init()
	initNumberManager(maxNumber)
	Controller.init()
	GFX.init()
end

function _update()
	Controller.update()
	GFX.update()
end

function _draw()
	cls(1)
	GFX.draw()
end
