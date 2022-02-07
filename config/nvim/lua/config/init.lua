-- Packer config more complex
local package = {
	'config.telescope',
	-- 'config.multi_cursors',
}
for _, pkg in ipairs(package) do
  local status, _  = pcall(require, pkg)
  if not status then
    print(vim.inspect("Error in module " .. pkg))
  end
end

-- native prlugins

require'config.tabline'.setup()

