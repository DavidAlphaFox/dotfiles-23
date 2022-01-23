local M = {}

function M.setup()
  require'nvim-treesitter.configs'.setup {
    ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
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
      enable_autocmd = false,
    },
    endwise = {
      enable = true,
    },
  }
end
return M
