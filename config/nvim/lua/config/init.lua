require('config.treesitter')
require('config.colorizer')
require('nvim-autopairs').setup()
require('config.gitstatussigns')
require('config.tabline')
require('config.telescope')
require('config.floatTerm')
require('config.lsp')
require("todo-comments").setup {}
require('config.codeRunner')
-- require('config.devicon')
require('neoscroll').setup()
require('commented').setup({
	comment_padding = " ",
	keybindings = {n = "gc", v = "gc", nl = "gcc"},
	set_keybindings = true,
	ex_mode_cmd = "Comment"
})
