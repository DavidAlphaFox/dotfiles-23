-- -> Miramare <-
local cmd = vim.cmd

-- cmd 'colorscheme matrix'
-- cmd 'colorscheme darkmatrix'

vim.g.miramare_cursor = 'purple'
vim.g.miramare_enable_italic = 1
vim.g.miramare_enable_italic_string = 0
vim.g.miramare_disable_italic_comment = 1
vim.g.miramare_transparent_background = 1
cmd 'colorscheme miramare'

-- require("themer").load("dark_cpt")
-- require("themer").load("miramare")

-- vim.g.aqua_bold = 1
-- vim.g.aquarium_style="dark"
-- cmd 'colorscheme aquarium'
