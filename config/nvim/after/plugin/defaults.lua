local set = vim.opt

--  Basic config
set.scrolloff = 999
set.mouse = "a"
set.clipboard = "unnamedplus"
set.splitright = true
set.splitbelow = true
set.icm = "nosplit"
set.virtualedit = "onemore"
set.undofile = false
set.undolevels = 1000
set.backspace = { "indent", "eol", "start", "nostop" } -- Better backspace.
set.inccommand = "split"

-- speed up
set.lazyredraw = false

-- Tricks
set.hidden = false

-- Format options
set.encoding = "utf-8"
set.fileformat = "unix"
set.formatoptions = "tcqrn1"
set.errorformat:append "%f|%l col %c|%m"
set.wildignore:append { "*.pyc", "*.pyo", "*/__pycache__/*", "*.beam", "*.swp,~*", "*.zip", "*.tar" }
-- Better search
set.path:remove "/usr/include"
set.path:append "**"

-- Spaces & Tabsset
set.expandtab = true
set.autoindent = true
set.cindent = true
-- set.shiftround = true
set.shiftwidth = 2
set.softtabstop = 2
set.tabstop = 2
-- set.ts=2
-- set.autoindent = true
-- set.smartindent = true
-- set.smarttab = true
-- set.copyindent = true
-- set.joinspaces = false

-- Text line
set.wrap = true
set.linebreak = true
set.textwidth = 80

-- UI Config
set.shortmess = set.shortmess - "S"
-- set.completeopt = "menuone,noselect"
set.completeopt = "menuone,noselect,menu"
set.pumheight = 12
set.showmode = true
set.title = true
set.number = true
set.relativenumber = true
set.showcmd = true
set.cursorline = true
set.cursorcolumn = true
set.wildmenu = true
set.wildmode = "longest:full,full"
set.showmatch = false
set.errorbells = true
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
set.cmdheight = 2

-- TermGui
if vim.fn.has "termguicolors" == 1 then
  -- vim.go.t_8f = "[[38;2;%lu;%lu;%lum"
  -- vim.go.t_8b = "[[48;2;%lu;%lu;%lum"
  -- vim.go.t_8f = "\\<Esc>[38;2;%lu;%lu;%lum"
  -- vim.go.t_8b = "\\<Esc>[48;2;%lu;%lu;%lum"
  set.termguicolors = true
end

-- Search
set.hlsearch = true
set.incsearch = true
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

-- Backup
set.swapfile = false
set.backup = false
set.writebackup = false
set.backupcopy = "yes"
