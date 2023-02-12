--#textdomain wesnoth-NX-RPG

local buttons = {
	use = 4;
	give = 3;
	drop = 2;
	exit = 1;
}

local item_list = T.listbox {
	id = "inventory_list",
	vertical_scrollbar_mode = "always",
	T.list_definition {
		T.row {
			T.column {
				grow_factor = 1,
				horizontal_grow = true,
				vertical_grow = true,
				T.toggle_panel {
					T.grid {
						T.row {
							grow_factor = 1,
							T.column {
								border = "all",
								border_size = 5,
								horizontal_alignment = "left",
								T.image {
									id = "list_image",
									linked_group = "image"
								}
							},
							T.column {
								border = "all",
								border_size = 5,
								horizontal_alignment = "left",
								T.label {
									id = "list_name",
									linked_group = "name"
								}
							},
							T.column {
								border = "all",
								border_size = 5,
								horizontal_alignment = "center",
								T.label {
									id = "list_quantity",
									linked_group = "quantity"
								}
							}
						}
					}
				}
			}
		}
	}
}

local details_panel_pages = T.multi_page {
	id = "details_pages",
	T.page_definition {
		T.row {
			grow_factor = 1,
			T.column {
				border = "all",
				border_size = 5,
				horizontal_alignment = "left",
				vertical_alignment = "top",
				T.label {
					definition = "title",
					id = "details_name"
				}
			}
		},
		T.row {
			grow_factor = 1,
			T.column {
				border = "all",
				border_size = 5,
				horizontal_alignment = "left",
				vertical_alignment = "top",
				T.scroll_label {
					id = "details_description",
				}
			}
		}
	}
}

local main_window = {
	maximum_height = 700,
	maximum_width = 850,

	T.helptip { id = "tooltip_large" }, -- mandatory field
	T.tooltip { id = "tooltip_large" }, -- mandatory field

	T.linked_group { id = "image", fixed_width = true },
	T.linked_group { id = "name", fixed_width = true },
	T.linked_group { id = "quantity", fixed_width = true },

	T.grid {
		T.row {
			grow_factor = 1,
			T.column {
				border = "all",
				border_size = 5,
				horizontal_alignment = "left",
				T.label {
					definition = "title",
					label = _"Inventory"
				}
			}
		},
		T.row {
			grow_factor = 1,
			T.column {
				horizontal_grow = true,
				vertical_grow = true,
				T.grid {
					T.row {
						T.column {
							border = "all",
							border_size = 5,
							horizontal_grow = true,
							vertical_grow = true,
							item_list
						},
						T.column {
							T.image {
								id = "unit_image"
							}
						}
					},
					T.row {
						grow_factor = 1,
						T.column {
							horizontal_grow = true,
							vertical_alignment = "top",
							details_panel_pages
						},
						T.column {
							grow_factor = 1,
							horizontal_alignment = "right",
							T.grid {
								T.row {
									T.column {
										border = "all",
										border_size = 5,
										T.button {
											id = "use_button",
											return_value = buttons.use,
											label = _"Use Item"
										}
									}
								},
								T.row {
									T.column {
										border = "all",
										border_size = 5,
										T.button {
											id = "give_button",
											return_value = buttons.give,
											label = _"Give Item"
										}
									}
								},
								T.row {
									T.column {
										border = "all",
										border_size = 5,
										T.button {
											id = "drop_button",
											return_value = buttons.drop,
											label = _"Drop Item"
										}
									}
								},
								T.row {
									T.column {
										border = "all",
										border_size = 5,
										T.button {
											id = "ok_button",
											return_value = buttons.exit,
											label = _"Exit"
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
}

local empty_inv_window = {
	maximum_height = 100,
	maximum_width = 800,

	click_dismiss = true,

	T.helptip { id = "tooltip_large" }, -- mandatory field
	T.tooltip { id = "tooltip_large" }, -- mandatory field

	T.grid {
		T.row {
			grow_factor = 1,
			T.column {
				border = "all",
				border_size = 5,
				T.image {
					label = "icons/icon_inv.png"
				}
			},
			T.column {
				border = "all",
				border_size = 5,
				vertical_alignment = "center",
				horizontal_alignment = "center",
				T.label {
					label = _"Your inventory is empty.\n \nPerhaps you should look around for items that might be useful."
				}
			}
		}
	}
}

return {
	buttons = buttons;
	normal = main_window;
	empty = empty_inv_window;
}
