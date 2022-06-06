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
  utils.map('n', '<A-f>', require 'lspsaga.provider'.lsp_finder)
  utils.map('n', '<C-.>', require('lspsaga.codeaction').code_action)
  -- vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>
  -- show hover doc
  utils.map('n', '<C-h>', require('lspsaga.hover').render_hover_doc)
  utils.map('n', 'C-f>', function() require('lspsaga.action').smart_scroll_with_saga(1) end)
  utils.map('n', '<C-b>', function() require('lspsaga.action').smart_scroll_with_saga(-1) end)
  utils.map('n', '<C-s>', require('lspsaga.signaturehelp').signature_help)
  -- -- Rename
  utils.map('n', 'gr', require('lspsaga.rename').rename)
  -- -- preview definition
  utils.map('n', 'gp', require 'lspsaga.provider'.preview_definition)
  -- -- navegate between errors
  utils.map('n', '<leader>dh', require 'lspsaga.diagnostic'.show_cursor_diagnostics)
  utils.map('n', '<leader>dl', require 'lspsaga.diagnostic'.show_line_diagnostics)
  utils.map('n', '<leader>dk', function() require 'lspsaga.diagnostic'.navigate("prev") end)
  utils.map('n', '<leader>dj', function() require 'lspsaga.diagnostic'.navigate("next") end )
end

return M
