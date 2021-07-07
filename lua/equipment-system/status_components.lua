-- local T = helper.set_wml_tag_metatable {}
local T = wml.tag

function equipment_grid(data)
	return T.grid{
		T.row { T.column { T.label { id = "the_gearlist_title", use_markup = true }}},
		T.row { T.column { vertical_grow = false, horizontal_alignment = "left" , horizontal_grow = false, T.horizontal_listbox { horizontal_scrollbar_mode = "never", id = "the_gearlist" , 
		    T.list_definition { T.row { T.column {
					grow_factor = 1, horizontal_grow = true, vertical_grow = true,
				-- testing
--					T.stacked_widget{
--					  T.layer{ T.row{ T.column{
					T.toggle_panel { T.grid {
								T.row { T.column { T.image { id = "the_gearlist_icon"}}},
								T.row { T.column { T.label { use_markup = true, id = "the_gearlist_icon_name", use_markup = true}}}
								}}
--					  }}},
--					  T.layer{ T.row{ T.column{
--  					  T.label{ id= "the_gearlist_tooltip", tooltip = "Testing123"}
--					  }}}
--					  }
				}}} --,
--		    T.list_data{data}
			}}},
		T.row { T.column { T.grid {
					T.row {
					       T.column { T.button { tooltip = "Remove from unit and send to side inventory.  Inactive if unit has no moves left.", id = "inventory_button", label = _"Send to Inventory" , return_value = 4 } },
					       T.column { T.button { tooltip = "Remove from unit and place on map.  Inactive if unit has no moves left.", id = "drop_button", label = _"Drop" , return_value = 3 } }
					       }
					   }}},

-- this spacer is to prevent resizing with change of label text, but might not be the best way
		T.row { T.column { horizontal_grow = true, T.spacer { width = 550 }}},
-- cannot get characters_per_line to be recognized in scroll_label, must not be supported.
		T.row { T.column { vertical_grow = false, horizontal_grow = false , horizontal_alignment = "left", T.label { characters_per_line = 66, wrap = true, id = "the_gear_description", use_markup = true}}}
--		T.row { T.column { vertical_grow = false, horizontal_grow = false , horizontal_alignment = "left", T.scroll_label { vertical_scrollbar_mode = "always", characters_per_line = 36, wrap = true, id = "the_gear_description"}}}
		}                                    

end		                                                                                                                                                                                                                                                                                                                                                                                        					
-- this works, but does nothing for the crashing
--[[function equipment_grid()
	return T.grid{ T.row{ T.column {
		T.stacked_widget{
                       -- T.stack{
                        	T.layer{
                                	T.row{
                                        	T.column{
                                                	T.spacer{ width= 400, height= 300 }
                                                }
                                        }
                                },
--[-[          turns out, this widget doesn't exist              	T.layer{
                                	T.row{
                                        	T.column{
                                                	T.tooltip{ id = "the_tooltip" }
                                                }
                                        }
                                }, ]-]
                                T.layer{
                                	T.row{
                                                grow_factor = 1,
                                        	T.column{
			                                border = "all", border_size = 5, 
			                                horizontal_alignment = "center", 
			                                vertical_alignment = "center",   
                                                        equipment_grid_()
                                                }
                                        }

				}
			-- }
		}
		}}}	
end]]

-- to use to insert into a list_data table
function equipment_grid_data(equ_icon, equ_label, equ_tooltip) 
	wesnoth.message(equ_icon)
	return T.column{ 
			T.widget{id = "the_gearlist_icon", label = equ_icon, tooltip = equ_tooltip},
			T.widget{id = "the_gearlist_icon_name", label = equ_label, tooltip = equ_tooltip}
			}
end

function inventory_grid()
	return T.grid{
		T.row { T.column { border = "all", border_size = 5, T.label { id = "the_poollist_title", use_markup = true }}},
		T.row { T.column { horizontal_alignment = "center" , T.listbox { max_height = 80, vertical_scrollbar_mode = "always", id = "the_poollist" , T.list_definition { T.row { T.column {horizontal_grow = true,
						T.toggle_panel { T.grid { T.row { T.column {border = "all", border_size = 2, horizontal_alignment = "center", T.label { wrap = true, characters_per_line = 18, id = "the_poollist_entry", use_markup = true}}}}} 
						  }}}}}},
		T.row { T.column { T.grid {
								  T.row {
								          T.column { T.button { tooltip = "Use or equip item.  Inactive if unit has no moves left.", id = "use_button", label = _"Use" , return_value = 6 } }, 
                                                                          T.column { T.button { tooltip = "Delete item.  Inactive if unit has no moves left.", id = "delete_button", label = _"Delete" , return_value = 5 } }
                                                                         }
                                               }}}

		}
