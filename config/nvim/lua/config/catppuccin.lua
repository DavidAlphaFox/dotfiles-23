local M = {}
local utils = require "utils"
local function SetTheme()
  local colors = require("catppuccin.palettes").get_palette()
  -- Telescope
  -- utils.fg_bg("TelescopeBorder", "NONE", "NONE")
  -- utils.fg_bg("TelescopePromptBorder", "NONE", "NONE")
  utils.fg_bg("TelescopePromptNormal", colors.flamingo, "NONE")
  utils.fg_bg("TelescopePromptPrefix", colors.sapphire, "NONE")
  utils.fg("TelescopePromptCounter", "white")

  utils.fg_bg("TelescopePromptTitle", "black", colors.mauve)
  utils.fg_bg("TelescopePreviewTitle", "black", colors.lavender)
  utils.fg_bg("TelescopeResultsTitle", "black", colors.red)

  -- utils.bg("TelescopeResults", "NONE")
  -- utils.bg("TelescopeNormal", "NONE")
  utils.bg("TelescopeSelection", colors.mantle)
 -- TelescopeSelectionCaret = { fg = cp.flamingo },
 -- TelescopeMatching = { fg = cp.blue },
 -- TelescopeResultsNormal = { bg = cp.mantle},
 -- TelescopePreviewNormal = { bg = cp.crust },
 -- TelescopeResultsBorder = { bg = cp.mantle, fg = cp.crust },
 -- TelescopePreviewBorder = { bg = cp.crust, fg = cp.crust },

end

function M.setup()
  vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
  require("catppuccin").setup({
    compile = {
	    enabled = true,
	    path = vim.fn.expand("~/.cache/catppuccin")
    },
    styles = {
        comments = { "bold" },
        conditionals = { "italic" },
        loops = { "italic" },
        functions = { "italic" },
        numbers = { "bold" },
        properties = { "bold" },
        operators = { "italic" },
    },
    integrations = {
      treesitter = true,
      coc_nvim = false,
      lsp_trouble = true,
      cmp = false,
      lsp_saga = true,
      gitsigns = true,
      leap = true,
      telescope = false,
      nvimtree = false,
      ts_rainbow = true,
      dap = {
        enabled = true,
        enable_ui = true,
      },
    }
  })
  vim.cmd[[colorscheme catppuccin]]
  SetTheme()
end

return M
