local coq = require "coq"


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

  if caps.completionProvider then
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
  end

  if caps.documentFormattingProvider then
    vim.bo[bufnr].formatexpr = "v:lua.vim.lsp.formatexpr()"
  end

  local utils = require "utils"

  -- Lsp keymaps
  local opts = { buffer = bufnr, silent = true }

  local maps = {
    {
      prefix = "g",
      maps = {
        { "D", vim.lsp.buf.declaration, "Goto Declaration", opts },
        { "d", vim.lsp.buf.definition, "Goto Definition", opts },
        { "dt", "<cmd>tab split | lua vim.lsp.buf.definition()<C}>", "Goto Definition in new Tab", opts },
        { "h", vim.lsp.buf.hover, "LSP Hover", opts },
        { "i", vim.lsp.buf.implementation, "Goto Implementation", opts }

      }
    },
    {
      prefix = "<leader>",
      maps = {
        { "D", vim.lsp.buf.type_definition, "LSP Type Definition", opts },
        { "aw", vim.lsp.buf.add_workspace_folder, "LSP Add Folder", opts },
        { "dt", require("lsp_lines").toggle, "Toggle Diagnostic", opts },
      }
    },
    {
      prefix = "ñ",
      maps = {
        { "dt", require("lsp_lines").toggle, "Toggle Diagnostic", opts },
      }
    }
  }
  utils.maps(maps)
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

local opts = {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

local M = {}

-- Setup LSP handlers
require("config.lsp.handlers").setup()

function M.setup(server)
  -- null-ls
  require("config.lsp.null-ls").setup(opts)
  local config = vim.tbl_deep_extend("force", opts, server or {})
  if server.name == "sumneko_lua" then
    config.before_init = require("neodev.lsp").before_init
  end
  config = coq.lsp_ensure_capabilities(config)
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
