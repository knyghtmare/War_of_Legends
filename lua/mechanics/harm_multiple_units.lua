--
-- WML animations library
--
-- codename Naia - Project Ethea phase 1 campaigns shared library
-- Copyright (C) 2020 - 2021 by Iris Morelle <shadowm@wesnoth.org>
--
-- See COPYING for usage terms.
--
--[[

[harm_multiple_units] - Damages multiple units simultaneously

This WML action is intended for use in the implementation of AoE weapon
specials. It has the same syntax as Wesnoth 1.14's [harm_unit] action,
save for the following:

 * animate=, delay=, and variable= are not supported for the sake of
   simplicity.
 * Only defense animations are played -- the expectation is that this code
   gets called immediately after an attack animation anyway
 * There is intentionally no way to select the animation mode -- defense
   animations are always concurrent for all targets

Example:

[harm_multiple_units]
	#
	# Attack targets
	#
	[filter]
		[filter_adjacent]
			x,y=$x1,$y1
		[/filter_adjacent]
		[filter_side]
			[enemy_of]
				side=$unit.side
			[/enemy_of]
		[/filter_side]
	[/filter]

	#
	# Attack source
	#
	[filter_second]
		x,y=$x1,$y1
	[/filter_Second]

	#
	# Propagate weapon information from parent event handler
	#
	[insert_tag]
		name,variable=primary_attack,weapon
	[/insert_tag]
	[insert_tag]
		name,variable=secondary_attack,second_weapon
	[/insert_tag]

	amount="$($weapon.damage * 0.25)"
	alignment=$unit.alignment
	damage_type=$weapon.type

	experience=yes
	fire_event=yes
	kill=yes
[/harm_multiple_units]

]]

local T = wml.tag

local STATUS_EFFECTS = {
	poisoned = {
		sound  = "poison.ogg",
		male   = wgettext("poisoned"),
		female = wgettext("female^poisoned"),
	},
	slowed = {
		sound  = "slowed.wav",
		male   = wgettext("slowed"),
		female = wgettext("female^slowed"),
	},
	petrified = {
		sound  = "petrified.ogg",
		male   = wgettext("petrified"),
		female = wgettext("female^petrified"),
	},
	unhealable = {
		male   = wgettext("unhealable"),
		female = wgettext("female^unhealable"),
	},
}

local STATUS_FORMAT = "<span foreground='red'>%s</span>"

local function do_error(msg)
	helper.wml_error("[harm_multiple_units] " .. msg)
end

local function do_wprintf(lvl, msg, ...)
	wprintf(lvl, "[harm_multiple_units] " .. msg, ...)
end

--
-- The two functions below are lifted from 1.14 data/lua/wml/harm_unit.lua
--

local function round_damage(base_damage, bonus, divisor)
	if base_damage == 0 then
		return 0
	end

	local rounding
	if bonus < divisor or divisor == 1 then
		rounding = divisor / 2 - 0
	else
		rounding = divisor / 2 - 1
	end

	return math.max(1, math.floor((base_damage * bonus + rounding) / divisor))
end

local function calculate_damage(base_damage, alignment, tod_bonus, resistance, modifier)
	local damage_multiplier = 100
	if alignment == "lawful" then
		damage_multiplier = damage_multiplier + tod_bonus
	elseif alignment == "chaotic" then
		damage_multiplier = damage_multiplier - tod_bonus
	elseif alignment == "liminal" then
		damage_multiplier = damage_multiplier - math.abs(tod_bonus)
	else
		-- neutral, do nothing
	end

	local resistance_modified = resistance * modifier
	damage_multiplier = damage_multiplier * resistance_modified
	local damage = round_damage(base_damage, damage_multiplier, 10000)
	return damage
end

local function calculate_xp(a, b, a_kills_b)
	if a_kills_b then
		return math.max(4, 8 * b.__cfg.level)
	else
		return b.__cfg.level
	end
end

-------------------------
-- damage_action class --
-------------------------

