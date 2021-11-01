local utils = require('utils')
local opts = { noremap = true, silent = false }

utils.map('n', 'k', 'gk')
utils.map('n', 'j', 'gj')
utils.map('n', 'ñ', ':', opts)
utils.map('n', 'ñf', '/', opts)
utils.map('n', '<leader><leader>f', '?', opts)
utils.map('n', '<leader>r', ':%s/', opts)
utils.map('n', '¶', ':s/', opts)
utils.map('n', '<leader>cw', [[:%s/\<<C-r><C-w>\>/]], opts)

--Python Docstring
vim.cmd [[autocmd FileType python noremap <buffer> <leader>pd :Pydocstring<CR>]]

-- Tab mappings
utils.map('n',
          '<leader>t',
          [[:execute 'set showtabline=' . (&showtabline ==# 0 ? 2 : 0)<CR>]])
utils.map('n', 'tl', ':tabnext<CR>')
utils.map('n', 'th', ':tabprev<CR>')
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
utils.map('n', '<leader>bd', ':bd<CR>')
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
utils.map('n', '<leader><Right>', ':vertical resize +5<CR>')
utils.map('n', '<leader><Left>', ':vertical resize -5<CR>')
utils.map('n', '<leader><Up>', ':resize +5<CR>')
utils.map('n', '<leader><Down>', ':resize -5<CR>')

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

utils.map('n', '<leader>a', '=ip', opts)
utils.map('n', '<leader>i', '=G', opts)
utils.map('n', '<Tab>', '>>', opts)
utils.map('n', '<S-Tab>', '<<', opts)
utils.map('v', '<Tab>', '>', opts)
utils.map('v', '<S-Tab>', '<', opts)

-- Plugins

-- harpoon
utils.map('n', '<leader>m', ':lua require("harpoon.mark").add_file()<CR>')
utils.map('n', '<leader>n', ':lua require("harpoon.ui").toggle_quick_menu()<CR>')
for i = 9,1,-1
do
   local kmap = string.format("<leader>m%d", i)
   local command = string.format(':lua require("harpoon.ui").nav_file(%d)<CR>', i)
   utils.map('n', kmap, command)
end
utils.map('n', 'ñe', [[:lua require("harpoon.term").sendCommand(1, require"code_runner".get_filetype_command() .. "\n")<CR>]])
utils.map('n', '<leader>s', ':lua require("harpoon.term").gotoTerminal(1)<CR>')
utils.map('n', '<leader>e', ':RunCode<CR>', opts)
