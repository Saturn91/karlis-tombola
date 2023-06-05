--main
local maxNumber = 60

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
	GFX.draw()
end
