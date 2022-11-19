require "import"
local diagnostics_active = true
--
-- local function toggle_diagnostics()
--   diagnostics_active = not diagnostics_active
--   if diagnostics_active then
--     vim.diagnostic.show()
--   else
--     vim.diagnostic.hide()
--   end
-- end

-- Use an on_attach function to only map the following keys
local on_attach = function(client, bufnr)
  local caps = client.server_capabilities

  -- Enable completion triggered by <C-X><C-O>
  -- See `:help omnifunc` and `:help ins-completion` for more information.
  if caps.completionProvider then
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
  end

  -- Use LSP as the handler for formatexpr.
  -- See `:help formatexpr` for more information.
  if caps.documentFormattingProvider then
    vim.bo[bufnr].formatexpr = "v:lua.vim.lsp.formatexpr()"
  end

  -- Configure key mappings
  require("config.lsp.keymaps").setup(client, bufnr)

  -- Configure highlighting
  require("config.lsp.highlighter").setup(client, bufnr)

  -- Configure formatting
  require("config.lsp.null-ls.formatters").setup(client, bufnr)

  -- tagfunc
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
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

local M = {}

local opts = {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
}
if vim.g.cmp_enable then
  import("cmp_nvim_lsp", function(cmp_nvim_lsp)
    opts.capabilities = cmp_nvim_lsp.default_capabilities(capabilities) -- for nvim-cmp
  end)
else
  opts.capabilities = capabilities
end

-- Setup LSP handlers
require("config.lsp.handlers").setup()

function M.setup(server)
  -- null-ls
  require("config.lsp.null-ls").setup(opts)
  local config = vim.tbl_deep_extend("force", opts, server or {})
  if server.name == "sumneko_lua" then
    config.before_init = require("neodev.lsp").before_init
  end
  if vim.cmp_enable == false then
    import("coq", function(coq)
      config = coq.lsp_ensure_capabilities(config)
    end)
  end
  vim.lsp.start(config) -- vim.api.nvim_create_autocmd('FileType', {
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
