-- to make code shorter
local wml_actions = wesnoth.wml_actions

-- metatable for GUI tags
local T = wml.tag

-- support for translatable strings, custom textdomain
local _ = wesnoth.textdomain "wesnoth-War_of_Legends"
-- #textdomain wesnoth-AotW

--! [store_shroud]
--! melinath

-- Given side= and variable=, stores that side's shroud data in that variable
-- Example:
-- [store_shroud]
--     side=1
--     variable=shroud_data
-- [/store_shroud]

function wml_actions.store_shroud(cfg)
	local side = wesnoth.sides.find( cfg )[1] or wml.error("No matching side found in [store_shroud]")
	local variable = cfg.variable or wml.error("Missing required variable= attribute in [store_shroud].")
	local current_shroud = side.__cfg.shroud_data
	wml.variables[variable] = current_shroud
end

--! [set_shroud]
--! melinath

-- Given shroud data, removes the shroud in the marked places on the map.
-- Example:
-- [set_shroud]
--     side=1
--     shroud_data=$shroud_data # stored with store_shroud, for example!
-- [/set_shroud]

function wml_actions.set_shroud(cfg)
	local side = wesnoth.sides.find( cfg )[1] or wml.error("No matching side found in [set_shroud]")
	local shroud_data = cfg.shroud_data or wml.error("Missing required shroud_data= attribute in [set_shroud]")

	if shroud_data == nil then wml.error("[set_shroud] was passed an empty shroud string")
        -- shroud data can contain only pipes, 0, 1 and newlines
	elseif string.sub(shroud_data,1,1) ~= "|" or string.match(shroud_data,"[^|01\n]") then
		wml.error("[set_shroud] was passed an invalid shroud string")
	else
		-- yes, I prefer long variable names. I think that they make the code more understandable. E_H.
		local width = wesnoth.current.map.playable_width
		local height = wesnoth.current.map.playable_height
		local border = wesnoth.current.map.border_size

		-- you might think that I could've converted this tag to just use wesnoth.sides.place_shroud()
                -- and be done with it.
                -- Think again: the purpose of [set_shroud] is to restore the shroud exactly as it was 
                -- stored by [store_shroud], which means also clearing the hexes that didn't have it.

		local to_shroud = {}
                local to_clear = {}
		local shroud_x = ( 1 - border )

		for row in string.gmatch ( shroud_data, "|(%d*)" ) do
			local shroud_y = ( 1 - border )
			for column in string.gmatch ( row, "%d" ) do
				if column == "0" then
					-- I tend to confuse them, so better specify: x are columns and y are rows. E_H.
					table.insert( to_shroud, { shroud_x, shroud_y } )
				elseif column == "1" then
					table.insert( to_clear, { shroud_x, shroud_y } )
				end
				shroud_y = shroud_y + 1
			end
			shroud_x = shroud_x + 1
		end

		if not side.shroud then
			side.shroud = true
		end

		wesnoth.sides.place_shroud( side.side, to_shroud )
                wesnoth.sides.remove_shroud( side.side, to_clear )
	end
end

--! [save_map],[load_map]
--! silene

--The [save_map] and [load_map] tags store and retrieve map data in a WML variable;
-- useful for dealing with dynamically modified yet persistent maps. They take a
-- variable=.
-- Example:
-- [save_map]
--     variable=saved_map[1].map
-- [/save_map]
-- [load_map]
--     variable=saved_map[1].map
-- [/load_map]

function wml_actions.save_map(cfg)
	local variable = cfg.variable or wml.error "[save_map] missing required variable= attribute"
	local width = wesnoth.current.map.playable_width
	local height = wesnoth.current.map.playable_height
	local border = wesnoth.current.map.border_size
	local t = {} -- not table, to avoid overriding the table library!

	for y = 1 - border, height + border do
		local row = {}

		for x = 1 - border, width + border do
			row[ x + border ] = wesnoth.current.map[{x, y}]
		end

		t[ y + border ] = table.concat ( row, ', ' )
	end

	wml.variables[variable] = table.concat(t, '\n')
end

function wml_actions.load_map(cfg)
	local variable = cfg.variable or wml.error "[load_map] missing required variable= attribute"
	wml_actions.replace_map { map_data = wml.variables[variable], expand = true, shrink = true }
end

--! [narrate]
--! originally by silene, rewritten by Elvish_Hunter

-- shortcut for a [message] tag spoken by the narrator.

function wml_actions.narrate(cfg)
	local cfg = cfg.__literal
	cfg.speaker = "narrator"
	if not cfg.image then cfg.image = "wesnoth-icon.png" end
	wml_actions.message( cfg )
end

