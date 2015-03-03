local utils = {}

function is_odd(x)
    if math.floor(x/2)*2 == x then return false else return true end
end

function utils.get_adjacent_tiles(x, y)
    local tmp = {}
    w, h, b = wesnoth.get_map_size()
    if y >=2 then
        tmp[1] = {x, y-1}
    end
    if x <= w-1 then
        if is_odd(x) == false then
            tmp[2] = {x+1, y}
            if y <= h-1 then
                tmp[3] = {x+1, y+1}
            end
        else
            if y >= 2 then
                tmp[2] = {x+1, y-1}
            end
            tmp[3] = {x+1, y}
        end
    end
    if y <= h-1 then
        tmp[4] = {x, y+1}
    end
    if x >= 2 then
        if is_odd(x) == false then
            tmp[6] = {x-1, y}
            if y <= h-1 then
                tmp[5] = {x-1, y+1}
            end
        else
            if y >= 2 then
                tmp[6] = {x-1, y-1}
            end
            tmp[5] = {x-1, y}
        end
    end

    for i = 1,6 do
        if tmp[i] ~= nil then
            local terrain = wesnoth.get_terrain(tmp[i][1], tmp[i][2])
            if string.find(terrain, 'X') ~= nil then tmp[i] = nil end
            if string.find(terrain, '_off') ~= nil then tmp[i] = nil end
        end
    end

    local res = {}
    for i = 1,6 do
        if tmp[i] ~= nil then
            table.insert(res, tmp[i])
        end
    end
    return res
end

function utils.sort_by_value(a, b)
    if a[2] > b[2] then return true else return false end
end

function utils.sort_by_defense(a, b)
    if a.def < b.def then
        return true
    else
        return false
    end
end

function utils.location_provide_healing(x,y)
    if string.find(wesnoth.get_terrain(x,y), 'V') ~= nil then
        return true
    end
    if string.find(wesnoth.get_terrain(x,y), 'Do') ~= nil then
        return true
    end
    return false
end

return utils
