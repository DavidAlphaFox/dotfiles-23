vim.g.coq_settings = {
  auto_start = 'shut-up',
  keymap = {
    jump_to_mark = "ñn"
  },
  clients = {
    tabnine = {
      enabled = true
    }
  },
  display = {
    icons = {
      mode = "short"
    }
  }
}
local package = {
  'lsp_config.supports',
  'lsp_config.diagnostics',
  'lsp_config.saga'
}
for _, pkg in ipairs(package) do
  require(pkg)
end

require("lsp-colors").setup({
  Error = "#f34f4d",
  Warning = "#ffda45",
  Information = "#8accfe",
  Hint = "#7ad88e"
})
