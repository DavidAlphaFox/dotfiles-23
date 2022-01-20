local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  execute 'packadd packer.nvim'
end

vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

-- require('packer').init({display = {non_interactive = true}})
require('packer').init({display = {auto_clean = false}})

return require('packer').startup(function(use)
  -- Packer can manage itself as an optional plugin
  use 'wbthomason/packer.nvim'
  use 'folke/lua-dev.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'folke/lsp-colors.nvim'
  use 'glepnir/lspsaga.nvim'
  use { 'ms-jpq/coq_nvim', branch = 'coq' } -- main one
  use { 'ms-jpq/coq.artifacts', branch= 'artifacts'} -- 9000+ Snippets
  use "folke/trouble.nvim"

  -- Debug
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"}}
  use {'nvim-telescope/telescope-dap.nvim'}
  use {'mfussenegger/nvim-dap-python'}

  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'p00f/nvim-ts-rainbow'
  use 'windwp/nvim-ts-autotag'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use 'romgrk/nvim-treesitter-context'
  use { "yioneko/nvim-yati", requires = "nvim-treesitter/nvim-treesitter" }

  -- Syntax
  use 'sheerun/vim-polyglot'
  use 'elixir-editors/vim-elixir'

  -- Icons
  use {
    'yamatsum/nvim-nonicons',
    requires = {'kyazdani42/nvim-web-devicons'}
  }
  use 'ryanoasis/vim-devicons'

  -- Color
  use 'norcalli/nvim-colorizer.lua'

  -- Git
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }

  -- Telescope
  use {
  'nvim-telescope/telescope.nvim',
  requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
  use {
  "nvim-telescope/telescope-frecency.nvim",
  requires = {"tami5/sqlite.lua"}
  }
  use 'nvim-telescope/telescope-media-files.nvim'
  use "nvim-telescope/telescope-file-browser.nvim"

  -- Flutter
  -- use 'akinsho/flutter-tools.nvim'

  -- Tim Pope docet
  use 'tpope/vim-endwise'
  use 'tpope/vim-surround'

  --UI
  use {
  'nvim-lualine/lualine.nvim',
  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use { 'folke/todo-comments.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- Text edition
  use { 'mg979/vim-visual-multi', branch = 'master' }
  use {'heavenshell/vim-pydocstring', run = 'make install' }
  use 'AndrewRadev/splitjoin.vim'
  use 'wellle/targets.vim'
  use 'numToStr/Comment.nvim'

  --Utils
  use { 'CRAG666/code_runner.nvim', requires = 'nvim-lua/plenary.nvim' }
  -- use 'is0n/fm-nvim'
  use 'ThePrimeagen/harpoon'
  use 'ggandor/lightspeed.nvim'
  use { "vuki656/package-info.nvim", requires = "MunifTanjim/nui.nvim" }
  use 'nathom/filetype.nvim'

  -- General Plugins
  use 'jeffkreeftmeijer/vim-numbertoggle'

  -- Themes
  use 'i3d/vim-jimbothemes'
  use 'owozsh/Amora'
  use 'franbach/miramare'
end)
