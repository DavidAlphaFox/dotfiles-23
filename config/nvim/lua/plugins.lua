local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    profile = {
      enable = true,
      threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
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
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
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
    use { "wbthomason/packer.nvim" }

    -- SpeedUp
    use "lewis6991/impatient.nvim"
    use "nathom/filetype.nvim"

    -- Themes
    -- use 'i3d/vim-jimbothemes'
    -- use 'owozsh/amora'
    -- use 'franbach/miramare'
    -- use 'sainnhe/sonokai'
    use {
      "themercorp/themer.lua",
      config = function()
        require("config.themer").setup()
      end,
      disable = false,
    }

    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      opt = true,
      event = "BufRead",
      run = ":TSUpdate",
      config = function()
        require("config.treesitter").setup()
      end,
      requires = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "windwp/nvim-ts-autotag",
        "JoosepAlviste/nvim-ts-context-commentstring",
        "yioneko/nvim-yati",
        "p00f/nvim-ts-rainbow",
      },
    }

    -- Auto tag
    use {
      "windwp/nvim-ts-autotag",
      wants = "nvim-treesitter",
      event = "InsertEnter",
      config = function()
        require("nvim-ts-autotag").setup { enable = true }
      end,
    }

    -- Auto pairs
    -- use {
    -- 	"windwp/nvim-autopairs",
    -- 	wants = "coq_nvim",
    -- 	config = function()
    -- 		require("config.autopairs").setup()
    -- 	end,
    -- 	disable = true
    -- }

    use { "max-0406/autoclose.nvim", event = "InsertEnter" }

    use {
      "danymat/neogen",
      config = function()
        require("config.neogen").setup()
      end,
      requires = "nvim-treesitter/nvim-treesitter",
    }

    -- Syntax
    use "elixir-editors/vim-elixir"

    -- Icons
    use {
      "yamatsum/nvim-nonicons",
      requires = { "kyazdani42/nvim-web-devicons" },
    }
    use "ryanoasis/vim-devicons"

    -- Color
    use {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("config.colorizer").setup()
      end,
    }

    -- Git
    use {
      "lewis6991/gitsigns.nvim",
      event = "BufReadPre",
      wants = "plenary.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("config.gitsigns").setup()
      end,
    }

    -- Telescope
    use {
      "nvim-telescope/telescope.nvim",
      -- opt = true,
      config = function()
        require("config.telescope").setup()
      end,
      -- cmd = { "Telescope" },
      -- module = { "telescope", "telescope.builtin" },
      wants = {
        "plenary.nvim",
        "popup.nvim",
        "telescope-frecency.nvim",
        "telescope-file-browser.nvim",
        "trouble.nvim",
        "telescope-dap.nvim",
      },
      requires = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        {
          "nvim-telescope/telescope-frecency.nvim",
          requires = { "tami5/sqlite.lua" },
        },
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-media-files.nvim",
        "nvim-telescope/telescope-dap.nvim",
      },
    }

    -- Flutter
    -- use 'akinsho/flutter-tools.nvim'

    -- Better surround
    -- Tim Pope docet
    use "tpope/vim-surround"
    use "Matt-A-Bennett/vim-surround-funk"
    use "tpope/vim-repeat"

    -- Motions
    use { "andymass/vim-matchup", event = "CursorMoved" }
    use { "wellle/targets.vim", event = "CursorMoved" }
    use { "chaoren/vim-wordmotion", opt = true, fn = { "<Plug>WordMotion_w" } }

    use {
      "ggandor/lightspeed.nvim",
      keys = { "s", "S", "f", "F", "t", "T" },
      config = function()
        require("lightspeed").setup {
          limit_ft_matches = 30,
        }
      end,
    }

    -- Status line
    use {
      "nvim-lualine/lualine.nvim",
      event = "VimEnter",
      after = "nvim-treesitter",
      config = function()
        require("config.lualine").setup()
      end,
      wants = "nvim-web-devicons",
    }

    --UI
    use {
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup {
          highlight = {
            keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
          },
        }
      end,
    }

    -- Text edition
    use { "mg979/vim-visual-multi", branch = "master", config = [[require('config.multi_cursors')]] }
    use "AndrewRadev/splitjoin.vim"
    use {
      "numToStr/Comment.nvim",
      config = function()
        require("config.comment").setup()
      end,
    }

    --Utils
    use {
      "CRAG666/code_runner.nvim",
      requires = "nvim-lua/plenary.nvim",
      -- branch = 'enhancement',
      config = function()
        require("config.code_runner").setup()
      end,
    }
    -- use 'is0n/fm-nvim'
    use "ThePrimeagen/harpoon"
    use {
      "vuki656/package-info.nvim",
      requires = "MunifTanjim/nui.nvim",
      config = function()
        require("package-info").setup { package_manager = "npm" }
      end,
    }
    use { "kshenoy/vim-signature", config = [[require('config.signature')]] }

    -- General Plugins
    use "jeffkreeftmeijer/vim-numbertoggle"

    -- LSP
    use {
      "neovim/nvim-lspconfig",
      opt = true,
      event = { "BufReadPre" },
      wants = {
        "coq_nvim",
        "lua-dev.nvim",
        "null-ls.nvim",
        -- "nvim-lsp-ts-utils",
      },
      config = function()
        require("config.lsp").setup()
      end,
      requires = {
        "folke/lua-dev.nvim",
        "jose-elias-alvarez/null-ls.nvim",
        {
          "j-hui/fidget.nvim",
          config = function()
            require("fidget").setup {}
          end,
        },
        -- "jose-elias-alvarez/nvim-lsp-ts-utils",
      },
    }

    use {
      "ms-jpq/coq_nvim",
      branch = "coq",
      -- event = "VimEnter",
      -- opt = true,
      run = ":COQdeps",
      config = function()
        require("config.coq").setup()
      end,
      requires = {
        { "ms-jpq/coq.artifacts", branch = "artifacts" },
        { "ms-jpq/coq.thirdparty", branch = "3p", module = "coq_3p" },
      },
      -- disable = not PLUGINS.coq.enabled,
    }

    use {
      "folke/lsp-colors.nvim",
      wants = { "nvim-lspconfig" },
      config = function()
        require("lsp-colors").setup {
          Error = "#f34f4d",
          Warning = "#ffda45",
          Information = "#8accfe",
          Hint = "#7ad88e",
        }
      end,
    }

    use {
      "glepnir/lspsaga.nvim",
      wants = { "nvim-lspconfig" },
      config = function()
        require("config.lsp.saga").setup()
      end,
    }

    use {
      "folke/trouble.nvim",
      wants = { "nvim-lspconfig" },
      config = function()
        require("config.lsp.diagnostics").setup()
      end,
    }

    -- Debug
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
    use { "mfussenegger/nvim-dap-python" }

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
