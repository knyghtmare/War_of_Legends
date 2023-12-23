function wesnoth.micro_ais.envoy(cfg)
	if (cfg.action ~= 'delete') and (not cfg.id) and (not wml.get_child(cfg, "filter")) then
		wml.error("Envoy [micro_ai] tag requires either id= key or [filter] tag")
	end
	local required_keys = { waypoint = 'string' }
	local optional_keys = { id = 'string', enemy_death_chance = 'float', filter = 'tag', filter_second = 'tag', invert_order = 'boolean', messenger_death_chance = 'float' }
	local score = cfg.ca_score or 300000
	local CA_parms = {
		ai_id = 'mai_envoy',
		{ ca_id = 'attack', location = '~add-ons/War_of_Legends/lua/micro_ais/ca_envoy_attack.lua', score = score + 2 },
		{ ca_id = 'move', location = '~add-ons/War_of_Legends/lua/micro_ais/ca_envoy_move.lua', score = score + 10 },
		{ ca_id = 'escort_move', location = '~add-ons/War_of_Legends/lua/micro_ais/ca_envoy_escort_move.lua', score = score + 1 }
	}
    return required_keys, optional_keys, CA_parms
end