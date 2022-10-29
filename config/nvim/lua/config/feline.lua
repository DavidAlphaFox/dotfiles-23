feline = require("feline")

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
				bg = "base",
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
			bg = "base",
			style = "bold",
		},
		left_sep = "block",
		right_sep = "block",
	},
	gitDiffAdded = {
		provider = "git_diff_added",
		hl = {
			fg = "green",
			bg = "base",
		},
		left_sep = "block",
		right_sep = "block",
    icon = " "
	},
	gitDiffRemoved = {
		provider = "git_diff_removed",
		hl = {
			fg = "red",
			bg = "base",
		},
		left_sep = "block",
		right_sep = "block",
    icon = " "
	},
	gitDiffChanged = {
		provider = "git_diff_changed",
		hl = {
			fg = "flamingo",
			bg = "base",
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
			bg = "base",
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
			bg = "base",
			style = "bold",
		},
		left_sep = "block",
		right_sep = "block",
	},
	file_encoding = {
		provider = "file_encoding",
		hl = {
			fg = "maroon",
			bg = "base",
			style = "italic",
		},
		left_sep = "block",
		right_sep = "block",
	},
	position = {
		provider = "position",
		hl = {
			fg = "green",
			bg = "base",
			style = "bold",
		},
		left_sep = "block",
		right_sep = "block",
	},
	line_percentage = {
		provider = "line_percentage",
		hl = {
			fg = "sapphire",
			bg = "base",
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

local colors = require("catppuccin.palettes").get_palette()
local M = {}
M.setup = function()
  feline.setup({
    components = components,
    theme = colors,
    vi_mode_colors = vi_mode_colors,
  })
end
return M
