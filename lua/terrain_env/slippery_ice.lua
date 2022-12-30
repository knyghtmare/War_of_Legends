local x = wml.variables["x1"]
local y = wml.variables["y1"]
local dir = wesnoth.current.map.get_relative_dir({wml.variables["x2"],wml.variables["y2"]},{x,y})
while true do
    local p = wesnoth.current.map.get_direction({x,y}, dir)
    local vx, vy = wesnoth.paths.find_vacant_hex(p.x, p.y)
    local vacant = (p.x == vx) and (p.y == vy) and string.match(wesnoth.current.map.get(p.x, p.y).terrain, '[X_]') == nil
    if not vacant then
        break
    end
    wesnoth.audio.play( "miss-2.ogg" )
    wml.fire("move_unit", { x = x, y = y, dir = dir, check_passability = "no", fire_event = "yes"})
    x = vx
    y = vy
    if string.match(wesnoth.current.map.get(x, y).terrain, 'Ai') == nil then
        break
    end
end
wesnoth.current.map.set_owner(x, y, wesnoth.current.side)