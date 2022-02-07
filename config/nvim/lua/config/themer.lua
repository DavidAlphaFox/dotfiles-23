
local utils = require'utils'

local M = {}

function M.setup()
	require("themer").setup({
		colorscheme = "amora",
		transparent = true,
		dim_inactive = true,
		styles = {
			comment = { style = 'italic' },
			["function"] = { style = 'italic' },
			functionbuiltin = { style = 'italic' },
			variable = { style = 'italic' },
			variableBuiltIn = { style = 'italic' },
			parameter  = { style = 'italic' },
		},
	})

	-- Telescope
	utils.fg_bg("TelescopeBorder", "#1a1a2e", "NONE")
	utils.fg_bg("TelescopePromptBorder", "NONE", "NONE")
	utils.fg_bg("TelescopePromptNormal", "white", "NONE")
	utils.fg_bg("TelescopePromptPrefix", "#84c49b", "NONE")

	utils.fg_bg("TelescopePromptTitle", "black", "#fb5c8e")
	utils.fg_bg("TelescopePreviewTitle", "black", "#a29dff")
	utils.fg_bg("TelescopeResultsTitle", "black", "#f79f79")

	utils.bg("TelescopeResults", "NONE")
	utils.bg("TelescopeNormal", "NONE")
	utils.bg("TelescopeSelection", "#2c223c")
end

return M
