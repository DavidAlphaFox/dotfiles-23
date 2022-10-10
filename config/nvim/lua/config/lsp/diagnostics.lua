local utils = require "utils"

local M = {}

function M.setup()
  vim.cmd [[ autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost * silent! TroubleRefresh ]]

  require("trouble").setup {
    auto_close = true,
    signs = {
      -- icons / text used for a diagnostic
      error = "",
      warning = "",
      hint = "",
      information = "",
      other = "",
    },
  }

  -- utils.map("n", "<leader>dx", "<cmd>TroubleToggle<cr>")
  utils.map("n", "<leader>dw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Workspace Diagnostics" })
  utils.map("n", "<leader>dd", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Show Diagnostics" })
  -- utils.map("n", "<leader>dq", "<cmd>TroubleToggle quickfix<cr>")
  -- utils.map("n", "<leader>dl", "<cmd>TroubleToggle loclist<cr>")
  utils.map("n", "gR", "<cmd>TroubleToggle lsp_references<cr>")
end

return M
