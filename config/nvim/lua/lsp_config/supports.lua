local lspc = require 'lspconfig'
local coq = require 'coq'

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  require'lsp_signature'.on_attach(client)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>bh', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  -- buf_set_keymap('n', '<A-Left>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  -- buf_set_keymap('n', '<A-Right>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<leader>lf",
      "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<leader>lf",
      "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=#f9adad guifg=#111416
      hi LspReferenceText cterm=bold ctermbg=red guibg=#f9adad guifg=#111416
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#f9adad guifg=#111416
      augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]], false)
  end
end

local function make_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.codeAction = {
    dynamicRegistration = true,
    codeActionLiteralSupport = {
        codeActionKind = {
            valueSet = (function()
                local res = vim.tbl_values(vim.lsp.protocol.CodeActionKind)
                table.sort(res)
                return res
            end)()
        }
      }
    }
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {"documentation", "detail", "additionalTextEdits"}
    }
    return capabilities
end

local flake8 = {
  lintCommand = "flake8 ${INPUT}",
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  lintIgnoreExitCode = true,
  formatCommand = "black --line-length 79 ${INPUT}",
  formatStdin = true
}
-- capabilities = capabilities,
local servers = {"pyright", "ccls", "tsserver", "dockerls", "bashls", "sqls"}
for _, server in ipairs(servers) do
  --[[ lspc[server].setup{
    on_attach = on_attach,
    capabilities = make_capabilities()
  } --]]
  lspc[server].setup(coq.lsp_ensure_capabilities(
    vim.tbl_deep_extend("force", {
      on_attach = on_attach,
      capabilities = make_capabilities(),
      flags = {debounce_text_changes = 150},
      -- init_options = config
      }, {})))
    local cfg = lspc[server]
    if not (cfg and cfg.cmd and vim.fn.executable(cfg.cmd[1]) == 1) then
        print(server .. ": cmd not found: " .. vim.inspect(cfg.cmd))
    end
end

lspc.efm.setup {
  init_options = {documentFormatting = true},
  --[[ root_dir = function()
    return vim.fn.getcwd()
  end, ]]
  settings = {
    rootMarkers = {".git/"},
    languages = {
      python = {flake8},
    }
  },
  filetypes = {
    "python",
  },
}

local sumneko_binary = "/usr/bin/lua-language-server"
local sumneko_root_path = "/usr/share/lua-language-server"
-- lua-dev.nvim
local luadev = require("lua-dev").setup(
  coq.lsp_ensure_capabilities(
    vim.tbl_deep_extend("force", {
      library = {vimruntime = true, types = true, plugins = true},
      lspconfig = {
          capabilities = make_capabilities(),
          on_attach = on_attach,
          cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
          settings = {
              Lua = {
                  runtime = {
                      -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                      version = 'LuaJIT',
                      -- Setup your lua path
                      path = vim.split(package.path, ';')
                  },
                  diagnostics = {
                      -- Get the language server to recognize the `vim` global
                      globals = {'vim'}
                  },
                  workspace = {
                      -- Make the server aware of Neovim runtime files
                      library = {
                          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
                      }
                  }
              }
          }
      }
}, {})))
lspc.sumneko_lua.setup(luadev)
