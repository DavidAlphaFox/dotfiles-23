-- vim.g.do_filetype_lua = 1
-- vim.g.did_load_filetypes = 0

--
-- Disable builtin plugins
--
local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit",
  "tutor_mode_plugin",
  "remote_plugins",
  "shada_plugin",
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

--
-- Init Packer Plugins
--

vim.g.mapleader = " "
vim.g.colorscheme = "catppuccin"
-- vim.g.colorscheme = "monokai_pro"
-- vim.g.colorscheme = "everforest"
-- vim.g.colorscheme = "amora"
require "config"
require("plugins").setup()
require "debug"
vim.opt.showtabline = 0
