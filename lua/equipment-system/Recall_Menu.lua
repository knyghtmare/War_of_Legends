z_require("recall_components")
    
Gui_recall = {}
Gui_recall.new = function()
        local self = {}      
        self.factor = 1         
-- main dialog content
        local dialog = {
        	T.tooltip { id = "tooltip_large" },
        	T.helptip { id = "tooltip_large" },
-- these linked groups don't do anything, probably not using them correctly
		T.linked_group {
			id = "call_buttons",
			fixed_width = "true",
			fixed_height = "true"
			},
		T.linked_group {
			id = "icons",
			fixed_width = "true",
			fixed_height = "true"
			},
--		maximum_height = 400,
		maximum_height = 500,
--		maximum_width = 800,
		maximum_width = 800,
		T.grid { 
			 T.row { 
			    T.column { T.spacer{ id = "tl_spacer" }},
			    T.column { T.label { id = "the_title", label = "Traveling Party", definition = "title", tooltip = "select units to be auto-recalled" }},
			    T.column { T.spacer{ id = "tr_spacer" }}
				},                                                                                                                                                
			 T.row { 
			    T.column { T.label { id = "the_on_title", label = "On Call"}},
			    T.column { T.spacer{ id = "c_spacer" }},
			    T.column { T.label { id = "the_off_title", label = "Off-duty"}}
				},                                                                                                                                                
			 T.row { 
			    T.column { horizontal_grow = true, T.listbox { vertical_scrollbar_mode = "always", id = "the_on_list", list_content()}},
			    T.column { horizontal_grow = false, T.panel { height = 700, width = 420, unit_grid()}},
			    T.column { horizontal_grow = true, T.listbox { vertical_scrollbar_mode = "always", id = "the_off_list", list_content()}}
				},
			 T.row { 
			    T.column { T.grid { 
			    		T.row { T.column { T.button { id = "update", label = _"Update", return_value= 3 }}},
			    		T.row { T.column { T.button { id = "clear", label = _"Clear All", return_value= 2 }}}
			    		}},
			    T.column { T.panel { id = "info_grid_panel", info_grid() }},
			    T.column { T.grid {
			    		T.row { T.column { T.button { id = "ok", label = _"OK" }}},
			    		T.row { T.column { T.button { id = "cancel", label = _"Cancel" }}}
					}}
				}
			}
		}
		
    local function preshow()
	uor = wesnoth.get_recall_units( { side = "1", {"filter_wml", {{"variables", { on_call = "yes"} } }}})
	uor_noc = wesnoth.get_recall_units( { side = "1", {"filter_wml", {{"variables", { on_call = "no"} } }}})
	    
	local ioc = wesnoth.get_variable("total_on_call")
	local iupkeep = wesnoth.get_variable("on_call_upkeep")
	if iupkeep then
	else
	iupkeep = 0
	end        			
	wesnoth.set_dialog_markup(true, "the_headcount")
	wesnoth.set_dialog_value(string.format("<span size='small' bgcolor='#000012'>Head Count = %d </span>", ioc) , "the_headcount")
	wesnoth.set_dialog_markup(true, "the_upkeep")
	wesnoth.set_dialog_value(string.format("<span size='small' bgcolor='#000012'>Upkeep        = %d </span>", iupkeep) , "the_upkeep")
	local function initial_toggle_on_call()
	    for i in ipairs(uor) do
	    		wesnoth.set_dialog_value(uor[i].variables.on_call, "the_on_list", i , "the_on_call_button")
	    end
	    for i in ipairs(uor_noc) do
	    		wesnoth.set_dialog_value(uor_noc[i].variables.on_call, "the_off_list", i , "the_on_call_button")
	    end
	end
-- there is probably a more compact ay to do this
    	local function select(units)

-- to display traits
	    local unit = units
	    local traits_strings = {}
	    if unit then
	      local uor_mods = helper.get_child(unit.__cfg, "modifications")
	      local c_i = 1
	      for trait in helper.child_range( uor_mods, "trait") do
	    	traits_strings[c_i] = trait.male_name
	        c_i = c_i + 1
	      end
	      if traits_strings[1] then
              else
               traits_strings[1] = "."
              end
	      if traits_strings[2] then
              else
               traits_strings[2] = "."
              end
	      wesnoth.set_dialog_markup(true, "the_unit_name")
	      wesnoth.set_dialog_markup(true, "the_unit_traits")
	      wesnoth.set_dialog_markup(true, "the_unit_type")
              wesnoth.set_dialog_value(string.format("<span size='large' underline='single'>%s</span>", unit.__cfg.name), "the_unit_name")
              wesnoth.set_dialog_value(string.format("<span style='oblique' color='#aabbcf'>%s</span>", unit.__cfg.type), "the_unit_type")
              wesnoth.set_dialog_value(string.format("<span variant='smallcaps' color='#bfa7a7'> %s \n %s</span>", traits_strings[1], traits_strings[2]) , "the_unit_traits")
              wesnoth.set_dialog_value(string.format("%s~SCALE(200,200)", unit.__cfg.profile) , "the_unit_profile")
