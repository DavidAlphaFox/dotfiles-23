local utils = require 'utils'
local M = {}

function M.setup()
  local saga = require 'lspsaga'
  saga.init_lsp_saga({
    code_action_lightbulb = { sign = false },
    finder_action_keys = {
      open = 'o', vsplit = 'v', split = 's', quit = 'q', scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
    },
    rename_action_quit = 'q',
  })

  -- lspsaga
  utils.map('n', ',f', ':Lspsaga lsp_finder<CR>')
  utils.map('n', '<C-.>', ':Lspsaga code_action<CR>')
  -- vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>
  -- show hover doc
  utils.map('n', ',h', require("lspsaga.hover").render_hover_doc)
  -- -- Rename
  utils.map('n', 'gr', ':Lspsaga rename<CR>')
  -- -- preview definition
  utils.map('n', 'gp', ':Lspsaga preview_definition<CR>')
  -- -- navegate between errors
  utils.map('n', '<leader>dk', function() require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR }) end)
  utils.map('n', '<leader>dj', function() require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR }) end)
  utils.map("n","<leader>o", "<cmd>LSoutlineToggle<CR>")
end

return M
