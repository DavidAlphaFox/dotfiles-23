local coq = require "coq"


local diagnostics_active = true

local function toggle_diagnostics()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.show()
  else
    vim.diagnostic.hide()
  end
end

-- Use an on_attach function to only map the following keys
local on_attach = function(client, bufnr)
  -- Lsp keymaps
  local opts = { buffer = bufnr, silent = true }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "<leader>bh", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "<leader>dt", toggle_diagnostics, opts)
  require("config.lsp.highlighter").setup(client, bufnr)

  require("config.lsp.null-ls.formatters").setup(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits'
  }
}

local defaults  = {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

-- Setup LSP handlers
require("config.lsp.handlers").setup()

local M = {}

function M.setup(server)
  -- null-ls
  require("config.lsp.null-ls").setup(defaults)
  local config = vim.tbl_deep_extend("force", defaults, server or {})
  require("utils").info(config.name, "LSP")
  if server.name == "sumneko_lua" then
    require("lua-dev").setup({})
  end
  config = coq.lsp_ensure_capabilities(config)
  -- vim.api.nvim_create_autocmd('FileType', {
  --   pattern = filetype,
  --   callback = function()
  vim.lsp.start(config)
  --   end,
  -- })
-- end
end

function M.remove_unused_imports()
  vim.diagnostic.setqflist { severity = vim.diagnostic.severity.WARN }
  vim.cmd "packadd cfilter"
  vim.cmd "Cfilter /main/"
  vim.cmd "Cfilter /The import/"
  vim.cmd "cdo normal dd"
  vim.cmd "cclose"
  vim.cmd "wa"
end

return M
