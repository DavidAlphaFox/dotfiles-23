local utils = require 'utils'
local M = {}

function M.setup()
  local saga = require 'lspsaga'
  saga.init_lsp_saga({
    finder_action_keys = {
      open = 'o', vsplit = 'v', split = 's', quit = 'q', scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
    },
    rename_action_quit = 'q',
  })

  -- lspsaga
  utils.map('n', '<A-f>', require("lspsaga.finder").lsp_finder)
  utils.map('n', '<C-.>', require('lspsaga.codeaction').code_action)
  -- vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>
  -- show hover doc
  utils.map('n', '<C-h>', require("lspsaga.hover").render_hover_doc)
  local action = require("lspsaga.action")
  utils.map('n', 'C-f>', function() action.smart_scroll_with_saga(1) end)
  utils.map('n', '<C-b>', function() action.smart_scroll_with_saga(-1) end)
  utils.map('n', '<C-s>', require("lspsaga.signaturehelp").signature_help)
  -- -- Rename
  utils.map('n', 'gr', require("lspsaga.rename").lsp_rename)
  -- -- preview definition
  utils.map('n', 'gp', require("lspsaga.definition").preview_definition)
  -- -- navegate between errors
  utils.map('n', '<leader>dk', function() require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR }) end)
  utils.map('n', '<leader>dj', function() require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR }) end)
end

return M
