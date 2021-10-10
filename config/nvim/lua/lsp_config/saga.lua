local utils = require 'utils'
local saga = require 'lspsaga'

-- add your config value here
-- default value
-- use_saga_diagnostic_sign = true
-- error_sign = '',
-- warn_sign = '',
-- hint_sign = '',
-- infor_sign = '',
-- dianostic_header_icon = '   ',
-- code_action_icon = ' ',
-- code_action_prompt = {
--   enable = true,
--   sign = true,
--   sign_priority = 20,
--   virtual_text = true,
-- },
-- finder_definition_icon = '  ',
-- finder_reference_icon = '  ',
-- max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
-- finder_action_keys = {
--   open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
-- },
-- code_action_keys = {
--   quit = 'q',exec = '<CR>'
-- },
-- rename_action_keys = {
--   quit = '<C-c>',exec = '<CR>'  -- quit can be a table
-- },
-- definition_preview_icon = '  '
-- "single" "double" "round" "plus"
-- border_style = "single"
-- rename_prompt_prefix = '➤',
-- if you don't use nvim-lspconfig you must pass your server name and
-- the related filetypes into this table
-- like server_filetype_map = {metals = {'sbt', 'scala'}}
-- server_filetype_map = {}

saga.init_lsp_saga {
  error_sign = '',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
  -- dianostic_header_icon = '   ',
  code_action_icon = 'ﯦ'
}
-- lspsaga
-- lsp provider to find the cursor word definition and reference
utils.map('n', 'gh', [[<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>]])
-- code action
utils.map('n', '<leader>ca', [[<cmd>lua require('lspsaga.codeaction').code_action()<CR>]])
utils.map('v', '<leader>ca', [[<cmd>:<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>]])
-- show hover doc
utils.map('n', '<leader>hd', [[<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>]])
-- scroll down hover doc or scroll in definition preview
utils.map('n', 'C-f>', [[<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>]])
-- scroll up hover doc
utils.map('n', '<C-b>', [[<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>]])
utils.map('n', 'gs', [[<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>]])
-- Rename
utils.map('n', 'gr', [[<cmd>lua require('lspsaga.rename').rename()<CR>]])
-- preview definition
utils.map('n', '<leader>pd', [[<cmd>lua require'lspsaga.provider'.preview_definition()<CR>]])
-- navegate between errors
utils.map('n', '<leader>dj', [[<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>)
utils.map('n', '<leader>dk', [[<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>)
utils.map('n', 'gh', [[<cmd><CR>]])
