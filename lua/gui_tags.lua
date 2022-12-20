-- to make code shorter
local wml_actions = wesnoth.wml_actions

-- metatable for GUI tags
local T = wml.tag

-- support for translatable strings, custom textdomain
local _ = wesnoth.textdomain "wesnoth-War_of_Legends"
-- #textdomain wesnoth-AotW

-- [item_dialog]
-- an alternative interface to pick items
-- could be used in place of [message] with [option] tags
function wml_actions.item_dialog( cfg )
	local image_and_description = T.grid {
					T.row {
						T.column {
							vertical_alignment = "center",
							horizontal_alignment = "center",
							border = "all",
							border_size = 5,
							T.image {
								id = "image_name"
							}
						},
						T.column {
							horizontal_alignment = "left",
							border = "all",
							border_size = 5,
							T.scroll_label {
								id = "item_description"
							}
						}
					}
				}

	local buttonbox = T.grid {
				T.row {
					T.column {
						T.button {
							id = "take_button",
							return_value = 1
						}
					},
					T.column {
						T.spacer {
							width = 10
						}
					},
					T.column {
						T.button {
							id = "leave_button",
							return_value = 2
						}
					}
				}
			}

	local item_dialog = {
		T.helptip { id="tooltip_large" }, -- mandatory field
		T.tooltip { id="tooltip_large" }, -- mandatory field
		maximum_height = 320,
		maximum_width = 480,
		T.grid { -- Title, will be the object name
			T.row {
				T.column {
					horizontal_alignment = "left",
					grow_factor = 1,
					border = "all",
					border_size = 5,
					T.label {
						definition = "title",
						id = "item_name"
					}
				}
			},
			-- Image and item description
			T.row {
				T.column {
					image_and_description
				}
			},
			-- Effect description
			T.row {
				T.column {
					horizontal_alignment = "left",
					border = "all",
					border_size = 5,
					T.label {
						wrap = true,
						id = "item_effect"
					}
				}
			},
			-- button box
			T.row {
				T.column {
					buttonbox
				}
			}
		}
	}

	local function item_preshow(dialog)
		-- here set all widget starting values
		dialog.item_description.use_markup = true
		dialog.item_effect.use_markup = true
		dialog.item_name.label = cfg.name or ""
		dialog.image_name.label = cfg.image or ""
		dialog.item_description.label = cfg.description or ""
		dialog.item_effect.label = cfg.effect or ""
		dialog.take_button.label = cfg.take_string or wml.error( "Missing take_string= key in [item_dialog]" )
		dialog.leave_button.label = cfg.leave_string or wml.error( "Missing leave_string= key in [item_dialog]" )
	end

	local function sync()
		local function item_postshow(dialog)
			-- here get all widget values
		end

		local return_value = gui.show_dialog( item_dialog, item_preshow, item_postshow )

		return { return_value = return_value }
	end

	local return_table = wesnoth.sync.evaluate_single(sync)
	if return_table.return_value == 1 or return_table.return_value == -1 then
		wml.variables[cfg.variable or "item_picked"] = "yes"
	else wml.variables[cfg.variable or "item_picked"] = "no"
	end
end

-- the three tags below are WML/Lua remakes of Javascript's standard dialogs alert(), confirm() and prompt()
function wml_actions.alert( cfg )
	if cfg.title then
		gui.alert(cfg.title, cfg.message)
	else
		gui.alert(cfg.message)
	end
end

function wml_actions.confirm( cfg )
	local variable = cfg.variable or wml.error( "Missing variable= key in [confirm]" )

	local function sync()
		if cfg.title then
			return { return_value = gui.confirm(cfg.title, cfg.message) }
		else
			return { return_value = gui.confirm(cfg.message) }
		end
	end

	local return_table = wesnoth.sync.evaluate_single(sync)
	wml.variables[variable] = return_table.return_value
end

function wml_actions.prompt( cfg )
	local variable = cfg.variable or wml.error( "Missing variable= key in [prompt]" )

	local buttonbox = T.grid {
				T.row {
					T.column {
						T.button {
							label = "OK",
							return_value = 1
						}
					},
					T.column {
						T.spacer {
							width = 10
						}
					},
					T.column {
						T.button {
							label = "Close",
							return_value = 2
						}
					}
				}
			}

	local prompt_dialog = {
		T.helptip { id="tooltip_large" }, -- mandatory field
		T.tooltip { id="tooltip_large" }, -- mandatory field
		maximum_height = 600,
		maximum_width = 800,
		T.grid { -- Title, will be the object name
			T.row {
				T.column {
					horizontal_alignment = "left",
					grow_factor = 1,
					border = "all",
					border_size = 5,
					T.label {
						definition = "title",
						id = "title"
					}
				}
			},
			T.row {
				T.column {
					vertical_alignment = "center",
					horizontal_alignment = "center",
					border = "all",
					border_size = 5,
					T.scroll_label {
						id = "message"
					}
				}
			},
			T.row {
				T.column {
					vertical_alignment = "center",
					horizontal_alignment = "center",
					border = "all",
					border_size = 5,
					T.text_box {
						id = "text"
					}
				}
			},
			-- button box
			T.row {
				T.column {
					vertical_alignment = "center",
					horizontal_alignment = "center",
					border = "all",
					border_size = 5,
					buttonbox
				}
			}
		}
	}

	local function preshow(dialog)
		-- here set all widget starting values
		dialog.message.use_markup = true
		dialog.title.label = cfg.title or ""
		dialog.message.label = cfg.message or ""
		-- in 1.15.x, setting a translatable string as value of a text box
		-- widget raises an error; handle this case
		if cfg.text then
			dialog.text.text = tostring(cfg.text)
		end
	end

	local function sync()
		local input

		local function postshow(dialog)
			-- here get all widget values
			input = dialog.text.text
		end

		local return_value = gui.show_dialog( prompt_dialog, preshow, postshow )
		return { return_value = return_value, input = input }
	end

	local return_table = wesnoth.sync.evaluate_single(sync)
	local return_value = return_table.return_value

	if return_value == 1 or return_value == -1 then -- if used pressed OK or Enter
		wml.variables[variable] = return_table.input
	elseif return_value == 2 or return_value == -2 then -- if user pressed Cancel or Esc
		wml.variables[variable] = "null" -- any better choice?
	else wml.error( ( tostring( _"Prompt" ) .. ": " .. tostring( _"Error, return value :" ) .. tostring( return_value ) ) ) end -- any unhandled case is handled here
