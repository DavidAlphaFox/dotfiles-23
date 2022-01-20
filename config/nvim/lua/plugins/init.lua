-- Packer Plugins more complex
local package = {
	'plugins.manage',
	'plugins.treesitter',
	'plugins.colorizer',
	'plugins.gitstatussigns',
	'plugins.telescope',
	'plugins.multi_cursors',
	-- 'plugins.file_manager',
}
for _, pkg in ipairs(package) do
  local status, _  = pcall(require, pkg)
  if not status then
    print(vim.inspect("Error in module " .. pkg))
  end
end

-- Packer Plugins minimal
require('treesitter-context').setup()

require("todo-comments").setup()

require('code_runner').setup({
  term = {
    size = 15,
  },
  filetype_path = vim.fn.expand('~/.config/nvim/code_runner.json'),
  project_path = vim.fn.expand('~/.config/nvim/project_manager.json'),
})

-- native prlugins
require'lightspeed'.setup {
  limit_ft_matches = 30,
}

require('Comment').setup()
require'plugins.pairs'.setup()
require'plugins.tabline'.setup()
require('package-info').setup({package_manager = 'npm'})