damage_action = {}
damage_action.__index = damage_action

function damage_action:new(source, target, primary_attack, secondary_attack, data)
	local o = {}

	setmetatable(o, damage_action)

	do_wprintf(W_DBG, "ENTER: damage_action ctor")
	windent()

	o.animate = true
	o.fire_event = data.fire_event
	o.kill = data.kill

	o.floating_label = ""

	o.source = source
	o.target = target

	o.primary_attack = primary_attack
	o.secondary_attack = secondary_attack

	local damage_type = data.damage_type or "dummy"
	local tod_bonus = wesnoth.get_time_of_day({ o.target.x, o.target.y, true }).lawful_bonus
	local resistance = wesnoth.unit_resistance(o.target, damage_type)
	local resistance_multiplier = tonumber(data.resistance_multiplier) or 1
	local base_damage = tonumber(data.amount)
	local alignment = data.alignment or "neutral"

	o.damage = calculate_damage(base_damage, alignment, tod_bonus, resistance, resistance_multiplier)

	do_wprintf(W_DBG, "damage %0.1f to %0.1f after correction (type/alignment/tod/res/mul = %s/%s/%d/%d/%0.1f)", base_damage, o.damage, damage_type, alignment, tod_bonus, resistance, resistance_multiplier)

	if o.damage >= o.target.hitpoints then
		if o.kill == false then
			do_wprintf(W_DBG, "large damage on %s, setting HP to 1", o.target.id)
			o.damage = o.target.hitpoints - 1
		else
			do_wprintf(W_DBG, "dead man walking id = %s", o.target.id)
			o.damage = o.target.hitpoints
		end
	end

	o.source_xp, o.target_xp = 0, 0

	if data.experience ~= false and o.source and o.source.valid
	   and wesnoth.is_enemy(o.target.side, o.source.side) then
		if o.damage >= o.target.hitpoints then
			o.source_xp = calculate_xp(o.source, o.target, o.kill)
			-- Dead man walking, leave XP untouched
		else
			o.source_xp = calculate_xp(o.source, o.target)
			o.target_xp = calculate_xp(o.target, o.source)
		end
		do_wprintf(W_DBG, "XP gain source/target = %d/%d", o.source_xp, o.target_xp)
	end

	o.statuses = {}

	for status_effect, _ in pairs(STATUS_EFFECTS) do
		if data[status_effect] then
			do_wprintf(W_DBG, "status effect requested %s", status_effect)
			o.statuses[status_effect] = true
		end
	end

	wunindent()
	do_wprintf(W_DBG, "LEAVE: damage_action ctor")

	return o
end

function damage_action:apply_damage()
	self.target.hitpoints = self.target.hitpoints - self.damage

	local text = ("%d\n"):format(self.damage)
	local add_tab = false
	local gender = self.target.__cfg.gender

	for status_effect, _ in pairs(self.statuses) do
		if not (status_effect == "poisoned" and self.target.status.unpoisonable) and not self.target.status[name] then
			if gender == "female" then
				text = ("%s%s\n"):format(text, tostring(STATUS_EFFECTS[name].female))
			else
				text = ("%s%s\n"):format(text, tostring(STATUS_EFFECTS[name].male))
			end

			self.target.status[name] = true
			add_tab = true
		end
	end

	self.target:extract()
	self.target:to_map()

	if add_tab then
		text = ("%s%s"):format("\t", text)
	end

	self.floating_label = text
end

function damage_action:process_outcome()
	-- Deaths and advancements are done here

	if self.source_xp ~= 0 then
		self.source.experience = self.source.experience + self.source_xp
	end

	if self.target_xp ~= 0 then
		self.target.experience = self.target.experience + self.target_xp
	end

	if self.target.hitpoints <= 0 and self.kill then
		wesnoth.wml_actions.kill {
			id         = self.target.id,
			animate    = self.animate,
			fire_event = self.fire_event,
			self.source and T.secondary_unit {
				id = self.source.id,
			},
		}
	end

	-- Either unit may no longer be alive at this point (events)

	if self.target_xp and self.target and self.target.valid then
		self.target:advance(self.animate, self.fire_event ~= false)
	end

	if self.source_xp and self.source and self.source.valid then
		self.source:advance(self.animate, self.fire_event ~= false)
	end
