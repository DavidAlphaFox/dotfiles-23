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
  local caps = client.server_capabilities

  if caps.completionProvider then
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
  end

  if caps.documentFormattingProvider then
    vim.bo[bufnr].formatexpr = "v:lua.vim.lsp.formatexpr()"
  end

  -- Lsp keymaps
  local opts = { buffer = bufnr, silent = true }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", { desc = "Goto Declaration"}, opts))
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", { desc = "Goto Definition"}, opts))
  vim.keymap.set("n", "gdt", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>", vim.tbl_extend("force", { desc = "Goto Definition in new Tab"}, opts))
  vim.keymap.set("n", "gh", vim.lsp.buf.hover, vim.tbl_extend("force", { desc = "LSP Hover"}, opts))
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", { desc = "Goto Implementation"}, opts))
  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, vim.tbl_extend("force", { desc = "LSP Add Folder"}, opts))
  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, vim.tbl_extend("force", { desc = "LSP Type Definition"}, opts))
  vim.keymap.set("n", "<leader>dt", toggle_diagnostics, vim.tbl_extend("force", { desc = "Toggle Diagnostic"}, opts))

  require("config.lsp.highlighter").setup(client, bufnr)
  require("config.lsp.null-ls.formatters").setup(client, bufnr)

  if caps.definitionProvider then
    vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
  end
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
  if server.name == "sumneko_lua" then
    require("neodev").setup({})
  end
  config = coq.lsp_ensure_capabilities(config)
  vim.lsp.start(config)  -- vim.api.nvim_create_autocmd('FileType', {
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