local function flash(red,green,blue)
	-- usage: call this function by specifying the maximum values for each color. Don't go above 100.
	wml_actions.color_adjust { red = mathx.round(red * 0.67), green = mathx.round(green * 0.67), blue = mathx.round(blue * 0.67) }
	wml_actions.color_adjust { red = red, green = green, blue = blue }
	wml_actions.color_adjust { red = mathx.round(red * 0.33), green = mathx.round(green * 0.33), blue = mathx.round(blue * 0.33) }
	wml_actions.color_adjust { red = 0, green = 0, blue = 0 }
end

function wml_actions.flash_color(cfg)
	local red = tonumber(cfg.red) or wml.error("[flash_color] is missing required red= attribute")
	local green = tonumber(cfg.green) or wml.error("[flash_color] is missing required green= attribute")
	local blue = tonumber(cfg.blue) or wml.error("[flash_color] is missing required blue= attribute")

	flash( red, green, blue )
end

function wml_actions.flash_screen(cfg)
	local color = cfg.color or wml.error("[flash_screen] is missing required color= attribute")
	if color == "white" then
		flash( 100, 100, 100 )
	elseif color == "red" then
		flash( 100, 0, 0 )
	elseif color == "green" then
		flash( 0, 100, 0 )
	elseif color == "blue" then
		flash( 0, 0, 100 )
	elseif color == "magenta" or color == "fuchsia" then
		flash( 100, 0, 100 )
	elseif color == "yellow" then
		flash( 100, 100, 0 )
	elseif color == "cyan" or color == "aqua" then
		flash( 0, 100, 100 )
	elseif color == "purple" then
		flash( 50, 0, 50 )
	elseif color == "orange" then
		flash( 100, 65, 0 )
	elseif color == "black" then
		flash( -100, -100, -100 )
	else
		wml.error("Unsupported color in [flash_screen]")
	end
end

function wml_actions.nearest_hex(cfg)
	local starting_x = tonumber(cfg.starting_x) or wml.error("Missing required starting_x in [nearest_hex]")
	local starting_y = tonumber(cfg.starting_y) or wml.error("Missing required starting_y in [nearest_hex]")
	local filter = (wml.get_child(cfg, "filter_location")) or wml.error("Missing required [filter_location] in [nearest_hex]")
	local variable = cfg.variable or "nearest_hex" -- default

	local current_distance = math.huge -- feed it the biggest value possible
	local nearest_hex_found

	for index,location in ipairs(wesnoth.map.find(filter)) do
		local distance = wesnoth.map.distance_between( starting_x, starting_y, location[1], location[2] )
		if distance < current_distance then
			current_distance = distance
			nearest_hex_found = location
		end
	end

	if nearest_hex_found then
		wml.variables[variable] = { x = nearest_hex_found[1], y = nearest_hex_found[2], terrain = wesnoth.current.map[{nearest_hex_found[1], nearest_hex_found[2]}] }
	else wesnoth.interface.add_chat_message( "WML", "No suitable location found by [nearest_hex]" )
	end
end

function wml_actions.nearest_unit(cfg)
	local starting_x = tonumber(cfg.starting_x) or wml.error("Missing required starting_x in [nearest_unit]")
	local starting_y = tonumber(cfg.starting_y) or wml.error("Missing required starting_y in [nearest_unit]")
	local filter = (wml.get_child(cfg, "filter")) or wml.error("Missing required [filter] in [nearest_unit]")
	local variable = cfg.variable or "nearest_unit" -- default

	local current_distance = math.huge -- feed it the biggest value possible
	local nearest_unit_found

	for index,unit in ipairs(wesnoth.units.find_on_map(filter)) do
		local distance = wesnoth.map.distance_between( starting_x, starting_y, unit.x, unit.y )
		if distance < current_distance then
			current_distance = distance
			nearest_unit_found = unit
		end
	end

	if nearest_unit_found then
		wml_actions.store_unit( { variable = variable, { "filter", { id = nearest_unit_found.id } } } )
	else wesnoth.interface.add_chat_message( "WML", "No suitable unit found by [nearest_unit]" )
	end
end

-- to store unit defense
function wesnoth.wml_actions.get_unit_defense(cfg)
	local filter = wesnoth.units.find_on_map(cfg)
	local variable = cfg.variable or "defense"

	for index, unit in ipairs(filter) do
		local terrain = wesnoth.current.map[{unit.x, unit.y}]
		-- it is WML defense: the lower, the better. Converted to normal defense with 100 -
		local defense = 100 - wesnoth.units.chance_to_be_hit ( unit, terrain )
		wml.variables[string.format("%s[%d]", variable, index - 1)] = { id = unit.id, x = unit.x, y = unit.y, terrain = terrain, defense = defense }
	end
end

local _ = wesnoth.textdomain "wesnoth"
-- #textdomain wesnoth

