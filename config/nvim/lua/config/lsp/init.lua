local lsp = require "lspconfig"
local coq = require "coq"

local M = {}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
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

  -- Configure highlighting
  require("config.lsp.highlighter").setup(client)

  -- Configure formatting
  require("config.lsp.null-ls.formatters").setup(client, bufnr)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    vim.keymap.set("n", "<leader>fj", vim.lsp.buf.formatting, opts)
  elseif client.resolved_capabilities.document_range_formatting then
    vim.keymap.set("n", "<leader>fk", vim.lsp.buf.range_formatting, opts)
  end
end

local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return {
    on_attach = on_attach,
    capabilities = capabilities,
  }
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
          globals = { "vim" },
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

local function omnisharp()
  local pid = vim.fn.getpid()
  return {
    cmd = { "/usr/bin/omnisharp", "--languageserver", "--hostPID", tostring(pid) },
    root_dir = lsp.util.root_pattern("*.csproj", "*.sln"),
  }
end

local server_config = {
  omnisharp = omnisharp(),
  sumneko_lua = sumneko_lua(),
  cssls = {
    cmd = { "vscode-css-languageserver", "--stdio" },
  },
}

local servers = {
  "sumneko_lua",
  "jedi_language_server",
  "ccls",
  "tsserver",
  "dockerls",
  "bashls",
  "sqls",
  "omnisharp",
  "cssls",
  "intelephense",
}

local opts = make_config()

-- Setup LSP handlers
require("config.lsp.handlers").setup()

function M.setup()
  for _, server in ipairs(servers) do
    local config = vim.tbl_deep_extend("force", opts, server_config[server] or {})

    if server == "sumneko_lua" then
      config = require("lua-dev").setup { lspconfig = config }
    end

    lsp[server].setup(coq.lsp_ensure_capabilities(config))

    local cfg = lsp[server]

    if not (cfg and cfg.cmd and vim.fn.executable(cfg.cmd[1]) == 1) then
      require("utils").warn(server .. " cmd not found: " .. vim.inspect(cfg.cmd), "Lsp client error")
    end
  end
end

-- Setup all lenguage server and null-ls
require("config.lsp.null-ls").setup(opts)

return M
