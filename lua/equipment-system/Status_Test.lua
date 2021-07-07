z_require("status_components")
--z_require("gui_hacks")
Status_test  = {}
Status_test.new = function()
local select_gear_id = {}
local select_pool_id = {}
local dr_x = 0
local dr_y = 0
local unit_id = 0
--local equipment_grid_list_data = {}
--local event_context = wesnoth.current.event_context
--local unit_cfg = wesnoth.units.get(event_context.x1,event_context.y1).__cfg
--local u_gear = wml.get_child(unit_cfg, "variables")
--local function equip_data_table_f()
--    for gear in wml.child_range(u_gear, "gear") do	
--	local equip_data = equipment_grid_data(string.format("%s~SCALE(60,60)", gear.image), string.format("<span size='xx-small'>%s</span>", gear.name), gear.text)
--	if equipment_grid_list_data[1] == nil then
--	wesnoth.message("first...")
--	equipment_grid_list_data = {"row", {equip_data}}
--	end
--	wesnoth.message("iterating...")
--	table.insert(equipment_grid_list_data, {"row", {equip_data}})
--	wesnoth.message(equip_data[4])
--    end
--    return equipment_grid_list_data
--end


--[[local equipment_grid_list_data = T.row{ T.column{
	T.widget{id = "the_gearlist_icon", label = "misc/empty.png~SCALE(60,60)"},
	T.widget{id = "the_gearlist_icon_name", label = "dummy label", tooltip = "dummy tooltip"}
}}
]]
--[[	{"row" , {"column" ,
		{"widget" , {id = "the_gearlist_icon", label = "misc/empty.png"}}, 
		{"widget" , {id = "the_gearlist_icon_name", label = "dummy label", tooltip = "dummy tooltip"}}
		}
		}
]]

