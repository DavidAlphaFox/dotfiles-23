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

  -- Autocomplete
  use 'windwp/nvim-autopairs'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'folke/lsp-colors.nvim'
  use 'glepnir/lspsaga.nvim'
  use 'nvim-lua/lsp-status.nvim'
  -- use 'onsails/lspkind-nvim'
  use 'ray-x/lsp_signature.nvim'
  use { 'ms-jpq/coq_nvim', branch = 'coq'} -- main one
  use { 'ms-jpq/coq.artifacts', branch= 'artifacts'} -- 9000+ Snippets

  -- Debug
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"}}
  use {'nvim-telescope/telescope-dap.nvim'}
  use {'mfussenegger/nvim-dap-python'}

  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'p00f/nvim-ts-rainbow'
  use 'romgrk/nvim-treesitter-context'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use 'windwp/nvim-ts-autotag'

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

  -- General Plugins
  use 'jeffkreeftmeijer/vim-numbertoggle'

  --UI
  use {'glepnir/galaxyline.nvim', branch = 'main'}
  -- use {'alvarosevilla95/luatab.nvim',requires='kyazdani42/nvim-web-devicons'}
  use {'seblj/nvim-tabline',
    requires = {'kyazdani42/nvim-web-devicons'}
  }
  use {
  "folke/todo-comments.nvim",
  requires = "nvim-lua/plenary.nvim",
  }
  use {
  "folke/trouble.nvim",
  requires = "kyazdani42/nvim-web-devicons",
  }

  -- Text edition
  use {'mg979/vim-visual-multi', branch = 'master'}
  use {'heavenshell/vim-pydocstring', run = 'make install' }
  use 'terrortylor/nvim-comment'
  use 'AndrewRadev/splitjoin.vim'
  use {
    "blackCauldron7/surround.nvim",
    config = function()
      require "surround".setup {}
    end
  }

  --Utils
  use 'CRAG666/code_runner.nvim'
  use 'tamago324/lir.nvim'
  -- use 'tamago324/lir-mmv.nvim'
  use 'tamago324/lir-git-status.nvim'
  use 'wellle/targets.vim'

  -- Themes
  use 'franbach/miramare'
  use 'sainnhe/sonokai'
  use 'folke/tokyonight.nvim'
  use 'i3d/vim-jimbothemes'
  use {'frenzyexists/aquarium-vim', branch = 'develop' }
end)