end

-- testing tree_view -> fail
--[[function inventory_grid()
	return T.grid{
		T.row { T.column { border = "all", border_size = 5, T.label { id = "the_poollist_title" }}},
		T.row { T.column { horizontal_alignment = "center" , T.tree_view { max_height = 80, vertical_scrollbar_mode = "always", id = "the_poollist" , T.tree_view_definition { T.row { T.column {horizontal_grow = true,
						T.node { id = "node1",
						T.node_definition { T.row { T.column { horizontal_grow = true,
						T.toggle_panel { T.grid { T.row { T.column {border = "all", border_size = 2, horizontal_alignment = "center", T.label { wrap = true, characters_per_line = 18, id = "the_poollist_entry"}}}}} 
						  }}}} }}}}}},
		T.row { T.column { T.grid {
								  T.row {
								          T.column { T.button { tooltip = "Use or equip item.  Inactive if unit has no moves left.", id = "use_button", label = _"Use" , return_value = 6 } }, 
                                                                          T.column { T.button { tooltip = "Delete item.  Inactive if unit has no moves left.", id = "delete_button", label = _"Delete" , return_value = 5 } }
                                                                         }
                                               }}}

		}
end
]]
function rg_row(header_id,header_label,value_id)
	return T.row { T.column { vertical_grow = true, T.label {definition = "default_small", id = header_id , label = header_label }}, T.column { T.spacer { width = 12 }}, T.column { horizontal_alignment = "right" , T.label { id = value_id , use_markup = true}}}
end

function resistances_grid()
	return T.grid {
		T.row { T.column { T.label { id = "the_rg_title", use_markup = true}}},
		T.row { T.column { T.grid {
		rg_row("header_arcane","Arcane","the_rg_arcane"),
		rg_row("header_blade","Blade","the_rg_blade"),
		rg_row("header_cold","Cold","the_rg_cold"),
		rg_row("header_fire","Fire","the_rg_fire"),
		rg_row("header_impact","Impact","the_rg_impact"),
		rg_row("header_pierce","Pierce","the_rg_pierce")
					}}}
			} 
