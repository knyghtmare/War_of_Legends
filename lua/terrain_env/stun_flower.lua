local x = wesnoth.current.event_context.x1
local y = wesnoth.current.event_context.y1
local units = wesnoth.units.find_on_map({x = x, y = y})
for i,u in ipairs(units) do
    -- stun does not work on level 0 units
    if (u.level != 0) then
        wesnoth.audio.play( "entangle.wav" )
        u.status.slowed = true
        wesnoth.current.map.get(x, y).terrain = wesnoth.current.map.get(x, y).base_terrain
    end
end