-- to make a blank list, otherwise we are dominated by the first unit shown, I think.  This can probably be improved.
              local k = 1
              while k < 7 do
            	wesnoth.set_dialog_value(string.format("misc/blank-hex.png~SCALE(30,30)"), "the_gearlist", k, "the_gearlist_icon")
                k = k + 1
              end          
--  showing icons of the gear that the unit has, display only
--  first we black them out, to reserve space and to erase old images
              local g_i = 1
              while g_i < 9 do
		wesnoth.set_dialog_value("misc/black-box.png~SCALE(30,30)", "the_gearlist", g_i, "the_gearlist_icon")                        
                g_i = g_i + 1
              end
              g_i = 1
              local uor_gear = helper.get_child(unit.__cfg, "variables")
              for gear in helper.child_range( uor_gear , "gear") do
		wesnoth.set_dialog_value(string.format("%s~SCALE(30,30)", gear.image), "the_gearlist", g_i, "the_gearlist_icon")                        
		g_i = g_i + 1
                -- only display the first 8, this gets too big otherwise
                if g_i == 9 then
                  break
                end
              end
            end
	end
	
    	local function select_off()
	    local i = wesnoth.get_dialog_value "the_off_list"    
	    select(uor_noc[i])
	end
    	local function select_on()
	    local i = wesnoth.get_dialog_value "the_on_list"    
	    select(uor[i])
	end
	
    	wesnoth.set_dialog_callback(select_off, "the_off_list")
    	wesnoth.set_dialog_callback(select_on, "the_on_list")
-- setting up the two lists data display
-- first a blank, so the list doesn't just disappear when empty
            local k = 1
--            while k < 7 do
            	wesnoth.set_dialog_value(string.format("misc/blank-hex.png~SCALE(72,72)"), "the_on_list", k, "the_icon")
            	wesnoth.set_dialog_value("Empty List", "the_on_list", k, "the_label")
            	wesnoth.set_dialog_value("-", "the_on_list", k, "the_XP")
            	wesnoth.set_dialog_value("-", "the_on_list", k, "the_HP") 
            	wesnoth.set_dialog_value(string.format("misc/blank-hex.png~SCALE(72,72)"), "the_off_list", k, "the_icon")
            	wesnoth.set_dialog_value("Empty List", "the_off_list", k, "the_label")
            	wesnoth.set_dialog_value("-", "the_off_list", k, "the_XP")
            	wesnoth.set_dialog_value("", "the_off_list", k, "the_HP") 
--                k = k + 1
--            end          
	for i in ipairs(uor) do
	    local ut = uor[i].__cfg
	    local hp_color = "color='#999999'"
	    local xp_color = "color='#999999'"
	    local uor_status = helper.get_child(ut, "status")
	    if uor_status.poisoned then
	      hp_color = "color='#44ff44'"
	    else
	      local calc_temp = ut.hitpoints
	      calc_temp = calc_temp / ut.max_hitpoints
	      if calc_temp < 0.25 then
	        hp_color = "color='#dd3322'"
	      end
	    end			           
	    calc_temp = ut.experience
	      calc_temp = calc_temp / ut.max_experience
	      if calc_temp > 0.9 then
	        xp_color = "color='#6633ff'"
	      end
            wesnoth.set_dialog_value(string.format("<span size='small'> %s </span>" , ut.name), "the_on_list", i, "the_label")
	    wesnoth.set_dialog_markup(true, "the_on_list", i, "the_label")
	    wesnoth.set_dialog_markup(true, "the_on_list", i, "the_XP")
            wesnoth.set_dialog_value(string.format("<span size='x-small' "..xp_color..">XP: %s</span>", ut.experience), "the_on_list", i, "the_XP")
	    wesnoth.set_dialog_markup(true, "the_on_list", i, "the_HP")
            wesnoth.set_dialog_value(string.format("<span size='x-small' "..hp_color..">HP: %s</span>", ut.hitpoints), "the_on_list", i, "the_HP") 
            wesnoth.set_dialog_value(string.format("%s~RC(magenta>red)", ut.image), "the_on_list", i, "the_icon")
	end
