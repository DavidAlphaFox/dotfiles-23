local utils = require 'utils'
local M = {}

function M.setup()
	local saga = require 'lspsaga'

	saga.init_lsp_saga {
		error_sign = '',
		warn_sign = '',
		hint_sign = '',
		infor_sign = '',
		-- dianostic_header_icon = '   ',
		code_action_icon = 'ﯦ',
		code_action_prompt = {
			enable = false,
		},
		finder_action_keys = {
			open = 'o', vsplit = 'v', split = 's', quit = 'q', scroll_down = '<C-j>', scroll_up = '<C-k>' -- quit can be a table
		},
		border_style = "round",
		rename_prompt_prefix = '»»'
	}

	-- lspsaga
	-- lsp provider to find the cursor word definition and reference
	-- lsp provider to find the cursor word definition and reference
	utils.map('n', 'ñlf', [[<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>]])
	utils.map('n', 'ñca', "<cmd>lua require('lspsaga.codeaction').code_action()<CR>")
	-- show hover doc
	utils.map('n', 'ñhd', [[<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>]])
	utils.map('n', ',sh', "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>")
	-- scroll down hover doc or scroll in definition preview
	utils.map('n', 'C-f>', [[<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>]])
	-- scroll up hover doc
	utils.map('n', '<C-b>', [[<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>]])
	utils.map('n', 'gs', [[<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>]])
	-- Rename
	utils.map('n', 'gr', [[<cmd>lua require('lspsaga.rename').rename()<CR>]])
	-- preview definition
	utils.map('n', 'gp', [[<cmd>lua require'lspsaga.provider'.preview_definition()<CR>]])
	-- navegate between errors
	utils.map('n', '<leader>dj', "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>")
	utils.map('n', '<leader>dk', "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>")
end
return M
