vim.g.mapleader = ' '
-- require('statusline')
local package = {
  'settings',
  'netrw',
  'plugs',
  'colorscheme',
  'status_line',
  'keymappings',
  'config'
}
for _, pkg in ipairs(package) do
  require(pkg)
end
vim.g.pydocstring_formatter = 'google'
