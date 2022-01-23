local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    profile = {
      enable = true,
      threshold = 1, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },

    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  -- Plugins
  local function plugins(use)
    use 'wbthomason/packer.nvim'
    use 'folke/lua-dev.nvim'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use {
      'folke/lsp-colors.nvim',
      config = function()
        require("lsp-colors").setup({
          Error = "#f34f4d",
          Warning = "#ffda45",
          Information = "#8accfe",
          Hint = "#7ad88e"
        })
      end
    }
    use 'glepnir/lspsaga.nvim'
    use {
      "ms-jpq/coq_nvim",
      branch = "coq",
      event = "InsertEnter",
      opt = true,
      run = ":COQdeps",
      config = function()
        require("config.coq").setup()
      end,
      requires = {
        { "ms-jpq/coq.artifacts", branch = "artifacts" },
        { "ms-jpq/coq.thirdparty", branch = "3p", module = "coq_3p" },
      },
      disable = false,
    }
    use "folke/trouble.nvim"

    -- Debug
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"}}
    use {'nvim-telescope/telescope-dap.nvim'}
    use {'mfussenegger/nvim-dap-python'}

    -- Treesitter
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = function()
        require("config.treesitter").setup()
        require('treesitter-context').setup()
      end,
      requires = {
        { "nvim-treesitter/nvim-treesitter-textobjects" },
        {'romgrk/nvim-treesitter-context'},
      }
    }
    use {
      'JoosepAlviste/nvim-ts-context-commentstring',
      wants = "nvim-treesitter",
      disable = false,
    }
    use {
      "yioneko/nvim-yati",
      wants = "nvim-treesitter",
      disable = false,
    }
    use {
      'p00f/nvim-ts-rainbow',
      wants = "nvim-treesitter",
      disable = false,
    }
    use {
      'windwp/nvim-ts-autotag',
      wants = "nvim-treesitter",
      event = "InsertEnter",
      config = function()
        require("nvim-ts-autotag").setup { enable = true }
      end,
    }
    use {
      "RRethy/nvim-treesitter-endwise",
      wants = "nvim-treesitter",
      event = "InsertEnter",
      disable = false,
    }
    use {
      "windwp/nvim-autopairs",
      wants = "nvim-treesitter",
      config = function()
        require("config.autopairs").setup()
      end,
    }

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
    use { "tpope/vim-surround", event = "InsertEnter" }

    -- Motions
    use { "andymass/vim-matchup", event = "CursorMoved" }
    use { "wellle/targets.vim", event = "CursorMoved" }
    use { "unblevable/quick-scope", event = "CursorMoved", disable = false }
    use { "chaoren/vim-wordmotion", opt = true, fn = { "<Plug>WordMotion_w" } }
    use {
      'ggandor/lightspeed.nvim',
      keys = { "s", "S", "f", "F", "t", "T" },
      config = function ()
        require'lightspeed'.setup {
          limit_ft_matches = 30,
        }
      end
    }

    --UI
    use {
      "nvim-lualine/lualine.nvim",
      after = "nvim-treesitter",
      config = function()
        require("config.lualine").setup{}
      end,
      wants = "nvim-web-devicons",
    }
    use { 'folke/todo-comments.nvim', requires = 'nvim-lua/plenary.nvim' }

    -- Text edition
    use { 'mg979/vim-visual-multi', branch = 'master' }
    use {'heavenshell/vim-pydocstring', run = 'make install' }
    use 'AndrewRadev/splitjoin.vim'
    use {
      "numToStr/Comment.nvim",
      keys = { "gc", "gcc", "gbc" },
      config = function()
        require("Comment").setup {}
      end,
    }

    --Utils
    use { 'CRAG666/code_runner.nvim', requires = 'nvim-lua/plenary.nvim' }
    -- use 'is0n/fm-nvim'
    use 'ThePrimeagen/harpoon'
    use { "vuki656/package-info.nvim", requires = "MunifTanjim/nui.nvim" }
    use 'nathom/filetype.nvim'

    -- General Plugins
    use 'jeffkreeftmeijer/vim-numbertoggle'

    -- Themes
    use 'i3d/vim-jimbothemes'
    use 'owozsh/Amora'
    use 'franbach/miramare'
    -- Bootstrap Neovim
    if packer_bootstrap then
      print "Restart Neovim required after installation!"
      require("packer").sync()
    end
  end

  -- Init and start packer
  packer_init()
  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)
end

return M
