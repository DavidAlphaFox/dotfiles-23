vim.g.mapleader = ' '
-- require('statusline')
local package = {
  'settings',
  'netrw',
  'plugs',
  'keymappings',
  'colorscheme',
  'status_line',
  -- 'config'
}
for _, pkg in ipairs(package) do
  local status, _  = pcall(require, pkg)
  if not status then
    print(vim.inspect("Error in module " .. pkg))
  end
end
require('config')
vim.g.pydocstring_formatter = 'google'
