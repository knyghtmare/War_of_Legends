--#textdomain wesnoth-NX-RPG

local buttons = {
	close = 1;
}

local topic_list = T.listbox {
	id = "topic_list",
	T.list_definition {
		T.row {
			T.column {
				vertical_grow = true,
				horizontal_grow = true,
				grow_factor = 1,
				T.toggle_panel {
					T.grid {
						T.row {
							T.column {
								border = "all",
								border_size = 5,
								T.image {
									id = "topic_list_image",
									linked_group = "images",
									label = "icons/menu-book.png"
								}
							},
							T.column {
								border = "all",
								border_size = 5,
								T.label {
									id = "topic_list_name",
									linked_group = "names"
								}
							},
							T.column {
								border = "all",
								border_size = 5,
								T.spacer {
									width = 5
								}
							}
						}
					}
				}
			}
		}
	}
}

local main_window = {
	maximum_height = 1100,
	maximum_width = 800,
	T.helptip { id = "tooltip_large" }, -- mandatory field
	T.tooltip { id = "tooltip_large" }, -- mandatory field
	T.linked_group { id = "images", fixed_width = true },
	T.linked_group { id = "names", fixed_width = true },
	T.grid {
		T.row {
			grow_factor = 1,
			T.column {
				border = "all",
				border_size = 5,
				horizontal_alignment = "left",
				T.label {
					definition = "title",
					label = _ "Help Topics"
				}
			}
		},
		T.row {
			T.column {
				grow_factor = 1,
				T.grid {
					T.row {
						grow_factor = 1,
						T.column {
							border = "all",
							border_size = 5,
							vertical_alignment = "top",
							topic_list
						},
						T.column {
							T.multi_page {
								id = "help_text_pages",
								T.page_definition {
									T.row {
										grow_factor = 1,
										T.column {
											border = "all",
											border_size = 5,
											vertical_grow = true,
											T.scroll_label {
												id = "topic_text",
											}
										}
									}
								}
							}
						}
					}
				}
			}
		},
		T.row {
			T.column {
				border = "all",
				border_size = 5,
				horizontal_alignment = "right",
				T.button {
					id = "close_button",
					return_value = buttons.close,
					label = _ "Close"
				}
			}
		}
	}
}

return main_window
