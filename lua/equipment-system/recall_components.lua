-- not sure this really needed to be its own file
function list_content() 
        		return T.list_definition { T.row { T.column { horizontal_grow = true, 
                                 T.toggle_panel { T.grid { 
				     T.row { 
                                             T.column { horizontal_grow = false, horizontal_alignment = "left", T.toggle_button { tooltip = "sets whether is 'on call' or not" , definition ='radio', id = "the_on_call_button", linked_group = "call_buttons"} },
                                             T.column { horizontal_grow = false, horizontal_alignment = "left", T.grid { 
		                                        T.row { T.column { horizontal_alignment = "left", T.spacer { width = 100 } }},
                                                        T.row { T.column { horizontal_alignment = "left", T.label { text_aligment = "left", id = "the_label"} }},
                                                        T.row { T.column { horizontal_alignment = "center", T.label { text_aligment = "left", id = "the_HP"} }},
                                                        T.row { T.column { horizontal_alignment = "center", T.label { text_aligment = "left", id = "the_XP"} }}
                                                      }},
                                             T.column { horizontal_grow = true, horizontal_alignment = "right", T.image { id = "the_icon", linked_group = "icons" } }
					   }
					}}
				}}}
end                                                                                                                                                                
function info_grid()
			return T.grid {
				T.row { T.column { horizontal_alignment = "left", T.label { id = "the_headcount"}}},
				T.row { T.column { horizontal_alignment = "left", T.label { id = "the_upkeep"}}}
				}
end                                                                                                                                                                
function unit_grid()
			return T.grid {
				T.row { T.column { horizontal_grow = true, T.label { id = "the_unit_name"}}},
				T.row { T.column { horizontal_grow = true, T.label { id = "the_unit_type"}}},
				T.row { T.column { T.image { id = "the_unit_profile"}}},
				T.row { T.column { horizontal_alignment = "center", T.label { wrap = "false", id = "the_unit_traits"}}},
				T.row { T.column { T.horizontal_listbox { id = "the_gearlist" , 
							T.list_definition { 
							    T.row { T.column { horizontal_grow = true,
								T.toggle_panel { T.grid { T.row { T.column { T.image { tooltip = "equipment" , id = "the_gearlist_icon"}}}}}
							    }}
							}
				}}}
			  }

end                                                                                                                                                                
