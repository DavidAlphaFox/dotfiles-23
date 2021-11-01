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
  use 'nvim-lua/lsp-status.nvim'
  use { 'ms-jpq/coq_nvim', branch = 'coq' } -- main one
  use { 'ms-jpq/coq.artifacts', branch= 'artifacts'} -- 9000+ Snippets
  use "folke/trouble.nvim"

  -- Debug
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"}}
  use {'nvim-telescope/telescope-dap.nvim'}
  use {'mfussenegger/nvim-dap-python'}

  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-refactor'
  use 'p00f/nvim-ts-rainbow'
  use 'windwp/nvim-ts-autotag'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use 'romgrk/nvim-treesitter-context'

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
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }

  -- Telescope
  use {
  'nvim-telescope/telescope.nvim',
  requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
  use 'nvim-telescope/telescope-media-files.nvim'

  -- Flutter
  -- use 'akinsho/flutter-tools.nvim'

  -- Tim Pope docet
  use 'tpope/vim-endwise'
  use "tpope/vim-surround"

  -- General Plugins
  use 'jeffkreeftmeijer/vim-numbertoggle'

  --UI
  use {'glepnir/galaxyline.nvim', branch = 'main'}
  use { 'folke/todo-comments.nvim', requires = 'nvim-lua/plenary.nvim' }
  use {
    'noib3/cokeline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
  }

  -- Text edition
  use { 'mg979/vim-visual-multi', branch = 'master' }
  use {'heavenshell/vim-pydocstring', run = 'make install' }
  use 'AndrewRadev/splitjoin.vim'
  use 'wellle/targets.vim'
  use 'numToStr/Comment.nvim'
  use 'windwp/nvim-autopairs'

  --Utils
  use { 'CRAG666/code_runner.nvim', requires = 'nvim-lua/plenary.nvim' }
  use 'is0n/fm-nvim'
  use 'ThePrimeagen/harpoon'

  -- Themes
  use 'franbach/miramare'
  use 'i3d/vim-jimbothemes'
  use {'frenzyexists/aquarium-vim', branch = 'develop' }
end)
