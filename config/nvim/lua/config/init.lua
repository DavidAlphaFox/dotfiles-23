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
require('treesitter-context').setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    throttle = true, -- Throttles plugin updates (may improve performance)
}
require('nvim-autopairs').setup()
require("nvim_comment").setup({
  hook = function()
    require("ts_context_commentstring.internal").update_commentstring()
  end,
})
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