local dialog = {
  T.tooltip { id = "tooltip_large" },
  T.helptip { id = "helptip_large" },
  maximum_height = 800, maximum_width = 1100,   -- the only way to keep the scroll_label from spreading really wide, as far as I can tell                                                                   
  -- automatic_placement = false,                                             
  -- height = 850, width = 850, 
  T.grid { 
  	   T.row { T.column { T.label { id = "the_panel_title", use_markup = true}}},
           T.row { T.column { T.grid {
			           T.row { 
			           		T.column {  horizontal_alignment = "left" , T.grid { --left grid
			           								T.row { T.column { misc_status_grid()},
			           			 					       },
			           			 					T.row { T.column { movementcost_grid()},
			           			 					       },
			           			 					T.row { T.column { border = "all", border_size = 5, horizontal_alignment = "center", vertical_alignment = "center",
			           			 								T.drawing { id = "left_line", width = 300, height = 30, T.draw { 
			           			 										T.line { x1 = 1, y1 = 15, x2 = 299, y2 = 15, color = "255,255,255,255", thickness = 3}, T.text { font_size = 1 } }}
			           			 							}
			           			 					       },
			           			 					T.row { T.column { inventory_grid()}
			           			 					       }
			           			  }},
			    	   	   	T.column {vertical_alignment = "top" , T.grid { --right grid
			    	   	   						T.row { T.column { T.spacer { height = 20 
			    	   	   						}}},
			    	   	   						T.row { T.column { T.image { id = "the_image" 
			    	   	   						}}},
			    	   	   						T.row { T.column { T.label { id = "the_title", use_markup = true 
			    	   	   						}}},
			           			 				T.row { T.column { border = "all", border_size = 5, horizontal_alignment = "center", vertical_alignment = "center",
			           			 							T.drawing { id = "left_line", width = 300, height = 60, T.draw { 
			           			 								T.line { x1 = 1, y1 = 15, x2 = 299, y2 = 15, color = "255,255,255,255", thickness = 3}, T.text { font_size = 1 } }}
			           			 							}
			           			 					       },
			    	   	   						T.row { T.column { vertical_alignment = "top" , T.panel { --[[definition = "wml_message",]] id = "the_equipment_panel" , height = 500, width = 400, equipment_grid() 
--			    	   	   						T.row { T.column { vertical_alignment = "top" , T.panel { --[[definition = "wml_message",]] id = "the_equipment_panel" , height = 500, width = 400, equipment_grid(equipment_grid_list_data) 
			    	   	   						}}}
			    	   	   		  }}
					  }
	          }}},
	   T.row { T.column { T.spacer { height = 24 }}},
      	   T.row { 
      	          T.column { T.grid { T.row {
			          T.column { T.button { id = "ok", label = _"OK" } },
		 	}}}
		 }
	   }

}



local function preshow(self)
    event_context = wesnoth.current.event_context
    unit_cfg = wesnoth.units.get(event_context.x1,event_context.y1).__cfg
    local can_move = true
    if unit_cfg.moves == 0 then can_move = false end
    dr_x = event_context.x1
    dr_y = event_context.y1
    unit_id = unit_cfg.id
    unit_type = unit_cfg.type
    -- wesnoth.set_dialog_active(can_move, "use_button")
    local widget_handle = self:find('use_button')
    widget_handle.enabled = can_move
    --wesnoth.set_dialog_active(can_move, "delete_button")
    widget_handle = self:find('delete_button')
    widget_handle.enabled = can_move
    -- wesnoth.set_dialog_active(can_move, "drop_button")
    widget_handle = self:find('drop_button')
    widget_handle.enabled = can_move
    -- wesnoth.set_dialog_active(can_move, "inventory_button")
    widget_handle = self:find('inventory_button')
    widget_handle.enabled = can_move
    -- wesnoth.set_dialog_markup(true, "the_panel_title")
    -- wesnoth.set_dialog_value("< span size='xx-large' color='#eeffb7'> Unit Status < /span>" , "the_panel_title")
    widget_handle = self:find('the_panel_title')
    widget_handle.value_compat = "<span size='xx-large' color='#eeffb7'> Unit Status </span>"
    -- widget_handle.text = "<span size='xx-large' color='#eeffb7'> Unit Status </span>"
    -- wesnoth.set_dialog_markup(true, "the_title")
    -- wesnoth.set_dialog_value(string.format("<span size='x-large' color='#eeffb7'> %s </span>", unit_cfg.name) , "the_title")
    widget_handle = self:find('the_title')
    widget_handle.value_compat = string.format("<span size='x-large' color='#eeffb7'> %s </span>", unit_cfg.name)
    -- wesnoth.set_dialog_markup(true, "the_gearlist_title")
    -- wesnoth.set_dialog_value("<span size='large' color='#eeffb7' underline='single'> Equipment </span>" , "the_gearlist_title")
    widget_handle = self:find('the_gearlist_title')
    widget_handle.value_compat = "<span size='large' color='#eeffb7' underline='single'> Equipment </span>"
    -- wesnoth.set_dialog_markup(true, "the_poollist_title")
    -- wesnoth.set_dialog_value("<span size='large' color='#ddeea6' underline='single'> Inventory </span>" , "the_poollist_title")
    widget_handle = self:find('the_poollist_title')
    widget_handle.value_compat = "<span size='large' color='#ddeea6' underline='single'> Inventory </span>"
    set_simple_grid_values(unit_cfg, self)
    set_child_grid_values(unit_cfg, self)
    -- the equipment list
    local gear_text = {}
    local g_i = 1
    local u_gear = wml.get_child(unit_cfg, "variables")
-- changed gear.image SCALE(60,60) to 50,50
--    wesnoth.message(equipment_grid_list_data[1])
--    wesnoth.message(equipment_grid_list_data[2][1])
    for gear in wml.child_range(u_gear, "gear") do
--	table.insert(equipment_grid_list_data,equipment_grid_data(string.format("%s~SCALE(60,60)", gear.image), string.format("<span size='xx-small'>%s</span>", gear.name), gear.text))
	-- wesnoth.set_dialog_value(string.format("%s~SCALE(60,60)", gear.image), "the_gearlist", g_i, "the_gearlist_icon")
    widget_handle = self:find("the_gearlist", g_i, "the_gearlist_icon")
    widget_handle.value_compat = string.format("%s~SCALE(60,60)", gear.image)
    -- wesnoth.set_dialog_value(string.format("<span size='xx-small'>%s</span>", gear.name), "the_gearlist", g_i, "the_gearlist_icon_name")
    widget_handle = self:find("the_gearlist", g_i, "the_gearlist_icon_name")
    widget_handle.value_compat = string.format("<span size='xx-small'>%s</span>", gear.name)
    -- wesnoth.set_dialog_markup(true, "the_gearlist", g_i, "the_gearlist_icon_name")
	gear_text[g_i] = string.format("%s <span size='small'> (Wt: %s) \n  %s </span>", gear.name, gear.weight, gear.text)
--	gear_text[g_i] = string.format("<span size='large'> %s </span> (Wt: %s) - %s", gear.name, gear.weight, gear.text)
	select_gear_id[g_i] = gear.id
	g_i = g_i + 1
--  wesnoth.message(equipment_grid_list_data)
    end
--    wesnoth.message(equipment_grid_list_data[3])
--remove the initial dummy list_data
--    table.remove(equipment_grid_list_data,1)
 --   table.remove(equipment_grid_list_data,2)
    if g_i == 1 then
	    -- wesnoth.set_dialog_active(false, "drop_button")
        widget_handle = self:find('drop_button')
        widget_handle.enabled = can_move
	    -- wesnoth.set_dialog_active(false, "inventory_button")
        widget_handle = self:find('inventory_button')
        widget_handle.enabled = can_move
    end
    local p_i = 1
    for j in ipairs(equipment_list.the_list) do
    -- set markp for pool list entry to red italic, then check unit can use it and change markup if yes
        local gpf_style = "italic"    
        local gpf_color = "#aa5555"    
	local gear_pool_id = equipment_list.the_list[j].id
	local gear_pool_name = equipment_list.the_list[j].name
	local gear_pool_usage = equipment_list.the_list[j].usage

--	local gear_pool_tooltip = equipment_list.the_list[j].tooltip
    -- local gear_pool_number = wesnoth.get_variable("gear_pool[0]."..gear_pool_id)
    local gear_pool_number = wml.variables["gear_pool[0]."..gear_pool_id]
	if gear_pool_number == nil then gear_pool_number = 0 end
        if gear_pool_number > 0 then
            for k in ipairs(equipment_list.list_usage) do
                if equipment_list.list_usage[k].usage == gear_pool_usage then
                  for l in ipairs(equipment_list.list_usage[k].types) do 
                    if equipment_list.list_usage[k].types[l] == unit_type then
                        gpf_style = "normal"    -- normal and blue if useable
                        gpf_color = "#bbddff"
                    end
                  end -- for l
                end
            end -- for k
--	     wesnoth.add_dialog_tree_node("node1", i, "the_poollist")
	     -- wesnoth.set_dialog_value(string.format("<span size='x-small' font-style='%s' color='%s'>%s  ( %d )</span>", gpf_style, gpf_color, gear_pool_name, gear_pool_number), "the_poollist", p_i, "the_poollist_entry")
         widget_handle = self:find('the_poollist', p_i, 'the_poollist_entry')
         widget_handle.value_compat = string.format("<span size='x-small' font-style='%s' color='%s'>%s  ( %d )</span>", gpf_style, gpf_color, gear_pool_name, gear_pool_number)
         -- wesnoth.set_dialog_markup(true, "the_poollist", p_i, "the_poollist_entry")
	     select_pool_id[p_i] = gear_pool_id
	     p_i = p_i + 1
        end
    end
    if p_i == 1 then
	    -- wesnoth.set_dialog_active(false, "use_button")
        widget_handle = self:find('use_button')
        widget_handle.enabled = can_move
	    -- wesnoth.set_dialog_active(false, "delete_button")
        widget_handle = self:find('delete_button')
        widget_handle.enabled = can_move
    end                                    

--
    local function select()
	-- so, index [i] is refering to the item selected
        -- local i = wesnoth.get_dialog_value "the_gearlist"
        widget_handle = self:find('the_gearlist')
        local i = widget_handle.value_compat
	-- wesnoth.set_dialog_markup(true, "the_gear_description")
	if gear_text[i] then
	  else
	  gear_text[i] = "No equipment available."
	end
	-- wesnoth.set_dialog_value(gear_text[i], "the_gear_description")
    widget_handle = self:find('the_gear_description')
    widget_handle.value_compat = gear_text[i]
    return select_gear_id[i]
    end
    -- wesnoth.set_dialog_callback(select, "the_gearlist")
    widget_handle = self:find('the_gearlist')
    widget_handle.callback = select
    select()
end

local li = 0
local function postshow(self)
    -- li = wesnoth.get_dialog_value "the_gearlist"
    local widget_handle = self:find('the_gearlist')
    li = widget_handle.value_compat
    -- pli = wesnoth.get_dialog_value "the_poollist"
    widget_handle = self:find('the_poollist')
    pli = widget_handle.value_compat
 -- this is very inefficient, but replays do seem to work now.
    uli = unit_id
    dxli = dr_x
    dyli = dr_y
    sgli = select_gear_id[li]
    spli = select_pool_id[pli]
    wesnoth.interface.clear_chat_messages()
end

------------------------------------------------------------------------
-- for these three pool functions, need to have a position filter, eventually
------------------------------------------------------------------------

local function call_to_pool(u_i,sg_i)
  bmr_equipment.remove(u_i, sg_i)
  bmr_equipment.pool_add(sg_i)
end

local function call_from_pool(u_i,sp_i)
  local pter = bmr_equipment.unit(u_i, sp_i)
  if pter == "pass" or pter == "no room" then
    bmr_equipment.pool_remove(sp_i)
  end
end

local function delete_from_pool(sp_i)
  bmr_equipment.pool_remove(sp_i)
end

local function call_drop(u_i,d_x,d_y,sg_i)
  bmr_equipment.remove(u_i, sg_i)
  bmr_equipment.item_drop(d_x, d_y, sg_i)
end

local result = wesnoth.sync.evaluate_single(
  function()
    local rv = gui.show_dialog(dialog, preshow, postshow)
    return { rvs = rv, lis = li, plis = pli, ulis = uli, dxlis = dxli, dylis = dyli, sglis = sgli, splis = spli} -- keys end in 's' for 'synchronized'
  end,
  function()
    error("status_meu called by ai?")
  end)
 while result.rvs > 0 do
  if result.rvs == 3 then  --dropping: needs unit_id, context (x,y), and selected gear_id
    call_drop(result.ulis,result.dxlis,result.dylis,result.sglis)
  elseif result.rvs == 4 then  -- sending to inventory: needs unit_id, selected gear_id
    call_to_pool(result.ulis,result.sglis)
  elseif result.rvs == 6 then  -- calling from inventory: needs unit_id, selected pool-item_id
    call_from_pool(result.ulis,result.splis)
  elseif result.rvs == 5 then  -- delete from inventory: needs selected pool-item_id
    delete_from_pool(result.splis)
  end
    result = wesnoth.sync.evaluate_single(
    function()
      local rv = gui.show_dialog(dialog, preshow, postshow) -- called a second time because we are in a loop now
      return { rvs = rv, lis = li, plis = pli, ulis = uli, dxlis = dxli, dylis = dyli, sglis = sgli, splis = spli}
    end,
    function()
      error("status_meu called by ai?")
    end)
 end

end

return Status_test
