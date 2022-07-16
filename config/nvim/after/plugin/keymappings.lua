-- | | _____ _   _ _ __ ___   __ _ _ __
-- | |/ / _ \ | | | '_ ` _ \ / _` | '_ \
-- |   <  __/ |_| | | | | | | (_| | |_) |
-- |_|\_\___|\__, |_| |_| |_|\__,_| .__/
--           |___/                |_|

local utils = require "utils"
local opts = { noremap = true, silent = false }

utils.map("n", "Y", "yg$")
-- utils.map("n", "k", "gk")
-- utils.map("n", "j", "gj")

-- Search in the current buffer
utils.map("n", "ñs", "/", opts)
utils.map("n", "<leader>s", "?", opts)
-- Search and  replace in the current buffer
utils.map("n", "ñr", ":%s/", opts)
utils.map({ "n", "v" }, "<leader>r", ":s/", opts)
-- Set ; to end line
utils.map("n", ";", "<esc>mzA;<esc>`z")

-- No yank
utils.map("n", "x", '"_x')
utils.map({ "n", "x" }, "c", '"_c')
utils.map("n", "C", '"_C')
utils.map("v", "p", '"_dP', opts)
-- Better indent
utils.map("v", "<", "<gv", opts)
utils.map("v", ">", ">gv", opts)

-- Toggle spell checker
utils.map("n", "<F2>", ":setlocal spell! spelllang=es<CR>")
utils.map("n", "<F3>", ":setlocal spell! spelllang=en_us<CR>")

-- Search and replace word
utils.map("n", "ñcw", [[:%s/\<<C-r><C-w>\>/]], opts) -- replace word
utils.map("n", "cn", [[/\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgn]]) -- replace world and nexts word with .
utils.map("n", "cN", [[?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN]]) -- replace world and prev word with .

-- sudo
vim.cmd [[cmap w!! w !sudo tee > /dev/null %]]

-- Tab mappings
utils.map("n", "<leader>t", [[:execute 'set showtabline=' . (&showtabline ==# 0 ? 2 : 0)<CR>]])
utils.map("n", "ñtn", ":tabnew<CR>")
utils.map("n", "ñto", ":tabonly<CR>")
utils.map("n", "ñtd", ":tabclose<CR>")
utils.map("n", "ñti", ":tabmove +1<CR>")
utils.map("n", "ñtm", ":tabmove -1<CR>")
for i = 9, 1, -1 do
  local kmap = string.format("<leader>%d", i)
  local command = string.format("%dgt", i)
  utils.map("n", kmap, command)
  utils.map("n", string.format("ñt%d", i), string.format(":tabmove %d<CR>", i == 1 and 0 or i))
end
utils.map("n", "ñd", ":bd<CR>")
utils.map("n", "ñw", ":bnext<CR>")
utils.map("n", "ñq", ":bprev<CR>")

-- Move between splits
-- Better window navigation
utils.map("n", "<Leader>k", ":wincmd k<CR>")
utils.map("n", "<Leader>l", ":wincmd l<CR>")
utils.map("n", "<Leader>j", ":wincmd j<CR>")
utils.map("n", "<Leader>h", ":wincmd h<CR>")

-- Resize pane
utils.map("n", "<A-Left>", ":vertical resize +5<CR>")
utils.map("n", "<A-Right>", ":vertical resize -5<CR>")
utils.map("n", "<A-Down>", ":resize +5<CR>")
utils.map("n", "<A-Up>", ":resize -5<CR>")

--Move line to up or down
utils.map("n", "J", ":m .+1<CR>==", opts)
utils.map("n", "K", ":m .-2<CR>==", opts)
-- utils.map("i", "J", "<Esc>:m .+1<CR>==gi", opts)
-- utils.map("i", "K", "<Esc>:m .-2<CR>==gi", opts)
utils.map("v", "J", ":m '>+1<CR>gv=gv", opts)
utils.map("v", "K", ":m '<-2<CR>gv=gv", opts)

--Esc in terminal mode
utils.map("t", "<Esc>", "<C-\\><C-n>")
utils.map("t", "<M-[>", "<Esc>")
utils.map("t", "<C-v><Esc>", "<Esc>")

--Delete search result
utils.map("n", "<leader>c", ':let @/=""<cr>')
-- utils.map('n', '<bs>', '<c-^>`”zz')
utils.map("n", "<bs>", ":<c-u>exe v:count ? v:count . 'b' : 'b' . (bufloaded(0) ? '#' : 'n')<cr>")

-- Motions
utils.map("n", "ç", "%")

-- PLUGINS
-- harpoon
utils.map("n", "ñm", require("harpoon.mark").add_file)
utils.map("n", "ñg", require("harpoon.ui").toggle_quick_menu)
utils.map("n", "ñ<Tab>", require("harpoon.ui").nav_next)
utils.map("n", "ñ <Tab>", require("harpoon.ui").nav_prev)

utils.map("n", "ñ.", function()
  require("harpoon.term").sendCommand(10, require("code_runner.commands").get_filetype_command() .. "\n")
end)

utils.map("n", "ñ ", function()
  require("harpoon.term").gotoTerminal(10)
end)

utils.map("n", "<leader>e", require("code_runner.commands").run_code, opts)
utils.map("n", "<Leader>fo", ":TodoTelescope<CR>")

local neogen = {
  c = "class",
  f = "func",
  i = "file",
  t = "type",
}

for k, v in pairs(neogen) do
  utils.map("n", string.format("<Leader>n%s", k), function()
    require("neogen").generate { type = v }
  end)
end
local pantran = require("pantran")
utils.map("n", "<leader>tr", pantran.motion_translate)
utils.map("n", "<leader>trr", function() return pantran.motion_translate() .. "_" end)
utils.map("x", "<leader>tr", pantran.motion_translate)
