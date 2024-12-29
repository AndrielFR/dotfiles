local hlgroups = require("cokeline.hlgroups")

local color1 = "#524e4c"
local color2 = "#f6f5f4"
local color3 = "#292726"

require("cokeline").setup({
	default_hl = {
		fg = color2,
		bg = function(buffer)
			return buffer.is_focused and color1 or color3
		end,
	},

	components = {
		{
			text = "|",
			fg = function(buffer)
				return buffer.is_modified and color2 or color3
			end,
		},
		{
			text = function(buffer)
				return buffer.devicon.icon .. " "
			end,
			fg = function(buffer)
				return buffer.devicon.color
			end,
		},
		{
			text = function(buffer)
				return buffer.index .. ": "
			end,
		},
		{
			text = function(buffer)
				return buffer.unique_prefix
			end,
			fg = hlgroups.get_hl_attr("Comment", "fg"),
			style = "italic",
		},
		{
			text = function(buffer)
				return buffer.filename .. " "
			end,
			style = function(buffer)
				return buffer.is_focused and "bold" or nil
			end,
		},
		{
			text = " ",
		},
	},
})
