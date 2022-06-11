local lsp = require "lspconfig"
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
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <C-X><C-O>
  -- See `:help omnifunc` and `:help ins-completion` for more information.
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Use LSP as the handler for formatexpr.
  -- See `:help formatexpr` for more information.
  vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

  -- Mappings.
  local opts = { buffer = bufnr }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "<leader>bh", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "<leader>dt", toggle_diagnostics, opts)

  -- Configure highlighting
  require("config.lsp.highlighter").setup(client)

  require("config.lsp.null-ls.formatters").setup(client, bufnr)

  if client.server_capabilities.definitionProvider then
    vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
  end

  -- Set some keybinds conditional on server capabilities
  if client.server_capabilities.document_formatting then
    vim.keymap.set("n", "<leader>fj", vim.lsp.buf.formatting, opts)
  elseif client.server_capabilities.document_range_formatting then
    vim.keymap.set("n", "<leader>fk", vim.lsp.buf.range_formatting, opts)
  end
end

-- Especific config for lsp servers
local function sumneko_lua()
  local runtime_path = vim.split(package.path, ";")
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")
  return {
    cmd = { "lua-language-server" },
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- Setup your lua path
          path = runtime_path,
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim", "PLUGINS", "describe", "it", "before_each", "after_each", "packer_plugins" },
          disable = { "lowercase-global", "undefined-global", "unused-local", "unused-vararg", "trailing-space" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  }
end

local function root_csharp(path)
  -- Make sure an sln doesn't already exist before trying to use the nearest csproj file
  return lsp.util.root_pattern('*.sln')(path) or lsp.util.root_pattern('*.csproj')(path)
end

local server_config = {
  sumneko_lua = sumneko_lua(),
  -- omnisharp = {
  --   cmd = { '/usr/bin/omnisharp', '--languageserver', '--hostPID', tostring(pid) },
  --   root_dir = root_csharp,
  --   handlers = {
  --     ['textDocument/definition'] = require('omnisharp_extended').handler
  --   }
  -- },
  csharp_ls = {
    root_dir = root_csharp,
    handlers = {
      ["textDocument/definition"] = require('csharpls_extended').handler,
    }
  },
  cssls = {
    cmd = { "vscode-css-languageserver", "--stdio" },
  }
}

local servers = {
  "sumneko_lua",
  "jedi_language_server",
  "ccls",
  "tsserver",
  "dockerls",
  "bashls",
  "sqls",
  "csharp_ls",
  -- "omnisharp",
  "cssls",
  "intelephense",
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
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

-- Setup LSP handlers
require("config.lsp.handlers").setup()

local M = {}

function M.setup()
  -- Setup all lenguage server and null-ls
  require("config.lsp.null-ls").setup(opts)
  for _, server in ipairs(servers) do
    local config = vim.tbl_deep_extend("force", opts, server_config[server] or {})

    if server == "sumneko_lua" then
      config = require("lua-dev").setup { lspconfig = config }
    end
    config = coq.lsp_ensure_capabilities(config)
    lsp[server].setup(config)

    local cfg = lsp[server]
    if not (cfg and cfg.cmd and vim.fn.executable(cfg.cmd[1]) == 1) then
      require("utils").warn(server .. " cmd not found: " .. vim.inspect(cfg.cmd), "Lsp client error")
    end
  end
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
