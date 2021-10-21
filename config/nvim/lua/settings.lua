local set = vim.opt
-- Global
set.encoding = 'utf-8'
set.fillchars = vim.o.fillchars .. 'vert: '
set.scrolloff = 10
set.mouse = 'a'
set.smartindent = true
set.backupcopy = 'yes'
set.undolevels = 1000
set.shortmess = vim.o.shortmess .. 'c'
set.showmode = false
set.hidden = true
set.splitright = true
set.splitbelow = true
set.wrapscan = true
set.ttyfast = true
set.backup = false
set.writebackup = false
set.showcmd = true
set.showmatch = true
set.ignorecase = true
set.hlsearch = true
set.smartcase = true
set.errorbells = false
set.joinspaces = false
set.title = true
set.lazyredraw = true
set.completeopt = 'menu,menuone,noselect'
set.listchars = {eol = '↲', tab = '▸ ', trail = '·', precedes = '←', extends = '→', nbsp = '␣', space = '␣'}
-- Format options
set.textwidth = 79
set.expandtab = true
set.shiftwidth = 2
set.autoindent = true
set.smarttab = true
set.clipboard = 'unnamedplus'
set.grepformat = '%f:%l:%c:%m'
set.grepprg = 'rg --vimgrep --no-heading --smart-case'
set.wildignore = {'*.pyc', '*.pyo', '*/__pycache__/*', '*.beam', '*.swp,~*', '*.zip', '*.tar' }
set.errorformat:append('%f|%l col %c|%m')

-- From buffer
vim.o.fileformat = vim.bo.fileformat
vim.o.tabstop = vim.bo.tabstop
vim.o.spelllang = vim.bo.spelllang
vim.o.softtabstop = vim.bo.softtabstop
vim.o.swapfile = vim.bo.swapfile
vim.o.undofile = vim.bo.undofile
vim.o.number = vim.wo.number
-- vim.o.colorcolumn = vim.wo.colorcolumn
-- vim.o.foldmethod = vim.wo.foldmethod
-- vim.o.foldlevel = vim.wo.foldlevel
-- vim.o.foldnestmax = vim.wo.foldnestmax
vim.o.signcolumn = vim.wo.signcolumn
vim.o.list = vim.wo.list
vim.o.relativenumber = vim.wo.relativenumber
vim.o.foldenable = vim.wo.foldenable
vim.o.cursorline = vim.wo.cursorline
vim.o.formatoptions = 'tcqrn1'
vim.o.shiftround = true
vim.o.icm='nosplit'

-- Buffer
vim.bo.fileformat = 'unix'
vim.bo.tabstop = 2
vim.bo.spelllang = 'es'
vim.bo.softtabstop = 2
vim.bo.swapfile = false
vim.bo.undofile = false

-- Window
vim.wo.number = true
-- vim.wo.foldmethod = 'indent'
-- vim.wo.foldlevel = 1
-- vim.wo.foldnestmax = 10
vim.wo.signcolumn = 'yes'
vim.wo.list = false
vim.wo.relativenumber = true
vim.wo.foldenable = false
vim.wo.cursorline = true

vim.o.lazyredraw = true

function Goto_last_pos()
  local last_pos = vim.fn.line("'\"")
  if last_pos > 0 and last_pos <= vim.fn.line("$") then
    vim.api.nvim_win_set_cursor(0, {last_pos, 0})
  end
end

vim.cmd[[au BufReadPost * lua Goto_last_pos()
au Filetype python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
au Filetype lua setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
au TextYankPost * silent! lua vim.highlight.on_yank()
au BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100)
au BufEnter * :let @/=""
au BufWritePre * :%s/\s\+$//e
au BufEnter * silent! lcd %:p:h]]
