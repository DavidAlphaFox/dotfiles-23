local set = vim.opt

--  Edition
set.scrolloff = 10
set.mouse = "a"
set.clipboard = "unnamedplus"
set.splitright = true
set.splitbelow = true
set.wrap = true
set.linebreak = true
set.wrapscan = true
set.ttyfast = true
set.lazyredraw = true
set.icm = "nosplit"

-- Format options
set.encoding = "utf-8"
set.fileformat = "unix"
set.formatoptions = "tcqrn1"
set.spelllang = "es"
set.completeopt = "menuone,noselect"
set.errorformat:append "%f|%l col %c|%m"
set.wildignore:append { "*.pyc", "*.pyo", "*/__pycache__/*", "*.beam", "*.swp,~*", "*.zip", "*.tar" }

set.undofile = false
set.undolevels = 1000

-- Spaces & Tabsset
set.expandtab = true
set.shiftround = true
set.shiftwidth = 2
set.softtabstop = 2
set.tabstop = 2
-- set.ts=2
-- set.autoindent = true
-- set.smartindent = true
-- set.smarttab = true
-- set.copyindent = true
-- set.joinspaces = false
set.textwidth = 79

-- UI Config
set.virtualedit = "onemore"
set.pumheight = 10
set.showmode = false
set.title = true
set.hidden = false
set.number = true
set.relativenumber = true
set.showcmd = true
set.cursorline = true
set.cursorcolumn = true
set.wildmenu = true
set.showmatch = true
set.errorbells = false
set.list = false
set.signcolumn = "yes"
set.listchars = {
  eol = "↲",
  space = "␣",
  tab = "▸ ",
  trail = "·",
  precedes = "←",
  extends = "→",
  nbsp = "␣",
}
set.laststatus = 2

-- TermGui
if vim.fn.has "termguicolors" == 1 then
  -- vim.go.t_8f = "[[38;2;%lu;%lu;%lum"
  -- vim.go.t_8b = "[[48;2;%lu;%lu;%lum"
  -- vim.go.t_8f = "\\<Esc>[38;2;%lu;%lu;%lum"
  -- vim.go.t_8b = "\\<Esc>[48;2;%lu;%lu;%lum"
  set.termguicolors = true
end

-- Searchset incsearch
set.hlsearch = true
set.ignorecase = true
set.smartcase = true
set.grepformat = "%f:%l:%c:%m"
set.grepprg = "rg --vimgrep --no-heading --smart-case"

-- Folding
set.foldenable = false
-- set.foldlevel = 1
-- set.foldlevelstart=10
-- set.foldnestmax = 10
-- set.foldnestmax=10
-- set.foldmethod = 'indent'

--Backup
set.swapfile = false
set.backup = false
set.writebackup = false
set.backupcopy = "yes"