end
function movementcost_grid()
	return T.grid {
		T.row { T.column { T.spacer { id = "mc_spacer" }} , T.column { T.label { id = "the_mcg_title", use_markup = true }} , T.column { T.label { id = "the_dg_title", use_markup = true }}},
		T.row { T.column { T.label { definition = "default_small", id = "header_shallow_water" , label = "Shallow Water" }} , T.column { T.label { id = "the_mcg_shallow_water", use_markup = true}} , T.column { T.label { id = "the_dg_shallow_water", use_markup = true}}},
		T.row { T.column { T.label { definition = "default_small", id = "header_reef" , label = "Reef" }} , T.column { T.label { id = "the_mcg_reef", use_markup = true}} , T.column { T.label { id = "the_dg_reef", use_markup = true}}},
		T.row { T.column { T.label { definition = "default_small", id = "header_swamp_water" , label = "Swamp Water" }} , T.column { T.label { id = "the_mcg_swamp_water", use_markup = true}} , T.column { T.label { id = "the_dg_swamp_water", use_markup = true}}},
		T.row { T.column { T.label { definition = "default_small", id = "header_deep_water" , label = "Deep Water" }} , T.column { T.label { id = "the_mcg_deep_water", use_markup = true}} , T.column { T.label { id = "the_dg_deep_water", use_markup = true}}},
		T.row { T.column { T.label { definition = "default_small", id = "header_flat" , label = "Flat" }} , T.column { T.label { id = "the_mcg_flat", use_markup = true}} , T.column { T.label { id = "the_dg_flat", use_markup = true}}},
		T.row { T.column { T.label { definition = "default_small", id = "header_frozen" , label = "Frozen" }} , T.column { T.label { id = "the_mcg_frozen", use_markup = true}} , T.column { T.label { id = "the_dg_frozen", use_markup = true}}},
		T.row { T.column { T.label { definition = "default_small", id = "header_sand" , label = "Sand" }} , T.column { T.label { id = "the_mcg_sand", use_markup = true}} , T.column { T.label { id = "the_dg_sand", use_markup = true}}},
		T.row { T.column { T.label { definition = "default_small", id = "header_fungus" , label = "Fungus" }} , T.column { T.label { id = "the_mcg_fungus", use_markup = true}} , T.column { T.label { id = "the_dg_fungus", use_markup = true}}},
		T.row { T.column { T.label { definition = "default_small", id = "header_forest" , label = "Forest" }} , T.column { T.label { id = "the_mcg_forest", use_markup = true}} , T.column { T.label { id = "the_dg_forest", use_markup = true}}},
		T.row { T.column { T.label { definition = "default_small", id = "header_cave" , label = "Cave" }} , T.column { T.label { id = "the_mcg_cave", use_markup = true}} , T.column { T.label { id = "the_dg_cave", use_markup = true}}},
		T.row { T.column { T.label { definition = "default_small", id = "header_castle" , label = "Castle" }} , T.column { T.label { id = "the_mcg_castle", use_markup = true}} , T.column { T.label { id = "the_dg_castle", use_markup = true}}},
		T.row { T.column { T.label { definition = "default_small", id = "header_village" , label = "Village" }} , T.column { T.label { id = "the_mcg_village", use_markup = true}} , T.column { T.label { id = "the_dg_village", use_markup = true}}},
		T.row { T.column { T.label { definition = "default_small", id = "header_hills" , label = "Hills" }} , T.column { T.label { id = "the_mcg_hills", use_markup = true}} , T.column { T.label { id = "the_dg_hills", use_markup = true}}},
		T.row { T.column { T.label { definition = "default_small", id = "header_mountains" , label = "Mountains" }} , T.column { T.label { id = "the_mcg_mountains", use_markup = true}} , T.column { T.label { id = "the_dg_mountains", use_markup = true}}} --,
--[[	        T.row { 
		 	T.column { T.spacer { id = "mc_end_spacer_l"}},
	        	T.column { border = "all", border_size = 5, horizontal_alignment = "center", vertical_alignment = "center", 
	 				T.drawing { id = "left_line", width = 300, height = 80, T.draw { T.line { x1 = 1, y1 = 40, x2 = 299, y2 = 40, color = "255,255,255,255"}, T.text { font_size = 1 } }}
	       		  	  },
		 	T.column { T.spacer { id = "mc_end_spacer_r"}}
	      	       }]]
			} 
end

function misc_status_grid() 
 	return T.grid { 
	 T.row { T.column { border= "all", border_size= 5, T.grid {  -- left grid
-- this causes errors	         	T.row { T.column { horizontal_alignment = "center" , horizontal_grow = true, T.image { id = "the_icon"}}},
	         	T.row { T.column { horizontal_alignment = "center" , horizontal_grow = false, T.image { id = "the_icon"}}},
	         	T.row { T.column { horizontal_grow = true, T.label { id = "the_unit_type", use_markup = true}}},
		 	T.row { T.column { T.grid {
			         	T.row { T.column { horizontal_grow = true, T.label { id = "the_unit_level", use_markup = true}}, T.column { horizontal_grow = true, T.label { id = "the_unit_alignment", use_markup = true}}},
			         	T.row { T.column { horizontal_grow = true, T.label { id = "the_unit_HP", use_markup = true}}, T.column { horizontal_grow = true, T.label { id = "the_first_trait", use_markup = true}}},
			         	T.row { T.column { horizontal_grow = true, T.label { id = "the_unit_XP", use_markup = true}}, T.column { horizontal_grow = true, T.label { id = "the_second_trait", use_markup = true}}},  
			         	T.row { T.column { horizontal_grow = true, T.label { id = "the_unit_WT", use_markup = true, tooltip = "Equipment Weight: lowers defense values (except for village and castle) and every ten points costs one movement point."}}, T.column { horizontal_grow = true, T.spacer { id = "WT_spacer"}}}
				}}}				
			  }},
                 T.column { resistances_grid()} -- right grid
               },
	  
	  }
