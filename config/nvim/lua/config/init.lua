local package = {
	'config.treesitter',
	'config.colorizer',
	'config.gitstatussigns',
	'config.tabline',
	'config.telescope',
	'config.lsp'
}
for _, pkg in ipairs(package) do
  local status, _  = pcall(require, pkg)
  if not status then
    print(vim.inspect("Error in module " .. pkg))
  end
end
require('nvim-autopairs').setup()
require("todo-comments").setup {}
require('code_runner').setup({
  filetype = {
    json_path = vim.fn.expand('~/.config/nvim/code_runner.json'),
  },
  project_context = {
    json_path = vim.fn.expand('~/.config/nvim/project_manager.json'),
  }
})
-- require('config.devicon')
require('neoscroll').setup()
require('commented').setup({
	comment_padding = " ",
	keybindings = {n = "gc", v = "gc", nl = "gcc"},
	prefer_block_comment = true,
	set_keybindings = true,
	ex_mode_cmd = "Comment"
})
