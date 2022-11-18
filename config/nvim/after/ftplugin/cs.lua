-- local csharp_ls = {
--   name = "csharp_ls",
--   cmd = { "csharp-ls" },
--   -- root_dir = vim.fs.dirname(vim.fs.find({'Prueba.sln', 'Prueba.csproj'}, { upward = true })[1]),
--   root_dir = require 'lspconfig'.util.root_pattern('*.csproj')(vim.loop.cwd()),
--   init_options = { AutomaticWorkspaceInit = true },
--   handlers = {
--     ["textDocument/definition"] = require('csharpls_extended').handler,
--   }
-- }

local omnisharp = {
  handlers = {
    ['textDocument/definition'] = require('omnisharp_extended').handler
  },
  -- cmd = { "dotnet", "/usr/lib/omnisharp-roslyn/OmniSharp.dll" },
  cmd = { '/usr/bin/omnisharp', '--languageserver', '--hostPID', tostring(pid) },
  enable_editorconfig_support = true,
  enable_ms_build_load_projects_on_demand = false,
  enable_roslyn_analyzers = true,
  organize_imports_on_format = true,
  enable_import_completion = true,
  sdk_include_prereleases = true,
  analyze_open_documents_only = false,
  root_dir = require 'lspconfig'.util.root_pattern('*.csproj')(vim.loop.cwd()),
}
require("config.lsp").setup(omnisharp)
