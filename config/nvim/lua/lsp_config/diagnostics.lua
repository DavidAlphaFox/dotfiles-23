local utils = require 'utils'

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      prefix = "",
      spacing = 4,
    },
    signs = true,
    update_in_insert = false,
  }
)

--[[ vim.fn.sign_define('LspDiagnosticsSignError', { text = "", texthl = "LspDiagnosticsDefaultError" })
vim.fn.sign_define('LspDiagnosticsSignWarning', { text = "", texthl = "LspDiagnosticsDefaultWarning" })
vim.fn.sign_define('LspDiagnosticsSignInformation', { text = "", texthl = "LspDiagnosticsDefaultInformation" })
vim.fn.sign_define('LspDiagnosticsSignHint', { text = "", texthl = "LspDiagnosticsDefaultHint" }) ]]

vim.cmd [[ autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost * silent! TroubleRefresh ]]

require("trouble").setup {
    position = "bottom", -- position of the list can be: bottom, top, left, right
    signs = {
        -- icons / text used for a diagnostic
        error = " ",
        warning = " ",
        hint = "",
        information = " ",
        other = " "
    },
}


utils.map("n", "<leader>dx", "<cmd>Trouble<cr>",
  {silent = true, noremap = true}
)
utils.map("n", "<leader>dw", "<cmd>Trouble lsp_workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
utils.map("n", "<leader>dd", "<cmd>Trouble lsp_document_diagnostics<cr>",
  {silent = true, noremap = true}
)
utils.map("n", "<leader>dl", "<cmd>Trouble loclist<cr>",
  {silent = true, noremap = true}
)
utils.map("n", "<leader>dq", "<cmd>Trouble quickfix<cr>",
  {silent = true, noremap = true}
)
utils.map("n", "gR", "<cmd>Trouble lsp_references<cr>",
  {silent = true, noremap = true}
)
