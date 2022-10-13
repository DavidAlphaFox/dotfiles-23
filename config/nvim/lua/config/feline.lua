feline = require("feline")

local theme = require("catppuccin.palettes").get_palette()
local colors = {
  bg       = theme.base,
  fg       = theme.flamingo,
  rosewater = theme.rosewater,
	flamingo  = theme.flamingo,
  pink      = theme.pink,
	mauve     = theme.mauve,
	red       = theme.red,
	maroon    = theme.maroon,
  peach     = theme.peach,
	yellow    = theme.yellow,
	green     = theme.green,
	teal      = theme.teal,
	sky       = theme.sky,
	sapphire  = theme.sapphire,
	blue      = theme.blue,
	lavender  = theme.lavender
}

local vi_mode_colors = {
	NORMAL = "mauve",
	OP = "green",
	INSERT = "teal",
	VISUAL = "peach",
	LINES = "maroon",
	BLOCK = "sky",
	REPLACE = "red",
	COMMAND = "lavender",
}

local c = {
	vim_mode = {
		provider = {
			name = "vi_mode",
			opts = {
				show_mode_name = true,
				-- padding = "center", -- Uncomment for extra padding.
			},
		},
		hl = function()
			return {
				fg = require("feline.providers.vi_mode").get_mode_color(),
				bg = "bg",
				style = "bold",
				name = "NeovimModeHLColor",
			}
		end,
		left_sep = "block",
		right_sep = "block",
	},
	gitBranch = {
		provider = "git_branch",
		hl = {
			fg = "red",
			bg = "bg",
			style = "bold",
		},
		left_sep = "block",
		right_sep = "block",
	},
	gitDiffAdded = {
		provider = "git_diff_added",
		hl = {
			fg = "green",
			bg = "bg",
		},
		left_sep = "block",
		right_sep = "block",
    icon = " "
	},
	gitDiffRemoved = {
		provider = "git_diff_removed",
		hl = {
			fg = "red",
			bg = "bg",
		},
		left_sep = "block",
		right_sep = "block",
    icon = " "
	},
	gitDiffChanged = {
		provider = "git_diff_changed",
		hl = {
			fg = "fg",
			bg = "bg",
		},
		left_sep = "block",
		right_sep = "right_filled",
    icon = " "
	},
	separator = {
		provider = "",
	},
	fileinfo = {
		provider = {
			name = "file_info",
			opts = {
				type = "relative-short",
			},
		},
		hl = {
			style = "bold",
		},
		left_sep = " ",
		right_sep = " ",
	},
	diagnostic_errors = {
		provider = "diagnostic_errors",
		hl = {
			fg = "red",
		},
    icon = "  "
	},
	diagnostic_warnings = {
		provider = "diagnostic_warnings",
		hl = {
			fg = "yellow",
		},
    icon = "  "
	},
	diagnostic_hints = {
		provider = "diagnostic_hints",
		hl = {
			fg = "sapphire",
		},
    icon = "  "
	},
	diagnostic_info = {
		provider = "diagnostic_info",
    icon = "  "
	},
	lsp_client_names = {
		provider = "lsp_client_names",
		hl = {
			fg = "yellow",
			bg = "bg",
			style = "bold",
		},
		left_sep = "left_filled",
		right_sep = "block",
    icon = " "
	},
	file_type = {
		provider = {
			name = "file_type",
			opts = {
				filetype_icon = true,
				case = "titlecase",
			},
		},
		hl = {
			fg = "teal",
			bg = "bg",
			style = "bold",
		},
		left_sep = "block",
		right_sep = "block",
	},
	file_encoding = {
		provider = "file_encoding",
		hl = {
			fg = "maroon",
			bg = "bg",
			style = "italic",
		},
		left_sep = "block",
		right_sep = "block",
	},
	position = {
		provider = "position",
		hl = {
			fg = "green",
			bg = "bg",
			style = "bold",
		},
		left_sep = "block",
		right_sep = "block",
	},
	line_percentage = {
		provider = "line_percentage",
		hl = {
			fg = "sapphire",
			bg = "bg",
			style = "bold",
		},
		left_sep = "block",
		right_sep = "block",
	},
	scroll_bar = {
		provider = "scroll_bar",
		hl = {
			fg = "lavender",
			style = "bold",
		},
	},
}

local left = {
	c.vim_mode,
	c.gitBranch,
	c.gitDiffAdded,
  c.gitDiffRemoved,
	c.gitDiffChanged,
	c.separator,
}

local middle = {
	c.fileinfo,
	c.diagnostic_errors,
	c.diagnostic_warnings,
	c.diagnostic_info,
	c.diagnostic_hints,
}

local right = {
	c.lsp_client_names,
	c.file_type,
	c.file_encoding,
	c.position,
	c.line_percentage,
	c.scroll_bar,
}

local components = {
	active = {
		left,
		middle,
		right,
	},
	inactive = {
		left,
		middle,
		right,
	},
}

feline.setup({
	components = components,
	theme = colors,
	vi_mode_colors = vi_mode_colors,
})
