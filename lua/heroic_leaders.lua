local res = {}

res.promote_to_heroic_leaders = function(args)
	local trait_heroic = args[1][2]
	for i, unit in ipairs(wesnoth.units.find_on_map { canrecruit = true }) do
		if not unit.variables.make_heroic_leader then
			unit:add_modification("trait", trait_heroic )
			unit.moves = unit.max_moves
			unit.hitpoints = unit.max_hitpoints
            -- do not allow it to stack
            unit.variables.make_heroic_leader = true
            -- debug message to check it worked or not
            print("%s at (%d,%d) has been adjusted", unit.id, unit.x, unit.y)
		end
	end
end