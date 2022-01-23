local package = {
  'lsp_config.diagnostics',
  'lsp_config.saga'
}
for _, pkg in ipairs(package) do
  require(pkg)
end
