local package = {
	'config.treesitter',
	'config.colorizer',
	'config.gitstatussigns',
	'config.tabline',
	'config.telescope',
	'config.lsp'
}
for _, pkg in ipairs(package) do
	require(pkg)
end
require('nvim-autopairs').setup()
require("todo-comments").setup {}
require('code_runner').setup({})
-- require('config.devicon')
require('neoscroll').setup()
require('commented').setup({
	comment_padding = " ",
	keybindings = {n = "gc", v = "gc", nl = "gcc"},
	prefer_block_comment = true,
	set_keybindings = true,
	ex_mode_cmd = "Comment"
})
