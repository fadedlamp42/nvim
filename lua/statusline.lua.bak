local gl = require("galaxyline")
local gls = gl.section
gl.short_line_list = { "LuaTree", "vista", "dbui" }

-- aliases
local colors = {
	darkblue = "#081633",
	green = "#afd700",
	orange = "#FF8800",
	purple = "#5d4d7a",
	magenta = "#d16d9e",
	grey = "#c0c0c0",
	blue = "#0087d7",
	tardis = "#1d5385",
	inverted_taffy = "#4b2cff",
	red = "#ec5f67",
}

local palette = {
	bg = "#282c34",
	text_light = colors.grey,
	text_dark = colors.inverted_taffy,
	accent_light = colors.tardis,
	accent_dark = colors.darkblue,
}

-- utility functions
local buffer_not_empty = function()
	if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
		return true
	end
	return false
end

local checkwidth = function()
	local squeeze_width = vim.fn.winwidth(0) / 2
	if squeeze_width > 40 then
		return true
	end
	return false
end

-- left section
gls.left[1] = {
	FirstElement = {
		provider = function()
			return " "
		end,
		highlight = { palette.accent_light, palette.accent_light },
	},
}
gls.left[2] = {
	ViMode = {
		provider = function()
			local alias =
				{ n = "NORMAL", i = "INSERT", c = "COMMAND", v = "VISUAL", V = "VISUAL LINE", [""] = "VISUAL BLOCK" }
			return alias[vim.fn.mode()]
		end,
		separator = "█ ",
		separator_highlight = {
			palette.accent_light,
			function()
				if not buffer_not_empty() then
					return palette.accent_light
				end
				return palette.accent_dark
			end,
		},
		highlight = { palette.text_light, palette.accent_light, "bold" },
	},
}
--[[gls.left[3] ={
  FileIcon = {
    provider = 'FileIcon',
    condition = buffer_not_empty,
    highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.darkblue},
  },
}]]
gls.left[4] = {
	FileName = {
		provider = { "FileName", "FileSize" },
		condition = buffer_not_empty,
		separator = "",
		separator_highlight = { palette.accent_dark, palette.accent_light },
		highlight = { palette.text_dark, palette.accent_dark },
	},
}

gls.left[5] = {
	GitIcon = {
		provider = function()
			return " ⬤ "
		end,
		condition = buffer_not_empty,
		highlight = { colors.orange, palette.accent_light },
	},
}
gls.left[6] = {
	GitBranch = {
		provider = "GitBranch",
		condition = buffer_not_empty,
		highlight = { palette.text_light, palette.accent_light },
	},
}

gls.left[7] = {
	DiffAdd = {
		provider = "DiffAdd",
		condition = checkwidth,
		icon = "+ ",
		highlight = { colors.green, palette.accent_light },
	},
}
gls.left[8] = {
	DiffModified = {
		provider = "DiffModified",
		condition = checkwidth,
		icon = "~ ",
		highlight = { colors.orange, palette.accent_light },
	},
}
gls.left[9] = {
	DiffRemove = {
		provider = "DiffRemove",
		condition = checkwidth,
		icon = "- ",
		highlight = { colors.red, palette.accent_light },
	},
}
gls.left[10] = {
	LeftEnd = {
		provider = function()
			return " "
		end,
		separator = "",
		separator_highlight = { palette.accent_light, colors.bg },
		highlight = { palette.accent_light, palette.accent_light },
	},
}
gls.left[11] = {
	DiagnosticError = {
		provider = "DiagnosticError",
		icon = "  ",
		highlight = { colors.red, colors.bg },
	},
}
gls.left[12] = {
	Space = {
		provider = function()
			return " "
		end,
		highlight = { colors.bg, colors.bg },
	},
}
gls.left[13] = {
	DiagnosticWarn = {
		provider = "DiagnosticWarn",
		icon = "  ",
		highlight = { colors.blue, colors.bg },
	},
}

-- right section
gls.right[1] = {
	FileFormat = {
		provider = "FileFormat",
		separator = "█",
		separator_highlight = { palette.accent_light, colors.bg },
		highlight = { palette.text_light, palette.accent_light },
	},
}
gls.right[2] = {
	LineInfo = {
		provider = "LineColumn",
		separator = " ",
		separator_highlight = { palette.accent_dark, palette.accent_light },
		highlight = { palette.text_light, palette.accent_light },
	},
}
gls.right[3] = {
	PerCent = {
		provider = "LinePercent",
		separator = "",
		separator_highlight = { palette.accent_dark, palette.accent_light },
		highlight = { palette.text_light, palette.accent_dark },
	},
}

-- shortened left section
gls.short_line_left[1] = {
	BufferType = {
		provider = "FileName",
		separator = "",
		separator_highlight = { palette.accent_light, colors.bg },
		highlight = { palette.text_light, palette.accent_light },
	},
}

-- shortened right section
gls.short_line_right[1] = {
	FileFormatShort = {
		provider = "FileFormat",
		condition = buffer_not_empty,
		separator = "█",
		separator_highlight = { palette.accent_light, colors.bg },
		highlight = { palette.text_light, palette.accent_light },
	},
}
