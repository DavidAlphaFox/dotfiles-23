-- omnisharp = {
--   name = "omnisharp"
--   cmd = { '/usr/bin/omnisharp', '--languageserver', '--hostPID', tostring(pid) },
--   root_dir = root_csharp,
--   handlers = {
--     ['textDocument/definition'] = require('omnisharp_extended').handler
--   }
-- },
csharp_ls = {
  name = "csharp_ls",
  cmd = { "csharp-ls" },
  -- root_dir = vim.fs.dirname(vim.fs.find({'Prueba.sln', 'Prueba.csproj'}, { upward = true })[1]),
  root_dir = require'lspconfig'.util.root_pattern('*.csproj')(vim.loop.cwd()),
  init_options = { AutomaticWorkspaceInit = true },
  handlers = {
    ["textDocument/definition"] = require('csharpls_extended').handler,
  }
}
require("config.lsp").setup(csharp_ls)
