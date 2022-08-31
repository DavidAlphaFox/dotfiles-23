local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    auto_reload_compiled = true,
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
    -- vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
    vim.api.nvim_create_autocmd("BufWritePost", {
	    pattern = { "plugins.lua", "catppuccin.lua" },
	    callback = function()
		    vim.cmd "PackerCompile"
	    end
    })
  end

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

    --
    -- Performance
    --

    use "lewis6991/impatient.nvim"
    use "nathom/filetype.nvim"

    --
    -- End Performance
    --

    --
    -- Appearance
    --

    use {
      "catppuccin/nvim",
      as = "catppuccin",
      run = ":CatppuccinCompile",
      config = function()
        require("config.catppuccin").setup()
      end,
    }

    -- use "kyazdani42/nvim-web-devicons"
    -- Icons
    use {
      "yamatsum/nvim-nonicons",
      requires = { "kyazdani42/nvim-web-devicons" },
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
      -- disable = true
    }

    -- Notification
    use {
      "rcarriga/nvim-notify",
      event = "BufReadPre",
      config = function()
        require'notify'.setup({
          background_colour = "#1a1a2e",
        })
        vim.notify = require "notify"
      end,
    }

    use {
      'jinh0/eyeliner.nvim',
    config = function()
        require('eyeliner').setup {
          bold = true, -- Default: false
          underline = true -- Default: false
        }
      end
    }

    -- Highlight Color
    use {
      "brenoprata10/nvim-highlight-colors",
      config = function()
        require("nvim-highlight-colors").setup {
          render = 'background', -- or 'foreground' or 'first_column'
          enable_tailwind = false
        }
      end,
    }

    use { "kshenoy/vim-signature", config = [[require('config.signature')]] }

    use "jeffkreeftmeijer/vim-numbertoggle"

    -- Todo
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

    --
    -- End Appearance
    --

    --
    -- TREESITTER
    --

    use {
      "nvim-treesitter/nvim-treesitter",
      opt = true,
      event = "BufReadPre",
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

    use {
      'm-demare/hlargs.nvim',
      wants = { "catppuccin" },
      requires = { 'nvim-treesitter/nvim-treesitter' },
      config = function()
        require('hlargs').setup({
          color = '#fab387',
        })
      end
    }

    --
    -- End TREESITTER
    --

    --
    -- Git
    --

    use {
      "lewis6991/gitsigns.nvim",
      event = "BufReadPre",
      wants = "plenary.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("config.gitsigns").setup()
      end,
    }

    use {
      'sindrets/diffview.nvim',
      requires = 'nvim-lua/plenary.nvim',
      config = function()
        require("diffview").setup()
      end

    }

    --
    -- End Git
    --

    --
    -- Telescope
    --

    use {
      "nvim-telescope/telescope.nvim",
      -- opt = true,
      config = function()
        require("config.telescope").setup()
      end,
      wants = {
        "plenary.nvim",
        "popup.nvim",
        "telescope-zf-native.nvim",
        "telescope-frecency.nvim",
        "telescope-file-browser.nvim",
        "telescope-tele-tabby",
        "trouble.nvim",
        "telescope-dap.nvim",
      },
      requires = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-dap.nvim",
        "natecraddock/telescope-zf-native.nvim",
        {
          "nvim-telescope/telescope-frecency.nvim",
          requires = { "tami5/sqlite.lua" },
        },
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-media-files.nvim",
        "TC72/telescope-tele-tabby.nvim"
      },
    }

    use {
      "stevearc/dressing.nvim",
      event = "BufReadPre",
      config = function()
        require("dressing").setup {
          input = { relative = "editor" },
          select = {
            backend = { "telescope", "fzf", "builtin" },
          },
        }
      end,
    }

    --
    -- End Telescope
    --

    --
    -- Text Edition
    --

    use { "wellle/targets.vim", event = "CursorMoved" }

    use { "mg979/vim-visual-multi", branch = "master", config = [[require('config.multi_cursors')]] }

    -- use { "m4xshen/autoclose.nvim", event = "InsertEnter" }

    use "chaoren/vim-wordmotion"

    use {
      "kylechui/nvim-surround",
      config = function()
         require("nvim-surround").setup()
      end
    }

    use "Matt-A-Bennett/vim-surround-funk"

    -- Tim Pope docet
    -- use "tpope/vim-surround"
    use "tpope/vim-repeat"

    --
    -- End Text Edition
    --

    --
    -- Utils
    --

    use "gpanders/editorconfig.nvim"

    use {
      "CRAG666/code_runner.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("config.code_runner").setup()
      end,
    }

    use {
      "ThePrimeagen/harpoon",
      config = function()
        require("harpoon").setup {
          global_settings = {
            save_on_toggle = true,
            enter_on_sendcmd = true,
          },
        }
      end
    }

    use {
      'numToStr/Comment.nvim',
      config = function()
          require("config.comment").setup()
      end
    }

    use {
      "danymat/neogen",
      config = function()
        require("config.neogen").setup()
      end,
      requires = "nvim-treesitter/nvim-treesitter",
    }

    use {
      "ggandor/leap.nvim",
      config = function()
        require("leap").set_default_keymaps()
      end,
    }

    use {
      "declancm/cinnamon.nvim",
      config = function()
        require("cinnamon").setup {
          default_keymaps = true, -- Create default keymaps.
          extra_keymaps = true, -- Create extra keymaps.
          extended_keymaps = true, -- Create extended keymaps.
          override_keymaps = true,
          default_delay = 4
        }
      end,
    }

    -- Refactoring
    use {
      "ThePrimeagen/refactoring.nvim",
      module = { "refactoring", "telescope" },
      keys = { [[<leader>r]] },
      wants = { "telescope.nvim" },
      config = function()
        require("config.refactoring").setup()
      end,
    }

    -- package json
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

    --
    -- End Utils
    --

    --
    -- LSP
    --

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
      event = { "BufReadPre" },
      wants = {
        "coq_nvim",
        "lua-dev.nvim",
        "vim-illuminate",
        "refactoring.nvim",
        "null-ls.nvim",
        "omnisharp-extended-lsp.nvim",
        "csharpls-extended-lsp.nvim",
      }, -- for coq.nvim
      config = function()
        require("config.lsp").setup()
      end,
      requires = {
        "folke/lua-dev.nvim",
        "RRethy/vim-illuminate",
        "jose-elias-alvarez/null-ls.nvim",
        "Hoffs/omnisharp-extended-lsp.nvim",
        "Decodetalkers/csharpls-extended-lsp.nvim",
      }
    }

    use({
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      config = function()
        require("lsp_lines").setup()
      end,
    })

    use {
      "kevinhwang91/nvim-ufo",
      opt = true,
      -- event = { "BufReadPre" },
      wants = { "promise-async" },
      requires = "kevinhwang91/promise-async",
      config = function()
        require("ufo").setup {
          provider_selector = function(bufnr, filetype)
            return { "lsp", "treesitter", "indent" }
          end,
        }
      end
    }

    use {
      "glepnir/lspsaga.nvim",
      branch = 'main',
      -- wants = { "nvim-lspconfig" },
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

    --
    -- End LSP
    --

    --
    -- Debugging
    --

    use {
      "mfussenegger/nvim-dap",
      opt = true,
      -- event = "BufReadPre",
      keys = { [[<leader>d]] },
      module = { "dap" },
      wants = { "nvim-dap-virtual-text", "DAPInstall.nvim", "nvim-dap-ui", "nvim-dap-python" },
      requires = {
        "alpha2phi/DAPInstall.nvim",
        -- { "Pocco81/dap-buddy.nvim", branch = "dev" },
        "theHamsta/nvim-dap-virtual-text",
        "rcarriga/nvim-dap-ui",
        "mfussenegger/nvim-dap-python",
        "nvim-telescope/telescope-dap.nvim",
        { "jbyuki/one-small-step-for-vimkind", module = "osv" },
      },
      config = function()
        require("config.dap").setup()
      end,
    }

    --
    -- End Debugging
    --

    --
    -- Syntax
    --

    use "jidn/vim-dbml"
    use {
      "elixir-editors/vim-elixir",
      ft = { "elixir" },
    }

    --
    -- End Syntax
    --

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
