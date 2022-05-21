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
  utils.map('n', 'ñlf', require 'lspsaga.provider'.lsp_finder)
  utils.map('n', '<C-.>', require('lspsaga.codeaction').code_action)
  -- show hover doc
  utils.map('n', 'ñhd', require('lspsaga.hover').render_hover_doc)
  -- scroll down hover doc or scroll in definition preview
  utils.map('n', 'C-f>', function() require('lspsaga.action').smart_scroll_with_saga(1) end)
  -- scroll up hover doc
  utils.map('n', '<C-b>', function() require('lspsaga.action').smart_scroll_with_saga(-1) end)
  utils.map('n', 'gs', require('lspsaga.signaturehelp').signature_help)
  -- Rename
  utils.map('n', 'gr', require('lspsaga.rename').rename)
  -- preview definition
  utils.map('n', 'gp', require 'lspsaga.provider'.preview_definition)
  -- navegate between errors
  utils.map('n', '<leader>dj', require 'lspsaga.diagnostic'.lsp_jump_diagnostic_next)
  utils.map('n', '<leader>dk', require 'lspsaga.diagnostic'.lsp_jump_diagnostic_prev)
end

return M
