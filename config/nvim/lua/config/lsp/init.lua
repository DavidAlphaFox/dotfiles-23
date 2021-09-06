require('config.lsp.supports')
local package = {
  'config.lsp.supports',
  'config.lsp.diagnostics',
  'config.lsp.diagnostics-colors',
  'config.lsp.saga',
  -- 'config.lsp.completion',
  -- 'config.lsp.snippets'
}
for _, pkg in ipairs(package) do
  require(pkg)
end
vim.g.coq_settings = {["clients.tabnine.enabled"] = true, ["display.icons.mode"] = "long", ["keymap.jump_to_mark"] = "đ"}
vim.cmd [[ autocmd VimEnter * COQnow --shut-up ]]
