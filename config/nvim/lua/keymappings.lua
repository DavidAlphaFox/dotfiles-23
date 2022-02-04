local utils = require('utils')
local opts = { noremap = true, silent = false }

utils.map('n', 'Y', 'yg$')
utils.map('n', 'k', 'gk')
utils.map('n', 'j', 'gj')
utils.map('n', 'ñ', ':', opts)
utils.map('n', 'ñs', '/', opts)
utils.map('n', '<leader>s', '?', opts)
utils.map('n', 'ñr', ':%s/', opts)
utils.map('n', '<leader>r', ':s/', opts)

-- Search and replace
utils.map('n', 'ñrw', [[:%s/\<<C-r><C-w>\>/]], opts) -- replace word
utils.map('n', '<Leader>rw', [[/\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgn]]) -- replace world and nexts word with .
utils.map('n', '<Leader>rp', [[?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN]]) -- replace world and prev word with .

-- sudo
vim.cmd [[cmap w!! w !sudo tee > /dev/null %]]

-- Tab mappings
utils.map('n',
          '<leader>t',
          [[:execute 'set showtabline=' . (&showtabline ==# 0 ? 2 : 0)<CR>]])
utils.map('n', 'tl', 'gt')
utils.map('n', 'th', 'gT')
utils.map('n', 'tn', ':tabnew<CR>')
utils.map('n', 'to', ':tabonly<CR>')
utils.map('n', 'td', ':tabclose<CR>')
utils.map('n', 'tm', ':tabmove<CR>')
for i = 9,1,-1
do
   local kmap = string.format("<leader>%d", i)
   local command = string.format("%dgt", i)
   utils.map('n', kmap, command)
end
utils.map('n', 'ñd', ':bd<CR>')
utils.map('n', 'tk', ':bnext<CR>')
utils.map('n', 'tj', ':bprev<CR>')

-- Terminal open
-- utils.map('n', '<leader>ñ', ':split<CR>:ter<CR>:resize 8<CR>')

-- Move between splits
-- Better window navigation
utils.map("n", "<Leader>k", ":wincmd k<CR>")
utils.map("n", "<Leader>l", ":wincmd l<CR>")
utils.map("n", "<Leader>j", ":wincmd j<CR>")
utils.map("n", "<Leader>h", ":wincmd h<CR>")

-- Resize pane
utils.map('n', '<leader>+', ':vertical resize +5<CR>')
utils.map('n', '<leader>-', ':vertical resize -5<CR>')
utils.map('n', '<leader><leader>+', ':resize +5<CR>')
utils.map('n', '<leader><leader>-', ':resize -5<CR>')

utils.map('n', ',h', ':vertical resize +5<CR>')
utils.map('n', ',l', ':vertical resize -5<CR>')
utils.map('n', ',j', ':resize +5<CR>')
utils.map('n', ',k', ':resize -5<CR>')

--Move line to up or down
utils.map("n", "<A-j>", ":m .+1<CR>==", opts)
utils.map("n", "<A-k>", ":m .-2<CR>==", opts)
utils.map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
utils.map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
utils.map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
utils.map("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

--Esc in terminal mode
utils.map('t', '<Esc>', '<C-\\><C-n>')
utils.map('t', '<M-[>', '<Esc>')
utils.map('t', '<C-v><Esc>', '<Esc>')

--Delete search result
utils.map('n', '<leader>c', ':let @/=""<cr>')
utils.map('n', 'n', 'nzzzv', opts)
utils.map('n', 'N', 'Nzzzv', opts)
-- utils.map('n', '<bs>', '<c-^>`”zz')
utils.map('n', '<bs>', ":<c-u>exe v:count ? v:count . 'b' : 'b' . (bufloaded(0) ? '#' : 'n')<cr>")

utils.map('n', '<leader>a', '=ip', opts)
utils.map('n', '<leader>i', '=G', opts)
utils.map('n', '<Tab>', '>>', opts)
utils.map('n', '<S-Tab>', '<<', opts)
utils.map('v', '<Tab>', '>', opts)
utils.map('v', '<S-Tab>', '<', opts)

-- Motions
utils.map('n', 'ñj', '%')

-- PLUGINS
-- harpoon
utils.map('n', 'ñm', ':lua require("harpoon.mark").add_file()<CR>')
utils.map('n', 'ñ ', ':lua require("harpoon.ui").toggle_quick_menu()<CR>')
utils.map('n', 'ñ<Tab>', ':lua require("harpoon.ui").nav_next()<CR>')
utils.map('n', 'ñ <Tab>', ':lua require("harpoon.ui").nav_prev()<CR>')
for i = 9,1,-1
do
   local kmap = string.format("ñ%d", i)
   local command = string.format(':lua require("harpoon.ui").nav_file(%d)<CR>', i)
   utils.map('n', kmap, command)
end
utils.map('n', 'ñ.', [[:lua require("harpoon.term").sendCommand(10, require"code_runner".get_filetype_command() .. "\n")<CR>]])
utils.map('n', 'ñt', ':lua require("harpoon.term").gotoTerminal(10)<CR>')
utils.map('n', '<leader>e', ':RunCode<CR>', opts)
utils.map("n", "<Leader>nc", ":lua require('neogen').generate({ type = 'class' })<CR>")
utils.map("n", "<Leader>nf", ":lua require('neogen').generate({ type = 'func' })<CR>")
utils.map("n", "<Leader>ng", ":lua require('neogen').generate({ type = 'file' })<CR>")
utils.map("n", "<Leader>nt", ":lua require('neogen').generate({ type = 'type' })<CR>")