function wml_actions.slow(cfg)
	for index, unit in ipairs(wesnoth.units.find_on_map(cfg)) do
		if unit.valid and not unit.status.slowed then
			unit.status.slowed = true
			if unit.__cfg.gender == "female" then
				wesnoth.interface.float_label( unit.x, unit.y, string.format("<span color='red'>%s</span>", tostring( _"female^slowed" ) ) )
			else
				wesnoth.interface.float_label( unit.x, unit.y, string.format("<span color='red'>%s</span>", tostring( _"slowed" ) ) )
			end
		end
	end
end

function wml_actions.poison(cfg)
	for index, unit in ipairs(wesnoth.units.find_on_map(cfg)) do
		if unit.valid and not unit.status.poisoned and not unit.status.not_living then
			unit.status.poisoned = true
			if unit.__cfg.gender == "female" then
				wesnoth.interface.float_label(unit.x, unit.y, string.format("<span color='red'>%s</span>", tostring( _"female^poisoned" ) ) )
			else
				wesnoth.interface.float_label(unit.x, unit.y, string.format("<span color='red'>%s</span>", tostring( _"poisoned" ) ) )
			end
		end
	end
end

function wml_actions.unpoison(cfg) -- removes poison from all units matching the filter.
	for index, unit in ipairs(wesnoth.units.find_on_map(cfg)) do
		if unit.valid then unit.status.poisoned = nil end
	end
end

function wml_actions.unslow(cfg) -- removes slow from all units matching the filter.
	for index, unit in ipairs(wesnoth.units.find_on_map(cfg)) do
		if unit.valid then unit.status.slowed = nil end
	end
end

local function fade( value, delay ) -- equivalent to FADE_STEP WML macro
	wml_actions.color_adjust { red = value, green = value, blue = value }
	wesnoth.interface.delay( delay )
	wml_actions.redraw {}
end

function wml_actions.fade_to_black(cfg) -- replaces FADE_TO_BLACK macro
	local interval = tonumber( cfg.interval or 5 )

	for value = -32, -224, -32 do
		fade( value, interval )
	end
end

function wml_actions.fade_to_black_hold(cfg) -- replaces FADE_TO_BLACK_HOLD macro
	local delay = tonumber( cfg.delay ) or wml.error( "Missing delay= in [fade_to_black_hold]" )
	local interval = tonumber( cfg.interval or 5 )

	for value = -32, -192, -32 do
		fade( value, interval )
	end

	fade( -224, delay )
end

function wml_actions.fade_in(cfg) -- replaces FADE_IN macro
	local interval = tonumber( cfg.interval or 5 )

	for value = -224, 0, 32 do
		fade( value, interval )
	end
end

function wml_actions.fade_to_white(cfg) -- similar to a theoretical FADE_TO_WHITE macro
	local interval = tonumber( cfg.interval or 5 )
	for value = 32, 224, 32 do
		fade( value, interval )
	end
end

function wml_actions.fade_to_white_hold(cfg) -- like a FADE_TO_WHITE_HOLD macro
	local delay = tonumber( cfg.delay ) or wml.error( "Missing delay= in [fade_to_black_hold]" )
	local interval = tonumber( cfg.interval or 5 )

	for value = 32, 192, 32 do
		fade( value, interval )
	end

	fade( 224, delay )
end

function wml_actions.fade_in_from_white(cfg) -- use after [fade_to_white] or [fade_to_white_hold]
	local interval = tonumber( cfg.interval or 5 )

	for value = 224, 0, -32 do
		fade( value, interval )
	end
end

