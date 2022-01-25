-- Packer config more complex
local package = {
	'config.colorizer',
	'config.gitstatussigns',
	'config.telescope',
	'config.multi_cursors',
	-- 'config.file_manager',
}
for _, pkg in ipairs(package) do
  local status, _  = pcall(require, pkg)
  if not status then
    print(vim.inspect("Error in module " .. pkg))
  end
end

-- Packer config minimal


require("todo-comments").setup()

-- require('code_runner').setup({
--   term = {
--     size = 15,
--   },
--   filetype_path = vim.fn.expand('~/.config/nvim/code_runner.json'),
--   project_path = vim.fn.expand('~/.config/nvim/project_manager.json'),
-- })
require('code_runner').setup {
  term = {
    size = 15,
  },
  filetype = {
    java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
    python = "python -u",
    typescript = "deno run",
    rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt"
  },
  project = {
    ["~/prueba"] = {
      name = "App1",
      description = "Tmx frontend api",
      file_name = "prueba.py"
    },
  }
}
-- native prlugins

-- require'config.pairs'.setup()
require'config.tabline'.setup()
require('package-info').setup({package_manager = 'npm'})
