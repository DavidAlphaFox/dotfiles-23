-- Packer Plugins more complex
local package = {
	'plugins.manage',
  'plugins.tabline',
	'plugins.treesitter',
	'plugins.colorizer',
	'plugins.gitstatussigns',
	'plugins.telescope',
	'plugins.multi_cursors',
	'plugins.file_manager',
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

require('Comment').setup(
  {
      ---@param ctx Ctx
      pre_hook = function(ctx)
          -- Only update commentstring for tsx filetypes
          if vim.bo.filetype == 'typescriptreact' then
              require('ts_context_commentstring.internal').update_commentstring()
          end
      end
  }
)

-- native prlugins
-- require "pears".setup()
