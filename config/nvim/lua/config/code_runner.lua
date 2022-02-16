
local M = {}

function M.setup()
	require('code_runner').setup({
		term = {
			tab = true,
			mode = "startinsert",
			size = 15
		},
		filetype_path = vim.fn.expand('~/.config/nvim/code_runner.json'),
		project_path = vim.fn.expand('~/.config/nvim/project_manager.json'),
	})
	-- require('code_runner').setup {
	--   term = {
	--     size = 15,
	--   },
	--   filetype = {
	--     java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
	--     python = "python -u",
	--     typescript = "deno run",
	--     rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt"
	--   },
	--   project = {
	--     ["~/prueba"] = {
	--       name = "App1",
	--       description = "Tmx frontend api",
	--       file_name = "prueba.py"
	--     },
	--   }
	-- }
end

return M

