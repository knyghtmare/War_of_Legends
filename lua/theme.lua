-- #textdomain wesnoth-War_of_Legends
local _ = wesnoth.textdomain "wesnoth-War_of_Legends"
local old_unit_status = wesnoth.interface.game_display.unit_status

function wesnoth.interface.game_display.unit_status()
	local u = wesnoth.interface.get_displayed_unit()
	if not u then return {} end
	local s = old_unit_status()

	--if u.status.dehydrated then
	--	table.insert(s, { "element", {
	--		image = "misc/dehydration-status.png~CROP_TRANSPARENT()",
	--		tooltip = _ "dehydrated: This unit is dehydrated. It will lose 4 HP and have its damage reduced by 1 each turn during the day unless prevented by healers or cured by water at an oasis.\n\nUnits cannot be killed or deal no damage as a result of dehydration."
	--	} })
	--end

	if u.status.stunned then
		table.insert(s, { "element", { image = "misc/stunned-status-icon.png~CROP_TRANSPARENT()",
			tooltip = _ "stunned: This unit is stunned. It cannot enforce its Zone of Control."
		} } )
	end

	if u.status.dazed then
		table.insert(s, { "element", { image = "misc/dazed-status-icon.png~CROP_TRANSPARENT()",
			tooltip = _ "dazed: This unit is dazed. It suffers a -10% penalty to both its defense and chance to hit (except for magical attacks)."
		} } )
	end

	if u.status.WOL_curse then
		table.insert(s, { "element", { image = "misc/curse-status-icon.png~CROP_TRANSPARENT()",
			tooltip = _ "cursed: This unit is cursed. This unit gets a 15% defence penalty on every terrain."
		} } )
	end

	-- new elemental abilities

	if u.status.fire_status then
		table.insert(s, { "element", { image = "misc/fire-status-icon.png~CROP_TRANSPARENT()",
			tooltip = _ "fire affliction: This unit has been affected by fire. Attack with another element of a different type to trigger some reaction."
		} } )
	end

	if u.status.cold_status then
		table.insert(s, { "element", { image = "misc/cold-status-icon.png~CROP_TRANSPARENT()",
			tooltip = _ "cold affliction: This unit has been affected by cold. Attack with another element of a different type to trigger some reaction."
		} } )
	end

	if u.status.electric_status then
		table.insert(s, { "element", { image = "misc/electric-status-icon.png~CROP_TRANSPARENT()",
			tooltip = _ "electric affliction: This unit has been affected by electric. Attack with another element of a different type to trigger some reaction."
		} } )
	end

	-- for potions

	if u.status.hasted then
		table.insert(s, { "element", { image = "misc/hasted.png~CROP_TRANSPARENT()",
			tooltip = _ "hasted: Hasted units get 4 more movement points than usual. It lasts until the end of the current scenario."
		} } )
	end

	-- for elementals
	if u.status.summoned then
		table.insert(s, { "element", { image = "misc/summoned-status-icon.png~CROP_TRANSPARENT()",
			tooltip = _ "summoned: Summoned units are stronger next to units with the conjuror ability."
		} } )
	end


	return s
end
