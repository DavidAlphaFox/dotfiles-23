require('fm-nvim').setup{
	border   = "rounded", -- opts: 'rounded'; 'double'; 'single'; 'solid'; 'shawdow'

	-- Percentage (0.7 = 70%)
	height   = 0.7,
	width    = 0.7,

	-- Command used to open files
	edit_cmd = "edit", -- opts: 'tabedit'; 'split'; 'pedit'; etc...

	-- Mappings used inside the floating window
	mappings = {
		vert_split = "<C-v>",
		horz_split = "<C-h>",
		tabedit    = "<CR>",
		edit       = "<C-e>",
		ESC        = "<ESC>"
	}
}

local utils = require 'utils'
-- utils.map('n', 'ññ', ":lua require'lir.float'.toggle()<CR>")
utils.map('n', 'ññ', ":Ranger<CR>")