end

function set_simple_grid_values(unit,self)
	local unit_hp = unit.hitpoints
	unit_hp = unit_hp / unit.max_hitpoints
-- 20190803 -- seems there is some bad logic here, change the <= to >= ?
	local hp_color = "color ='#34db00'"
	if unit_hp < 0.2 then
	    hp_color = "color ='#c80000'"
	elseif unit_hp <= 0.2 and unit_hp < 0.6 then
	    hp_color = "color ='#ffc000'"
	elseif unit_hp <= 0.6 and unit_hp < 0.9 then
	    hp_color = "color ='#dedede'"
	end
	local unit_xp = unit.experience
	unit_xp = unit_xp / unit.max_experience
	local xp_color = "color ='#8855ff'"
	if unit_xp < 0.2 then
	    xp_color = "color ='#550088'"
	elseif unit_xp <= 0.2 and unit_xp < 0.6 then
	    xp_color = "color ='#5511aa'"
	elseif unit_xp <= 0.6 and unit_xp < 0.9 then
	    xp_color = "color ='#5533bb'"
	end
    -- these are deprecated, add use_markup = true directly to grid above
    -- wesnoth.set_dialog_markup(true, "the_unit_type")
	-- wesnoth.set_dialog_markup(true, "the_unit_HP")
	-- wesnoth.set_dialog_markup(true, "the_unit_XP")
	-- wesnoth.set_dialog_markup(true, "the_unit_alignment")
	-- wesnoth.set_dialog_markup(true, "the_unit_level")
	-- wesnoth.set_dialog_value(string.format("<span size='large' color='#88dddd'> %s </span>", unit.type) , "the_unit_type")
    local widget_handle = self:find('the_unit_type')
    widget_handle.value_compat = string.format("<span size='large' color='#88dddd'> %s </span>", unit.type)
    -- wesnoth.set_dialog_value(string.format("<span size='small' color='#88dddd'> Level: %d </span>", unit.level) , "the_unit_level")
    widget_handle = self:find('the_unit_level')
    widget_handle.value_compat = string.format("<span size='small' color='#88dddd'> Level: %d </span>", unit.level)
    -- wesnoth.set_dialog_value(string.format("<span size='small' color='#88dddd'> %s </span>", unit.alignment) , "the_unit_alignment")
    widget_handle = self:find('the_unit_alignment')
    widget_handle.value_compat = string.format("<span size='small' color='#88dddd'> %s </span>", unit.alignment)
    -- wesnoth.set_dialog_value(string.format("<span size='small' "..hp_color.."> HP: %s / %s </span>", unit.hitpoints, unit.max_hitpoints) , "the_unit_HP")
    widget_handle = self:find('the_unit_HP')
    widget_handle.value_compat = string.format("<span size='small' "..hp_color.."> HP: %s / %s </span>", unit.hitpoints, unit.max_hitpoints)
    -- wesnoth.set_dialog_value(string.format("<span size='small' "..xp_color.."> XP: %s / %s </span>", unit.experience, unit.max_experience) , "the_unit_XP")
    widget_handle = self:find('the_unit_XP')
    widget_handle.value_compat = string.format("<span size='small' "..xp_color.."> XP: %s / %s </span>", unit.experience, unit.max_experience)
    -- wesnoth.set_dialog_value(string.format("portraits/status_pane.png~SCALE(220,220)~BLIT(%s~SCALE(220,220))~BLIT(portraits/status_pane_top.png~SCALE(220,220))", unit.profile) , "the_image")
    widget_handle = self:find('the_image')
    widget_handle.value_compat = string.format("portraits/status_pane.png~SCALE(220,220)~BLIT(%s~SCALE(220,220))~BLIT(portraits/status_pane_top.png~SCALE(220,220))", unit.profile)
    -- wesnoth.set_dialog_value(unit.image, "the_icon")
    widget_handle = self:find('the_icon')
    widget_handle.value_compat = unit.image
end

