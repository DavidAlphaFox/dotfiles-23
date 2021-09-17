require('lsp_config.supports')
local package = {
  'lsp_config.supports',
  'lsp_config.diagnostics',
  'lsp_config.diagnostics-colors',
  'lsp_config.saga',
  -- 'lsp_config.completion',
}
for _, pkg in ipairs(package) do
  require(pkg)
end
vim.g.coq_settings = {["clients.tabnine.enabled"] = true, ["display.icons.mode"] = "long", ["keymap.jump_to_mark"] = "đ"}
vim.cmd [[ autocmd VimEnter * COQnow --shut-up ]]
