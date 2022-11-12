local set = vim.opt

--  Basic config
vim.opt.showtabline = 0
set.scrolloff = 999 -- Lines of context
set.sidescrolloff = 999
set.mouse = "a"
-- clipboard
set.clipboard:append("unnamedplus")
set.splitright = true
set.splitbelow = true
set.icm = "nosplit"
set.virtualedit = "block"
-- set.virtualedit = "onemore"
set.undofile = false
set.undolevels = 1000
set.backspace = { "indent", "eol", "start", "nostop" } -- Better backspace.
set.inccommand = "split"
set.matchtime = 2
set.updatetime = 250
set.timeoutlen = 500

-- speed up
set.lazyredraw = false

-- Tricks
set.hidden = false

-- Format options
set.encoding = "utf-8"
set.fileformat = "unix"
set.formatoptions = "tcqrn1"
set.errorformat:append "%f|%l col %c|%m"
set.wildignore:append { ".git/**", "*.pyc", "*.pyc", "*.pyo", "*/__pycache__/*", "*.beam", "*.swp,~*", "*.zip", "*.tar",
  "*.DS_Store,**/", "node_modules/**", "**/bower_modules/**", "**/node_modules/**" }

-- Better search
set.path:remove "/usr/include"
set.path:append "**"

-- Spaces & Tabsset
set.expandtab = true
set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = -1
set.smarttab = true

-- Text line
set.wrap = true
set.whichwrap:append "<>[]hl"
set.linebreak = true
set.textwidth = 80

-- UI Config
vim.o.termguicolors = true
set.shortmess = set.shortmess - "S"
-- set.completeopt = "menuone,noselect"
-- set.completeopt = "menuone,noselect,menu"
set.pumheight = 12
set.showmode = false
set.title = true
set.number = true
set.relativenumber = true
set.showcmd = true
set.cursorline = true
set.cursorcolumn = true
set.wildmenu = true
set.wildmode = "longest:full,full"
set.showmatch = true
set.errorbells = true
set.list = false
-- set.signcolumn = "yes:1"
set.signcolumn = "auto:1"
set.listchars = {
  eol = "↲",
  space = "␣",
  tab = "▸ ",
  trail = "·",
  precedes = "←",
  extends = "→",
  nbsp = "␣",
}
set.laststatus = 3
set.cmdheight = 0

-- Search
set.hlsearch = true
set.incsearch = true
set.ignorecase = true
set.smartcase = true
set.grepformat = "%f:%l:%c:%m"
set.grepprg = "rg --vimgrep --no-heading --smart-case"

-- Folding
vim.o.fillchars = [[eob: ,fold: ,foldopen:▼,foldsep: ,foldclose:⏵]]
vim.wo.foldcolumn = 'auto:1'
-- set.foldnestmax = 0
vim.wo.foldlevel = 99
set.foldlevelstart = -1
vim.wo.foldenable = true
-- vim.o.fillchars = {
--   eob = "",
--   fold = "",
--   foldopen = "",
--   foldsep = "",
--   foldclose = ""
-- }

-- Backup
set.swapfile = false
set.backup = false
set.writebackup = false
set.backupcopy = "yes"
