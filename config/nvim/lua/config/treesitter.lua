local M = {}
local theme = require("catppuccin.palettes").get_palette()
-- local colors = vim.tbl_values(theme)
local colors = {
  theme.rosewater,
  theme.flamingo,
  theme.peach,
  theme.maroon,
  theme.mauve,
  theme.yellow,
  theme.pink,
  theme.teal,
  theme.sky,
  theme.lavender,
  theme.sapphire,
  theme.blue,
  theme.green,
  theme.red,
}

function M.setup()
  require("nvim-treesitter.configs").setup {
    ensure_installed = {
      "bash",
      "c",
      "cpp",
      "c_sharp",
      "cmake",
      "comment",
      "css",
      "dockerfile",
      "elixir",
      "fennel",
      "gitignore",
      "help",
      "html",
      "http",
      "java",
      "javascript",
      "jsdoc",
      "json",
      "json5",
      "kotlin",
      "latex",
      "lua",
      "make",
      "markdown",
      "php",
      "python",
      "regex",
      "rust",
      "scss",
      "sql",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "yaml",
    },
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      -- use_languagetree = true,
      additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "gni",
        scope_incremental = "gns",
        node_decremental = "gnd",
      },
    },
    indent = { enable = false },
    yati = {
      enable = true,
      default_lazy = false,
      default_fallback = "auto",
    },
    matchup = {
      enable = true,
    },
    rainbow = {
      enable = true,
      extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
      max_file_lines = nil,
    },
    -- nvim-treesitter-textobjects
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
    },

    endwise = {
      enable = true,
    },
    -- autotag
    autotag = {
      enable = true,
    },
    -- context_commentstring
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
    markid = {
      enable = true,
      colors = colors,
    },
  }
end

return M