function set_child_grid_values(unit, self)
-- traits
	local traits_strings = {}
	local u_mods = wml.get_child(unit, "modifications")
	local c_i = 1
	for trait in wml.child_range( u_mods, "trait") do
	    traits_strings[c_i] = trait.male_name
	    c_i = c_i + 1
	end
	if traits_strings[2] then
	   else
	   traits_strings[2] = "."
	end
	-- wesnoth.set_dialog_markup(true, "the_first_trait")
	-- wesnoth.set_dialog_markup(true, "the_second_trait")
	-- wesnoth.set_dialog_value(string.format("<span size='small' color='#889999'> %s </span>", traits_strings[1]) , "the_first_trait")
    widget_handle = self:find('the_first_trait')
    widget_handle.value_compat = string.format("<span size='small' color='#889999'> %s </span>", traits_strings[1])
    -- wesnoth.set_dialog_value(string.format("<span size='small' color='#889999'> %s </span>", traits_strings[2]) , "the_second_trait")
    widget_handle = self:find('the_second_trait')
    widget_handle.value_compat = string.format("<span size='small' color='#889999'> %s </span>", traits_strings[2])
    -- weight
	local unit_var = wml.get_child(unit, "variables")
	local unit_wt = unit_var.weight
        if unit_wt then
        else
           unit_wt = 0
        end
	local wt_color = "color ='#2ac600'"
	if unit_wt > -10 and unit_wt < 10 then
	    wt_color = "color ='#e5e5e5'"
	elseif unit_wt >= 10 and unit_wt < 20 then
	    wt_color = "color ='#ffc600'"
	elseif unit_wt >= 20 and unit_wt < 30 then
	    wt_color = "color ='#ff0000'"
	end
	-- wesnoth.set_dialog_markup(true, "the_unit_WT")
	-- wesnoth.set_dialog_value(string.format("<span size='small' "..wt_color.."> Equ.Wt.: %s </span>", unit_wt) , "the_unit_WT")
    widget_handle = self:find('the_unit_WT')
    widget_handle.value_compat = string.format("<span size='small' "..wt_color.."> Equ.Wt.: %s </span>", unit_wt)
-- movement costs
	-- wesnoth.set_dialog_markup(true, "the_mcg_title")
	-- wesnoth.set_dialog_value("<span color='#eeffb7'>  Movement Costs  </span>", "the_mcg_title")
    widget_handle = self:find('the_mcg_title')
    widget_handle.value_compat = "<span color='#eeffb7'>  Movement Costs  </span>"
	local costs = wml.get_child(unit, "movement_costs")
	local function mcg_format_row(value,widget)
	    if value == nil then value = 99 end
	    local val_color = "color ='#ffc000'"
	    if value == 1 then
	        val_color = "color = '#dedede'"
	    elseif value > 3 and value < 6 then
	        val_color = "color = '#e56111'"
	    elseif value >= 6 then
	        val_color = "color ='#c80000' style ='italic'"
	    end
	    -- wesnoth.set_dialog_markup(true, widget)
        -- widget.use_markup = true -- not sure how to write an inline replacement, this doesn't work.
        -- return wesnoth.set_dialog_value(string.format("<span "..val_color.." size = 'small'>%s </span>", value) , widget)
        widget_handle = self:find(widget)
        widget_handle.value_compat = string.format("<span "..val_color.." size = 'small'>%s </span>", value)
        return
	end
	mcg_format_row(costs.forest,"the_mcg_forest")
	mcg_format_row(costs.fungus,"the_mcg_fungus")
	mcg_format_row(costs.sand,"the_mcg_sand")
	mcg_format_row(costs.frozen,"the_mcg_frozen")
	mcg_format_row(costs.flat,"the_mcg_flat")
	mcg_format_row(costs.cave,"the_mcg_cave")
	mcg_format_row(costs.castle,"the_mcg_castle")
	mcg_format_row(costs.village,"the_mcg_village")
	mcg_format_row(costs.hills,"the_mcg_hills")
	mcg_format_row(costs.mountains,"the_mcg_mountains")
	mcg_format_row(costs.swamp_water,"the_mcg_swamp_water")
	mcg_format_row(costs.shallow_water,"the_mcg_shallow_water")
	mcg_format_row(costs.deep_water,"the_mcg_deep_water")
	mcg_format_row(costs.reef,"the_mcg_reef")
