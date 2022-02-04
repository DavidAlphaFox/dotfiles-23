local M = {}

function M.setup()
  require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
      enable = true,              -- false will disable the whole extension
      use_languagetree = true,
      additional_vim_regex_highlighting = true
    },
    indent = { enable = false },
    yati = { enable = true },
    matchup = {
      enable = true,
    },
    rainbow = {
      enable = true,
      extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
      max_file_lines = nil
    },
    context_commentstring = {
      enable = true,
      -- typescript = {
      --   __default = '// %s',
      --   __multiline = '/* %s */',
      --   tsx_element = '{/* %s */}',
      --   tsx_fragment = '{/* %s */}',
      --   tsx_attribute = '// %s',
      --   comment = '// %s'
      -- },
      enable_autocmd = false
    },
    textobjects = {
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
    },
  }
end
return M
