local package = {
  'config.lsp.supports',
  'config.lsp.diagnostics',
  'config.lsp.diagnostics-colors',
  'config.lsp.saga',
  'config.lsp.completion'
}
for _, pkg in ipairs(package) do
  require(pkg)
end
