local x = wesnoth.current.event_context.x1
local y = wesnoth.current.event_context.y1
local units = wesnoth.units.find_on_map({x = x, y = y})
for i,u in ipairs(units) do
    if not u.status.unpoisonable then
        wesnoth.audio.play( "naga-hit-3.ogg" )
        u.status.poisoned = true
        wesnoth.current.map.get(x, y).terrain = wesnoth.current.map.get(x, y).base_terrain
    end
end