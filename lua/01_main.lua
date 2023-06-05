--main
local maxNumber = 60

local lastNum = nil

function _init()
	initNumberManager(maxNumber)
end

function _update()
	nextNumber = getNextNumber()
end

function _draw()
	if nextNumber != nil then print(nextNumber) end
end
