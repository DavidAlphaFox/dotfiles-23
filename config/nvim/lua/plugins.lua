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

    -- Performance
    use "lewis6991/impatient.nvim"
    use "nathom/filetype.nvim"

    use {
      "declancm/cinnamon.nvim",
      config = function()
        require("cinnamon").setup {
          default_keymaps = true, -- Enable default keymaps.
          extra_keymaps = true, -- Enable extra keymaps.
          extended_keymaps = true, -- Enable extended keymaps.
          default_delay = 3
        }
      end,
    }

    -- Themes
    -- use 'i3d/vim-jimbothemes'
    -- use { 'owozsh/amora',
    --   config = function()
    --     vim.g.mode = 'jack-o-lantern'
    --     vim.cmd "colorscheme amora"
    --   end
    -- }
    -- use {
    --   "franbach/miramare",
    --   config = function()
    --     vim.cmd "colorscheme miramare"
    --   end,
    -- }
    -- use 'sainnhe/sonokai'
    use {
      "themercorp/themer.lua",
      config = function()
        require("config.themer").setup()
      end,
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
        "JoosepAlviste/nvim-ts-context-commentstring",
        "RRethy/nvim-treesitter-endwise",
        "yioneko/nvim-yati",
        "p00f/nvim-ts-rainbow",
        "windwp/nvim-ts-autotag",
      },
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
    use {
      "elixir-editors/vim-elixir",
      ft = { "elixir" },
    }

    -- Icons
    use {
      "yamatsum/nvim-nonicons",
      requires = { "kyazdani42/nvim-web-devicons" },
    }

    -- Color
    use {
      "norcalli/nvim-colorizer.lua",
      event = { "BufReadPre" },
      config = function()
        require("colorizer").setup()
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

    -- use { 'liuchengxu/vim-clap', run = ':Clap install-binary' }

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
    -- use { 'monkoose/matchparen.nvim',
    --   config = function()
    --     require('matchparen').setup({
    --       on_startup = true, -- Should it be enabled by default
    --       hl_group = 'MatchParen', -- highlight group for matched characters
    --       augroup_name = 'matchparen', -- almost no reason to touch this unless there is already augroup with such name
    --     })
    --   end
    -- }
    use { "wellle/targets.vim", event = "CursorMoved" }
    use { "chaoren/vim-wordmotion" }

    use {
      "ggandor/leap.nvim",
      config = function()
        require("leap").set_default_keymaps()
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
      "SmiteshP/nvim-gps",
      requires = "nvim-treesitter/nvim-treesitter",
      module = "nvim-gps",
      wants = "nvim-treesitter",
      config = function()
        require("nvim-gps").setup()
      end,
    }

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
    use "gpanders/editorconfig.nvim"

    --Utils
    use {
      "CRAG666/code_runner.nvim",
      requires = "nvim-lua/plenary.nvim",
      branch = "new_features",
      config = function()
        require("config.code_runner").setup()
      end,
    }
    -- use 'is0n/fm-nvim'
    use "ThePrimeagen/harpoon"
    use {
      "vuki656/package-info.nvim",
      opt = true,
      requires = {
        "MunifTanjim/nui.nvim",
      },
      wants = { "nui.nvim" },
      module = { "package-info" },
      ft = { "json" },
      config = function()
        require("package-info").setup { package_manager = "npm" }
      end,
    }

    use { "kshenoy/vim-signature", config = [[require('config.signature')]] }

    -- General Plugins
    use "jeffkreeftmeijer/vim-numbertoggle"

    -- LSP

    use {
      "ms-jpq/coq_nvim",
      branch = "coq",
      event = "VimEnter",
      opt = true,
      run = ":COQdeps",
      config = function()
        require("config.coq").setup()
      end,
      requires = {
        { "ms-jpq/coq.artifacts", branch = "artifacts" },
        { "ms-jpq/coq.thirdparty", branch = "3p", module = "coq_3p" },
      },
    }

    use {
      "neovim/nvim-lspconfig",
      opt = true,
      event = { "VimEnter" },
      wants = {
        "coq_nvim",
        "lua-dev.nvim",
        "null-ls.nvim",
      }, -- for coq.nvim
      config = function()
        require("config.lsp").setup()
      end,
      requires = {
        "folke/lua-dev.nvim",
        "jose-elias-alvarez/null-ls.nvim",
        {
          "j-hui/fidget.nvim",
          config = function()
            require("fidget").setup()
          end,
        },
      },
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

  -- Performance
  pcall(require, "impatient")
  -- pcall(require, "packer_compiled")

  packer.init(conf)
  packer.startup(plugins)
end

return M
