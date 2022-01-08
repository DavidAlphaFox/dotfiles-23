local gl = require("galaxyline")
gl.short_line_list = {
	"LuaTree",
	"vista",
	"dbui",
	"startify",
	"term",
	"nerdtree",
	"fugitive",
	"fugitiveblame",
	"plug",
}
-----------------------------------------------------
----------------- build panels ----------------------
-----------------------------------------------------

require("status_line.nerd.mode_panel")
require("status_line.nerd.filetype_panel")
require("status_line.nerd.git_panel")
require("status_line.nerd.lsp_panel")
require("status_line.nerd.text_info_panel")
