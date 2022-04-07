local utils = require "utils"
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 3
vim.g.netrw_winsize = 15
-- Toggle Netrw
function ToggleNetrw()
  if vim.g.NetrwIsOpen then
    local i = vim.fn.bufnr "$"
    while i >= 1 do
      if vim.fn.getbufvar(i, "&filetype") == "netrw" then
        vim.cmd("bwipeout" .. i)
        break
      end
      i = i - 1
    end
    vim.g.NetrwIsOpen = false
  else
    vim.g.NetrwIsOpen = true
    vim.cmd [[silent Lexplore]]
  end
end
local opts = { noremap = true, silent = true }
-- utils.map('n', 'ø', ':lua ToggleNetrw()<CR>')           -- open explorer in vertical split
utils.map("n", "ññ", ":lua ToggleNetrw()<CR>", opts) -- open explorer in vertical split
