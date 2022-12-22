--  _____  _             _
-- |  __ \| |           (_)
-- | |__) | |_   _  __ _ _ _ __  ___
-- |  ___/| | | | |/ _` | | '_ \/ __|
-- | |    | | |_| | (_| | | | | \__ \
-- |_|    |_|\__,_|\__, |_|_| |_|___/
--                  __/ |
--                 |___/
local M = {}

function M.setup()
  -- Indicate first time installation
  local is_boostrap = false

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
      fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      is_boostrap = true
      vim.cmd [[packadd packer.nvim]]
    end

    -- Run PackerCompile if there are changes in this file
    -- vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
    local packer_grp = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
    vim.api.nvim_create_autocmd(
      { "BufWritePost" },
      { pattern = vim.fn.expand "$MYVIMRC", command = "source <afile> | PackerCompile", group = packer_grp }
    )
  end

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

    --
    -- Performance
    --

    use { "lewis6991/impatient.nvim" }
    use "miversen33/import.nvim"

    --
    -- End Performance
    --

    --
    -- TREESITTER
    --

    use {
      "nvim-treesitter/nvim-treesitter",
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
        "David-Kunz/markid",
      },
    }

    --
    -- End TREESITTER
    --

    --
    -- Appearance
    --

    use {
      "prichrd/netrw.nvim",
      config = function()
        require("config.netrw").setup()
      end,
    }

    -- use {
    --   "rcarriga/nvim-notify",
    --   config = function()
    --     vim.notify = require "notify"
    --   end,
    -- disable = true
    -- }

    use {
      "folke/noice.nvim",
      after = { "nvim-cmp" },
      config = function()
        require("noice").setup {
          popupmenu = {
            enabled = true,
            backend = "cmp",
          },
          lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
              ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
              ["vim.lsp.util.stylize_markdown"] = true,
              ["cmp.entry.get_documentation"] = true,
            },
          },
          -- you can enable a preset for easier configuration
          presets = {
            bottom_search = false, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false, -- add a border to hover docs and signature help
          },
        }
      end,
      requires = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
      -- disable = true,
    }

    -- Mini plugins
    use {
      "echasnovski/mini.indentscope",
      config = function()
        require("mini.indentscope").setup()
      end,
    }

    use {
      "echasnovski/mini.tabline",
      config = function()
        require("mini.tabline").setup()
      end,
    }

    -- Themes

    use "kvrohit/mellow.nvim"

    use {
      "catppuccin/nvim",
      as = "catppuccin",
      wants = "nvim-treesitter",
      -- run = ":CatppuccinCompile",
      config = function()
        require("config.catppuccin").setup()
      end,
    }

    -- Icons
    use {
      "kyazdani42/nvim-web-devicons",
      config = function()
        require("config.icons").setup()
      end,
      requires = {
        {
          "DaikyXendo/nvim-material-icon",
          config = function()
            require("nvim-material-icon").setup()
          end,
        },
      },
    }
    -- use {
    --   'yamatsum/nvim-nonicons',
    --   requires = { 'kyazdani42/nvim-web-devicons' }
    -- }

    -- Status line
    use {
      "nvim-lualine/lualine.nvim",
      after = { "catppuccin" },
      config = function()
        require("config.lualine").setup()
      end,
      disable = true,
    }

    use {
      "feline-nvim/feline.nvim",
      after = { "catppuccin" },
      config = function()
        require("config.feline").setup()
      end,
    }

    use {
      "jinh0/eyeliner.nvim",
      config = function()
        require("eyeliner").setup {
          bold = true, -- Default: false
          underline = true, -- Default: false
        }
      end,
    }

    -- Highlight Color
    use {
      "brenoprata10/nvim-highlight-colors",
      config = function()
        require("nvim-highlight-colors").setup {
          render = "background", -- or 'foreground' or 'first_column'
          enable_tailwind = false,
        }
      end,
    }

    use {
      "chentoast/marks.nvim",
      config = function()
        require("marks").setup()
      end,
    }

    use {
      "sitiom/nvim-numbertoggle",
      config = function()
        require("numbertoggle").setup()
      end,
    }

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

    use {
      "kevinhwang91/nvim-ufo",
      requires = "kevinhwang91/promise-async",
      config = function()
        require("ufo").setup {
          provider_selector = function(bufnr, filetype, buftype)
            return { "treesitter", "indent" }
          end,
        }
      end,
    }

    --
    -- End Appearance
    --

    --
    -- Git
    --
    -- use "cosmicthemethhead/gitlens.nvim"

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
      "sindrets/diffview.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("diffview").setup()
      end,
    }

    --
    -- End Git
    --

    --
    -- Telescope
    --

    use {
      "nvim-telescope/telescope.nvim",
      event = { "VimEnter" },
      config = function()
        require("config.telescope").setup()
      end,
      wants = {
        "plenary.nvim",
        "popup.nvim",
        "telescope-zf-native.nvim",
        "telescope-frecency.nvim",
        "telescope-file-browser.nvim",
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
      },
    }

    use {
      "LukasPietzschmann/telescope-tabs",
      requires = { "nvim-telescope/telescope.nvim" },
      config = function()
        require("telescope-tabs").setup {}
      end,
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

    use {
      "windwp/nvim-autopairs",
      config = function()
        require("config.autopairs").setup()
      end,
    }

    use { "wellle/targets.vim", event = "CursorMoved" }

    use { "mg979/vim-visual-multi", branch = "master", config = [[require('config.multi_cursors')]] }

    -- use { "m4xshen/autoclose.nvim", event = "InsertEnter" }

    use { "chaoren/vim-wordmotion", event = "CursorMoved" }

    use {
      "kylechui/nvim-surround",
      event = "CursorMoved",
      config = function()
        require("nvim-surround").setup()
      end,
    }

    -- Tim Pope docet
    use { "tpope/vim-repeat", event = "CursorMoved" }

    use {
      "cshuaimin/ssr.nvim",
      module = "ssr",
      -- Calling setup is optional.
      config = function()
        require("ssr").setup {
          min_width = 50,
          min_height = 5,
          keymaps = {
            close = "q",
            next_match = "n",
            prev_match = "N",
            replace_all = "<leader><cr>",
          },
        }
      end,
    }

    --
    -- End Text Edition
    --

    --
    -- Utils
    --

    use {
      "folke/which-key.nvim",
      event = "VimEnter",
      module = { "which-key" },
      config = function()
        require("which-key").setup {
          -- window = { position = "top" },
          icons = {
            breadcrumb = "»",
            separator = "➜",
            group = "…",
          },
          spelling = { enabled = true, suggestions = 20 },
        }
      end,
    }

    use {
      "max397574/better-escape.nvim",
      config = function()
        require("better_escape").setup()
      end,
    }

    use "gpanders/editorconfig.nvim"

    use {
      "CRAG666/betterTerm.nvim",
      config = function()
        require("config.betterTerm").setup()
      end,
    }

    use {
      "CRAG666/code_runner.nvim",
      -- event = "BufWritePost",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("config.code_runner").setup()
      end,
    }

    use {
      "rest-nvim/rest.nvim",
      ft = { "http" },
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("config.rest").setup()
      end,
    }

    use {
      "ThePrimeagen/harpoon",
      config = function()
        require("config.harpoon").setup()
      end,
    }

    use {
      "numToStr/Comment.nvim",
      event = "CursorMoved",
      config = function()
        require("config.comment").setup()
      end,
    }

    use {
      "danymat/neogen",
      event = "CursorMoved",
      config = function()
        require("config.neogen").setup()
      end,
      requires = "nvim-treesitter/nvim-treesitter",
    }

    use {
      "ggandor/leap.nvim",
      event = "CursorMoved",
      config = function()
        require("leap").set_default_keymaps()
      end,
    }

    use {
      "gen740/SmoothCursor.nvim",
      config = function()
        require("smoothcursor").setup { fancy = { enable = true } }
      end,
    }

    use {
      "tpope/vim-dadbod",
      requires = {
        "kristijanhusak/vim-dadbod-ui",
        "kristijanhusak/vim-dadbod-completion",
      },
      config = function()
        require("config.dadbod").setup()
      end,
    }

    -- Refactoring
    use {
      "ThePrimeagen/refactoring.nvim",
      module = { "refactoring", "telescope" },
      keys = { [[<leader>re]] },
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
      module = { "package-info" },
      ft = { "json" },
      config = function()
        require("package-info").setup { package_manager = "yarn" }
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
      run = ":COQdeps",
      config = function()
        require("config.coq").setup()
      end,
      requires = {
        { "ms-jpq/coq.artifacts", branch = "artifacts" },
        { "ms-jpq/coq.thirdparty", branch = "3p", module = "coq_3p" },
      },
      disable = vim.g.cmp_enable,
    }

    use {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      opt = true,
      config = function()
        require("config.cmp").setup()
      end,
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        "ray-x/cmp-treesitter",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        { "hrsh7th/cmp-nvim-lsp", module = { "cmp_nvim_lsp" } },
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "lukas-reineke/cmp-rg",
        "davidsierradz/cmp-conventionalcommits",
        { "onsails/lspkind-nvim", module = { "lspkind" } },
        -- "hrsh7th/cmp-calc",
        -- "f3fora/cmp-spell",
        -- "hrsh7th/cmp-emoji",
        {
          "L3MON4D3/LuaSnip",
          config = function()
            require("config.snip").setup()
          end,
          module = { "luasnip" },
        },
        "rafamadriz/friendly-snippets",
        "honza/vim-snippets",
        { "tzachar/cmp-tabnine", run = "./install.sh", disable = true },
      },
      disable = not vim.g.cmp_enable,
    }

    -- use {
    --   'mendes-davi/coq_luasnip',
    --   requires = {
    --     {
    --       "L3MON4D3/LuaSnip",
    --       config = function()
    --         require("config.snip").setup()
    --       end,
    --     },
    --
    --   }
    -- }

    use "neovim/nvim-lspconfig"
    use {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup()
      end,
    }
    use "folke/neodev.nvim"
    use "jose-elias-alvarez/null-ls.nvim"
    use "Decodetalkers/csharpls-extended-lsp.nvim"
    use "Hoffs/omnisharp-extended-lsp.nvim"

    use {
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      config = function()
        require("lsp_lines").setup()
      end,
    }

    use {
      "glepnir/lspsaga.nvim",
      branch = "main",
      config = function()
        require("config.lsp.saga").setup()
      end,
    }

    use {
      "folke/trouble.nvim",
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
      module = { "dap" },
      requires = {
        { "theHamsta/nvim-dap-virtual-text", module = { "nvim-dap-virtual-text" } },
        { "rcarriga/nvim-dap-ui", module = { "dapui" } },
        { "mfussenegger/nvim-dap-python", module = { "dap-python" } },
        "nvim-telescope/telescope-dap.nvim",
        { "jbyuki/one-small-step-for-vimkind", module = "osv" },
        { "mxsdev/nvim-dap-vscode-js", module = { "dap-vscode-js" } },
        {
          "microsoft/vscode-js-debug",
          opt = true,
          run = "npm install --legacy-peer-deps && npm run compile",
          disable = false,
        },
      },
      config = function()
        require("config.dap").setup()
      end,
      disable = false,
    }

    --
    -- End Debugging
    --

    --
    -- Syntax
    --

    use { "jidn/vim-dbml", ft = { "dbml" } }
    use {
      "elixir-editors/vim-elixir",
      ft = { "elixir" },
      disable = true,
    }

    --
    -- End Syntax
    --

    -- Bootstrap Neovim
    if is_boostrap then
      print "Neovim restart is required after installation!"
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