-- make the off-duty text and icons grey
	for i in ipairs(uor_noc) do
	    local ut = uor_noc[i].__cfg
            wesnoth.set_dialog_value(string.format("<span size='small' color='#777777' > %s </span>" , ut.name), "the_off_list", i, "the_label")
	    wesnoth.set_dialog_markup(true, "the_off_list", i, "the_label")
	    wesnoth.set_dialog_markup(true, "the_off_list", i, "the_XP")
            wesnoth.set_dialog_value(string.format("<span size='x-small' color='#777777' > XP: %s </span>", ut.experience), "the_off_list", i, "the_XP")
	    wesnoth.set_dialog_markup(true, "the_off_list", i, "the_HP")
            wesnoth.set_dialog_value(string.format("<span size='x-small' color='#777777' > HP: %s </span>", ut.hitpoints), "the_off_list", i, "the_HP") 
            wesnoth.set_dialog_value(string.format("%s~GS()", ut.image), "the_off_list", i, "the_icon")
        end                    	                      
        initial_toggle_on_call()
	if uor[1] then
	  wesnoth.set_dialog_value(1, "the_on_list")
          select_on()
	else
	  if uor_noc[1] then
	    wesnoth.set_dialog_value(1, "the_off_list")
            select_off()
          end
        end
    end

-- do I really need these two variables anymore?
    local li_on = 0
    local li_off = 0
-- read the button values ...  
    local function postshow()
        li_on = wesnoth.get_dialog_value "the_on_list"
        bv_on = {}
            for i in ipairs(uor) do
                bv_on[i] =  wesnoth.get_dialog_value("the_on_list", i , "the_on_call_button")
            end
        li_off = wesnoth.get_dialog_value "the_on_list"
        bv_off = {}
            for i in ipairs(uor_noc) do
                bv_off[i] =  wesnoth.get_dialog_value("the_off_list", i , "the_on_call_button")
            end
    end
    local function call_assign(r)
--       local r = wesnoth.show_dialog(dialog, preshow, postshow)
--       wesnoth.message(string.format("Button %d pressed. Item %d selected, and %d de-selected", r, li_on, li_off))
-- ... and, if dialog was dismissed with OK or Update buttons, then write thr button values to the units (of both lists)
       if r == -1 or r == 3 then
          local ioc = 0
          local iupkeep = 0
          for i in ipairs(uor) do
              if bv_on[i] then
		 local iloyal = "no"
                 uor[i].variables.on_call = "yes"
                 ioc = ioc + 1
	         local uor_mods = helper.get_child(uor[i].__cfg, "modifications")
	         for trait in helper.child_range( uor_mods, "trait") do
		    if trait.id == "loyal" then
		        iloyal = "yes"
		    end
	         end
		 if iloyal == "no" then
		    iupkeep = iupkeep + uor[i].__cfg.level	
		 end
              else 
                 uor[i].variables.on_call = "no"
              end
          end  
          for i in ipairs(uor_noc) do
              if bv_off[i] then
		 local iloyal = "no"
                 uor_noc[i].variables.on_call = "yes"
                 ioc = ioc + 1
	         local uor_mods = helper.get_child(uor_noc[i].__cfg, "modifications")
	         for trait in helper.child_range( uor_mods, "trait") do
		    if trait.id == "loyal" then
		        iloyal = "yes"
		    end
	         end
		 if iloyal == "no" then
		    iupkeep = iupkeep + uor_noc[i].__cfg.level	
		 end
              else 
                 uor_noc[i].variables.on_call = "no"
              end
          end  
          wesnoth.set_variable("total_on_call", ioc)
          wesnoth.set_variable("on_call_upkeep", iupkeep)
       end
-- ... else if the clear/dismiss_all button was pushed, set all to "no", clear headcount 
       if r == 2 then
          local ioc = 0
          local iupkeep = 0
          for i in ipairs(uor) do
              uor[i].variables.on_call = "no"
          end  
          for i in ipairs(uor_noc) do
              uor_noc[i].variables.on_call = "no"
          end  
          wesnoth.set_variable("total_on_call", ioc)
          wesnoth.set_variable("on_call_upkeep", iupkeep)
       end
    end
-- ... and don't do anything if cancel was selected    
    local rv = wesnoth.show_dialog(dialog, preshow, postshow)
    call_assign(rv)
    while rv == 3 or rv == 2 do
    	rv = wesnoth.show_dialog(dialog, preshow, postshow)
        call_assign(rv)
    end
end                                                                                                
                                                                                                       
return Gui_recall
                                                                                                       




                        	                                           			                                                                                                                                                