-- defense
	-- wesnoth.set_dialog_markup(true, "the_dg_title")
	-- wesnoth.set_dialog_value("<span color='#eeffb7'>  Terrain Defense  </span>", "the_dg_title")
    widget_handle = self:find('the_dg_title')
    widget_handle.value_compat = "<span color='#eeffb7'>  Terrain Defense  </span>"
	local defense = wml.get_child(unit, "defense")
	local rf_d = defense.reef
	local ft_d = defense.forest
	local fu_d = defense.fungus
	local fz_d = defense.frozen
	local fl_d = defense.flat
	local sa_d = defense.sand
	local sp_d = defense.swamp_water
	local sw_d = defense.shallow_water
	local dw_d = defense.deep_water
	local hl_d = defense.hills
	local mt_d = defense.mountains
	local cv_d = defense.cave
	local ca_d = defense.castle
	local vg_d = defense.village
	local function dg_format_row(value,widget)
	    if value == nil then value = 100 end
	    value = 100 - value
	    local val_color = "color ='#ffc000'"
	    if value >= 70 then
	    	val_color = "color ='#34db00'"
	    elseif value < 70 and value >= 50 then
	        val_color = "color = '#dedede'"
	    elseif value <= 30 and value > 10 then
	        val_color = "color = '#e56111'"
	    elseif value <= 10 then
	        val_color = "color ='#c80000' style ='italic'"
	    end
	    -- wesnoth.set_dialog_markup(true, widget)
	    -- return wesnoth.set_dialog_value(string.format("<span "..val_color.." size = 'small'>%s </span>", value) , widget)
        widget_handle = self:find(widget)
        widget_handle.value_compat = string.format("<span "..val_color.." size = 'small'>%s </span>", value)
        return
    end
	dg_format_row(rf_d,"the_dg_reef")
	dg_format_row(ft_d,"the_dg_forest")
	dg_format_row(fu_d,"the_dg_fungus")
	dg_format_row(sa_d,"the_dg_sand")
	dg_format_row(fz_d,"the_dg_frozen")
	dg_format_row(fl_d,"the_dg_flat")
	dg_format_row(sp_d,"the_dg_swamp_water")
	dg_format_row(sw_d,"the_dg_shallow_water")
	dg_format_row(dw_d,"the_dg_deep_water")
	dg_format_row(hl_d,"the_dg_hills")
	dg_format_row(mt_d,"the_dg_mountains")
	dg_format_row(cv_d,"the_dg_cave")
	dg_format_row(ca_d,"the_dg_castle")
	dg_format_row(vg_d,"the_dg_village")
-- resistances
	-- wesnoth.set_dialog_markup(true, "the_rg_title")
	-- wesnoth.set_dialog_value("<span size='large' color='#eeffb7' underline='single' >  Resistances  </span>", "the_rg_title")
    widget_handle = self:find('the_rg_title')
    widget_handle.value_compat = "<span size='large' color='#eeffb7' underline='single' >  Resistances  </span>"
    local resistance = wml.get_child(unit, "resistance")
	local f_r = 100 - resistance.fire
	local c_r = 100 - resistance.cold
	local a_r = 100 - resistance.arcane
	local b_r = 100 - resistance.blade
	local i_r = 100 - resistance.impact
	local p_r = 100 - resistance.pierce
	local function rg_format_row(value,widget)
	    local val_color = "color ='#ffc000'"
	    if value >= 40 then
	    	val_color = "color ='#34db00'"
	    elseif value < 40 and value >= 10 then
	        val_color = "color = '#dedede'"
	    elseif value <= -10 and value > -40 then
	        val_color = "color = '#e56111'"
	    elseif value <= -40 then
	        val_color = "color ='#c80000' style ='italic'"
	    end
	    -- wesnoth.set_dialog_markup(true, widget)
	    -- return wesnoth.set_dialog_value(string.format("<span "..val_color.." size = 'small'>%s </span>", value) , widget)
        widget_handle = self:find(widget)
        widget_handle.value_compat = string.format("<span "..val_color.." size = 'small'>%s </span>", value)
        return
    end
	rg_format_row(a_r,"the_rg_arcane")
	rg_format_row(b_r,"the_rg_blade")
	rg_format_row(c_r,"the_rg_cold")
	rg_format_row(f_r,"the_rg_fire")
	rg_format_row(i_r,"the_rg_impact")
	rg_format_row(p_r,"the_rg_pierce")
--	wesnoth.set_dialog_value(string.format("%s ", a_r) , "the_rg_arcane")


end
