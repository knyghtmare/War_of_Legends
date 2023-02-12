local alert_dialog = {
	maximum_width = 640,
	maximum_height = 400,
	T.helptip { id="tooltip_large" }, -- mandatory field
	T.tooltip { id="tooltip_large" }, -- mandatory field
	T.grid { -- Title, will be the object name
		T.row {
			T.column {
				horizontal_alignment = "left",
				grow_factor = 1, -- this one makes the title bigger and golden
				border = "all",
				border_size = 5,
				T.label { definition = "title", id = "title", wrap = true }
			}
		},
		T.row {
			T.column {
				vertical_alignment = "center",
				horizontal_alignment = "center",
				border = "all",
				border_size = 5,
				T.label { id = "message", wrap = true }
			}
		},
		T.row {
			T.column {
				horizontal_grow = true,
				T.grid {
					T.row {
						T.column {
							horizontal_alignment = "left",
							border = "all",
							border_size = 5,
							grow_factor = 1,
							T.button { id = "details" }
						},
						T.column {
							horizontal_alignment = "right",
							border = "all",
							border_size = 5,
							T.button { id = "ok", return_value = 1 }
						},
						T.column {
							horizontal_alignment = "right",
							border = "all",
							border_size = 5,
							T.button { id = "quit", return_value = 2 }
						}
					}
				}
			}
		}
		
	}
}
		
local dialog = {
	maximum_width = 640,
	maximum_height = 400,
	T.helptip { id="tooltip_large" },
	T.tooltip { id="tooltip_large" },
	T.grid {
		T.row {
			T.column {
				horizontal_alignment = "left",
				grow_factor = 1,
				border = "all",
				border_size = 5,
				T.label { definition = "title", id = "title", wrap = true }
			}
		},
		T.row {
			T.column {
				horizontal_alignment = "left",
				border = "all",
				border_size = 5,
				T.label { id = "message", wrap = true }
			}
		},
		T.row {
			T.column {
				vertical_alignment = "center",
				horizontal_grow = "true",
				border = "all",
				border_size = 5,
				T.scroll_label { id = "wml", vertical_scrollbar_mode = "always" }
			},
		},
		T.row {
			T.column {
				horizontal_alignment = "right",
				border = "all",
				border_size = 5,
				T.button { id = "ok" }
			}
		}
	}
}	
