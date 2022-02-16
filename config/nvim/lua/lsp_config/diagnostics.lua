local utils = require 'utils'

local M = {}

function M.setup()
	-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	-- 	vim.lsp.diagnostic.on_publish_diagnostics, {
	-- 		virtual_text = {
	-- 			prefix = "",
	-- 			spacing = 4,
	-- 		},
	-- 		signs = true,
	-- 		update_in_insert = false,
	-- 	}
	-- )

	--[[ vim.fn.sign_define('LspDiagnosticsSignError', { text = "", texthl = "LspDiagnosticsDefaultError" })
vim.fn.sign_define('LspDiagnosticsSignWarning', { text = "", texthl = "LspDiagnosticsDefaultWarning" })
vim.fn.sign_define('LspDiagnosticsSignInformation', { text = "", texthl = "LspDiagnosticsDefaultInformation" })
vim.fn.sign_define('LspDiagnosticsSignHint', { text = "", texthl = "LspDiagnosticsDefaultHint" }) ]]

	vim.cmd [[ autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost * silent! TroubleRefresh ]]

	require("trouble").setup {
		auto_close = true,
		signs = {
			-- icons / text used for a diagnostic
			error = " ",
			warning = " ",
			hint = "",
			information = " ",
			other = " "
		},
	}

	utils.map("n", "<leader>dx", "<cmd>TroubleToggle<cr>")
	utils.map("n", "<leader>dw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
	utils.map("n", "<leader>dd", "<cmd>TroubleToggle document_diagnostics<cr>")
	utils.map("n", "<leader>dq", "<cmd>TroubleToggle quickfix<cr>")
	utils.map("n", "<leader>dl", "<cmd>TroubleToggle loclist<cr>")
	utils.map("n", "gR", "<cmd>TroubleToggle lsp_references<cr>")
end

return M
