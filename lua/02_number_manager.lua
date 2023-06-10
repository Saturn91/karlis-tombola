--number_manager
availableNumbers = {}

function initNumberManager(number)
    availableNumbers = {}

    for i=1,number do 
        availableNumbers[i] = i
    end
end

function getNextNumber()
    if #availableNumbers > 0 then
        return ArrayUtil.GetRandomAndRemove(availableNumbers)
    end
end
