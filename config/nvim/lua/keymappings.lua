local utils = require('utils')
local opts = { noremap = true, silent = false }

utils.map('n', '<leader>y', 'y$')
utils.map('n', 'ñ', ':', opts)
utils.map('n', '<leader>s', '/', opts)
utils.map('n', '<leader><leader>s', '?', opts)
utils.map('n', '<A-r>', ':s/', opts)
utils.map('n', '¶', ':%s/', opts)
utils.map('n', '<leader>rw', [[:%s/\<<C-r><C-w>\>/]], opts)

--Python Docstring
vim.cmd [[autocmd FileType python nnoremap <buffer> <leader>pd :Pydocstring<CR>]]

-- Tab mappings
utils.map('n',
          '<leader>t',
          [[:execute 'set showtabline=' . (&showtabline ==# 0 ? 2 : 0)<CR>]])
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

-- Terminal open
utils.map('n', '<leader>ñ', ':split<CR>:ter<CR>:resize 8<CR>')

-- Move between splits
utils.map('n', '<leader>m', '<C-w><C-w>')
utils.map('n', '<leader>h', '<C-w>h')
utils.map('n', '<leader>j', '<C-w>j')
utils.map('n', '<leader>k', '<C-w>k')
utils.map('n', '<leader>l', '<C-w>l')

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
utils.map('n', '<A-Down>', ':m .+1<CR>==')
utils.map('n', '<A-Up>', ':m .-2<CR>==')
utils.map('i', '<A-Down>', '<Esc>:m .+1<CR>==gi')
utils.map('i', '<A-Up>', '<Esc>:m .-2<CR>==gi')
utils.map('v', '<A-Down>', ":m '>+1<CR>gv=gv")
utils.map('v', '<A-Up>', ":m '<-2<CR>gv=gv")

utils.map('n', '<A-j>', ':m .+1<CR>==')
utils.map('n', '<A-k>', ':m .-2<CR>==')
utils.map('i', '<A-j>', '<Esc>:m .+1<CR>==gi')
utils.map('i', '<A-k>', '<Esc>:m .-2<CR>==gi')
utils.map('v', '<A-j>', ":m '>+1<CR>gv=gv")
utils.map('v', '<A-k>', ":m '<-2<CR>gv=gv")

--Esc in terminal mode
utils.map('t', '<Esc>', '<C-\\><C-n>')
utils.map('t', '<M-[>', '<Esc>')
utils.map('t', '<C-v><Esc>', '<Esc>')

--Delete search result
utils.map('n', '<leader>c', ':let @/=""<cr>')