end

function wml_actions.choice_box( cfg )
	local variable = cfg.variable or wml.error( "Missing variable= key in [choice_box]" )
	local choice_values = {} -- it will be populated by preshow, and supply values to postshow

	local buttonbox = T.grid {
				T.row {
					T.column {
						T.button { 
							label = _"OK",
							return_value = 1
						} 
					},
					T.column {
						T.spacer { width = 10 }
						},
					T.column {
						T.button {
							label = _"Cancel",
							return_value = 2
						}
					}
				}
			}

	local toggle_grid = T.grid {
				T.row {
					T.column {
						horizontal_alignment = "left",
						border = "all",
						border_size = 5,
						T.image {
							id = "choice_image",
							linked_group = "image"
							}
						},
					T.column {
						horizontal_alignment = "left",
						border = "all",
						border_size = 5,
						T.label {
							text_alignment = "left",
							id = "choice_description",
							linked_group = "description"
						}
					},
					T.column {
						horizontal_alignment = "right",
						border = "all",
						border_size = 5,
						T.label {
							text_alignment = "right",
							id = "choice_note",
							linked_group = "note"
						}
					}
				}
			}

	local listbox_dialog = {
		T.tooltip { id = "tooltip_large" },
		T.helptip { id = "tooltip_large" },
		-- these linked groups are essential to ensure
		-- that all the items in the listbox are nicely aligned
		T.linked_group {
			id = "image",
			fixed_width = "true",
			fixed_height = "true"
		},
		T.linked_group {
			id = "description",
			fixed_width = "true",
			fixed_height = "true"
		},
		T.linked_group {
			id = "note",
			fixed_width = "true",
			fixed_height = "true"
		},
		maximum_height = 600,
		maximum_width = 800,
		T.grid {
			T.row {
				T.column {
					horizontal_alignment = "left",
					border = "all",
					border_size = 5,
					T.label {
						definition = "title",
						id = "window_title"
					}
				}
			},
			T.row {
				T.column {
					horizontal_alignment = "left",
					border = "all",
					border_size = 5,
					T.scroll_label {
						id = "window_message",
					}
				}
			},
			T.row {
				T.column {
					border = "all",
					border_size = 5,
					T.listbox {
						id = "choices_listbox",
						horizontal_grow = true,
						T.list_definition {
							T.row {
								T.column {
									horizontal_grow = true,
									T.toggle_panel {
										toggle_grid
									}
								}
							}
						}
					}
				}
			},
			T.row {
				T.column {
					buttonbox
				}
			}
		}
	}

	local function preshow(dialog)
		dialog.window_title.label = cfg.title
		dialog.window_message.label = cfg.message
		dialog.window_message.use_markup = true
		
		local counter = 1
		for option in wml.child_range( cfg, "option") do
			if option.value then
				choice_values[counter] = option.value
			else
				choice_values[counter] = counter -- just the same number, for simplicity sake
			end
			dialog.choices_listbox[counter].choice_image.label = option.image or ""
			dialog.choices_listbox[counter].choice_description.label = option.description or ""
			dialog.choices_listbox[counter].choice_description.use_markup = true
			dialog.choices_listbox[counter].choice_note.label = option.note or ""
			dialog.choices_listbox[counter].choice_note.use_markup = true
			counter = counter + 1
		end
	end
	local function sync()
		local choice_index
		local function postshow(dialog)
			choice_index = dialog.choices_listbox.selected_index
		end
		local return_value = gui.show_dialog( listbox_dialog, preshow, postshow )
		return { return_value = return_value, choice = choice_values[choice_index] } -- and retrieve the associated value
	end

	local return_table = wesnoth.sync.evaluate_single(sync)
	local return_value = return_table.return_value

	if return_value == 1 or return_value == -1 then -- if used pressed OK or Enter
		wml.variables[variable] = return_table.choice
	elseif return_value == 2 or return_value == -2 then -- if user pressed Cancel or Esc
		wml.variables[variable] = "null" -- any better choice?
	else wml.error( ( tostring( _"Choice box" ) .. ": " .. tostring( _"Error, return value :" ) .. tostring( return_value ) ) ) end -- any unhandled case is handled here
end