-- -> Miramare <-
local cmd = vim.cmd

if vim.fn.has("termguicolors") == 1 then
  -- vim.go.t_8f = "[[38;2;%lu;%lu;%lum"
  -- vim.go.t_8b = "[[48;2;%lu;%lu;%lum"
  vim.go.t_8f = "\\<Esc>[38;2;%lu;%lu;%lum"
  vim.go.t_8b = "\\<Esc>[48;2;%lu;%lu;%lum"
  vim.go.termguicolors = true
end

-- cmd 'colorscheme matrix'
-- cmd 'colorscheme darkmatrix'

vim.g.miramare_cursor = 'purple'
vim.g.miramare_enable_italic = 1
vim.g.miramare_enable_italic_string = 0
vim.g.miramare_disable_italic_comment = 1
vim.g.miramare_transparent_background = 1
cmd 'colorscheme miramare'

-- vim.g.aqua_bold = 1
-- vim.g.aquarium_style="dark"
-- cmd 'colorscheme aquarium'