end

function damage_action:get_animation()
	local flag = "defend"
	local hits

	if self.target.hitpoints <= self.damage and self.kill then
		hits = "kill"
	else
		hits = "hit"
	end

	local primary, secondary = nil, nil

	if self.primary_attack then
		if self.source and self.source.valid then
			-- WARNING: Undocumented implementation details for 1.14/1.16 follow.
			if WESNOTH_VERSION < version_number:new("1.15.0") then
				primary = helper.find_attack(self.source, self.primary_attack)
			else
				primary = self.source:find_attack(self.primary_attack)
			end
		else
			primary = wesnoth.create_weapon(self.primary_attack)
		end
	end

	if self.secondary_attack then
		secondary = wesnoth.create_weapon(self.secondary_attack)
	end

	return flag, hits, {
		facing    = self.target.facing,
		with_bars = true,
		primary   = primary,
		secondary = secondary,
	}
end

function damage_action:play_sounds()
	for status_effect, _ in pairs(self.statuses) do
		if not (status_effect == "poisoned" and self.target.status.unpoisonable) then
			local sound = STATUS_EFFECTS[status_effect].sound
			if sound then
				wesnoth.play_sound(sound)
			end
		end
	end
end

function damage_action:display_floating_label()
	wesnoth.float_label(self.target.x, self.target.y, STATUS_FORMAT:format(self.floating_label))
end

---------------------------
-- WML action tag proper --
---------------------------

function wesnoth.wml_actions.harm_multiple_units(cfg)
	local filter = wml.get_child(cfg, "filter") or do_error("Missing required [filter] tag")
	if not wml.shallow_literal(cfg).amount then
		do_error("Missing required amount= attribute")
	end

	local this_unit = utils.start_var_scope("this_unit")

	local targets = wesnoth.get_units(filter)
	if not targets then
		do_wprintf(W_DBG, "No targets found, nothing to do here")
		return
	end

	do_wprintf(W_DBG, "ENTER: core block")
	windent()

	--
	-- Animate units first, then call [harm_unit] without animations on. That's
	-- the simplest way to deal with the issue of [harm_unit] being able to
	-- kill units before returning. It's not as visually clean as doing the
	-- whole thing ourselves (we'll play the animation first and only once the
	-- animation has finished the floating damage labels will show up/the

	local animator = wesnoth.create_animator()

	local act_sequence = {}

	-- STEP 1: Build action sequence and apply damage

	for _, target in ipairs(targets) do
		if target.valid then
			wml.variables.this_unit = nil
			wml.variables.this_unit = target.__cfg

			local primary_attack = wml.get_child(cfg, "primary_attack")
			local secondary_attack = wml.get_child(cfg, "secondary_attack")
			local source_filter = wml.get_child(cfg, "filter_second")
			local source = nil

			if source_filter then
				source = wesnoth.get_units(source_filter)[1]
			end

			local act = damage_action:new(source, target, primary_attack, secondary_attack, cfg)
			table.insert(act_sequence, act)

			act:apply_damage()
			animator:add(act.target, act:get_animation())
		end
	end

	-- STEP 2: Play animations, sounds, and display floating labels
	animator:run()
	for _, act in ipairs(act_sequence) do
		act:play_sounds()
		act:display_floating_label()
	end

	-- STEP 3: Consequences
	animator:clear()
	for _, act in ipairs(act_sequence) do
		act:process_outcome()
	end

	wesnoth.wml_actions.redraw {}

	wml.variables.this_unit = nil
	utils.end_var_scope("this_unit", this_unit)

	wunindent()
	do_wprintf(W_DBG, "LEAVE: core block")
end