local utils = require "utils"
local M = {}

function M.setup()
  local saga = require "lspsaga"
  saga.init_lsp_saga {
    symbol_in_winbar = {
      in_custom = true,
    },
    code_action_lightbulb = { sign = false },
    finder_action_keys = {
      vsplit = "v",
      split = "s",
    },
  }

  -- lspsaga
  utils.map("n", ",f", ":Lspsaga lsp_finder<CR>")

  -- Code action
  utils.map({ "n", "v" }, "<C-.>", ":Lspsaga code_action<CR>")

  -- Rename
  utils.map("n", "gr", ":Lspsaga rename<CR>")

  -- Peek definition
  utils.map("n", "gp", ":Lspsaga peek_definition<CR>")

  -- navegate between errors
  utils.map("n", "ñdk", function()
    require("lspsaga.diagnostic").goto_prev { severity = vim.diagnostic.severity.ERROR }
  end, { desc = "Prev Error" })
  utils.map("n", "ñdj", function()
    require("lspsaga.diagnostic").goto_next { severity = vim.diagnostic.severity.ERROR }
  end, { desc = "Next Error" })

  -- Outline
  utils.map("n", "<leader>o", "<cmd>LSoutlineToggle<CR>")

  -- Show line diagnostics
  utils.map("n", "ñdl", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

  -- Show cursor diagnostic
  utils.map("n", "ñds", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })

  -- Hover Doc
  utils.map("n", "gh", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
end

return M
