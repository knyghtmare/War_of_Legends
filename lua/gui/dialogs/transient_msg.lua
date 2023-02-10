
local image = T.image {
	id = "image"
}

local msg_body = T.column {
	T.grid {
		T.row {
			T.column {
				border = "all",
				border_size = 5,
				vertical_alignment = "top",
				horizontal_alignment = "left",
				T.label {
					id = "caption",
					definition = "title"
				}
			}
		},
		T.row {
			T.column {
				border = "all",
				border_size = 5,
				vertical_alignment = "top",
				horizontal_alignment = "left",
				T.label {
					id = "message",
					definition = "wml_message",
					wrap = true
				}
			}
		}
	}
}

return function(have_image)
	return {
		maximum_width = 800,
		maximum_height = 600,
		click_dismiss = true,
		T.helptip { id="tooltip_large" }, -- mandatory field
		T.tooltip { id="tooltip_large" }, -- mandatory field

		T.grid {
			T.row {
				T.column {
					border = "all",
					-- HACK: Don't set a border size for the image cell when
					-- there's no image to display; this way it doesn't result
					-- in some empty space to the left of the text.
					border_size = have_image and 5 or 0,
					horizontal_alignment = "center",
					vertical_alignment = "center",
					image
				},
				msg_body
			}
		}
	}
end
