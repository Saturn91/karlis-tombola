--array_utils
ArrayUtil = {}
function ArrayUtil.GetRandomAndRemove(arr)
    local index = flr(rnd(#arr))
    return ArrayUtil.removeIndex(arr, index)
end

function ArrayUtil.removeIndex(arr, index)
    local output = arr[index]
    if #arr < index or index < 1 then
        return nil
    end

    for i=index,#arr-1 do
        arr[i]=arr[i+1]
    end

    arr[#arr] = nil

    return output;
end