function wml_actions.scatter_units(cfg) -- replacement for SCATTER_UNITS macro
	local locations = wesnoth.map.find( wml.get_child( cfg, "filter_location" ) ) or wml.error( "Missing required [filter_location] in [scatter_units]" )
	local unit_string = cfg.unit_types or wml.error( "Missing required unit_types= in [scatter_units]" )
	local units = tonumber( cfg.units ) or wml.error( "Missing or wrong required units= in [scatter_units]" )
	local scatter_radius =  tonumber( cfg.scatter_radius ) -- not mandatory, if nil cycle will be jumped
	local unit_table = wml.parsed( wml.get_child( cfg, "wml" ) ) or {} -- initialize as empty table, just in need

	local unit_types = {} -- create a table, then append each value after splitting with string.gmatch.

	for value in string.gmatch( unit_string, "[^%s,][^,]*" ) do
		table.insert( unit_types, value )
	end

	if #locations <=0 then return -- if no locations, end
	else
		repeat -- repeat cycle is executed at least once
			local rand_locs = "1.." .. #locations -- concatenation for use by WML rand
			local rand_units = "1.." .. #unit_types
			local index = mathx.random_choice( rand_locs ) -- use helper.rand, to avoid OOS errors
			local index2 = mathx.random_choice( rand_units )
			local where_to_place = locations[index]

			local unit_to_put = unit_table
			unit_to_put.type = unit_types[index2]

			local free_x, free_y = wesnoth.paths.find_vacant_hex( where_to_place[1], where_to_place[2], unit_to_put)
			-- to avoid placing units in strange terrains, or overwriting, in case that the WML coder placed a wrong filter;
			-- in such case, respect of scatter_radius is not guaranteed, exactly like in SCATTER_UNITS

			unit_to_put.x, unit_to_put.y = free_x, free_y
			wesnoth.units.to_map( unit_to_put )
			table.remove( locations, index ) -- to remove such location from the available list, because it's already busy, and avoid overwriting already placed units
			if scatter_radius then -- loop for scatter_radius; will remove every location within the radius
				-- apparently, a reversed ipairs like below is the best way to check every location
				-- and remove those that are too close
				-- using standard ipairs jumps some locations
				for index = #locations, 1, -1 do --lenght of locations, until 1, step -1
					local distance = wesnoth.map.distance_between( where_to_place[1], where_to_place[2], locations[index][1], locations[index][2] )

					if distance < scatter_radius then
						table.remove( locations, index )
					end
				end
			end

			units = units - 1 -- counter variable
		until units <= 0 or #locations <= 0
	end
end

-- [unknown_message], by Espreon, with modifications by Elvish_Hunter
--[[ usage:
[unknown_message]
	message=_"Hi"
	color=2
	caption = _ "WesnothAI"
	right = yes/no
[/unknown_message] ]]
function wml_actions.unknown_message(cfg)
	local message = cfg.message or
		wml.error "[unknown_message] missing required message= attribute"
	local image

	if type(cfg.color) == "string" then
		image = string.format("units/unknown-unit.png~RC(magenta>%s)", cfg.color)
	elseif type(cfg.color) == "number" then
		image = string.format("units/unknown-unit.png~TC(%d,magenta)", cfg.color)
	else -- if cfg.color is nil, table, or whatever else
		image = "units/unknown-unit.png"
	end

	if cfg.right then
		image = image .. "~RIGHT()"
	end

	wml_actions.message { speaker = "narrator", message = cfg.message, caption = cfg.caption, image = image, duration = cfg.duration, side_for = cfg.side_for, sound = cfg.sound }
end

-- [whisper]: a replacement for both WHISPER and ASIDE macros
--	[whisper]
--		message=_"Message"
--		caption=_"A unit"
--		sound=gold.ogg
--	[/whisper]
function wml_actions.whisper( cfg )
	local message = string.format ( "<small><i>%s</i></small>", tostring( cfg.message ) )
	wml_actions.message { speaker = cfg.speaker or "narrator",
				image = cfg.image or "wesnoth-icon.png",
				caption = cfg.caption,
				message = message,
				duration = cfg.duration,
				side_for = cfg.side_for,
				sound = cfg.sound }
end

function wml_actions.random_number( cfg )
	wesnoth.deprecated_message('[random_number]', 1, '1.0', 'Use [set_variable]rand=a..b instead')
	local lowest = tonumber( cfg.lowest ) or wml.error( "Missing or wrong lowest= attribute in [random_number]" )
	local highest = tonumber( cfg.highest ) or wml.error( "Missing or wrong highest= attribute in [random_number]" )
	local variable = cfg.variable or "random"

	-- does not work in start event
	local result = wesnoth.sync.evaluate_single( function()
    		return { value = math.random( lowest, highest ) }
	end)

	wml.variables[variable] = result.value
end

function wml_actions.earthquake( cfg )
	local counter = cfg.times or 1
	local delay = cfg.delay or 50
	local coordinates = { {5,0},{-10,0},{-5,5},{0,-10},{0,5} }
	repeat
		wesnoth.audio.play( "rumble.ogg" )
		for i, v in ipairs( coordinates ) do
			wesnoth.interface.scroll( v[1], v[2] )
			wesnoth.interface.delay( delay )
		end
		counter = counter - 1
	until counter <= 0
end

-- [loot]: replacement for mainline LOOT macro
-- supported parameters:
-- StandardSideFilter
-- amount, raises error if not number
function wml_actions.loot( cfg )
	local gold_amount = math.floor(tonumber(cfg.amount)) or wml.error( "Missing or wrong amount= value in [loot]" )
	local sides = wesnoth.sides.find( cfg )
	for index, side in ipairs( sides ) do
		wml_actions.message {
			side_for = side.side,
			speaker = "narrator",
			message = string.format( tostring( _"You retrieve %d pieces of gold." ), gold_amount ),
			image = "wesnoth-icon.png",
			sound = "gold.ogg"
		}
		side.gold = side.gold + gold_amount
	end
end