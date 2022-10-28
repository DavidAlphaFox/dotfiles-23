local M = {}
local utils = require "utils"
local function SetThemeTelescope()
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
  require("catppuccin").setup({
    flavour = "mocha",
    background = { light = "latte", dark = "mocha" },
    term_colors = true,
    styles = {
      comments = { "bold" },
      properties = { "italic" },
      functions = { "italic" },
      -- keywords = { "italic" },
      operators = { "italic" },
      conditionals = { "italic" },
      loops = { "italic" },
      booleans = {},
      -- numbers = {},
      types = { "bold" },
      -- strings = {},
      -- variables = {},
    },
    integrations = {
      dashboard = false,
      treesitter = true,
      notify = true,
       	mini = true,
      noice = true,
      coc_nvim = false,
      cmp = false,
      lsp_saga = true,
      gitsigns = true,
      leap = true,
      telescope = false,
      nvimtree = false,
      markdown = true,
      ts_rainbow = true,
      dap = {
        enabled = true,
        enable_ui = true,
      },
      lsp_trouble = true,
      fidget = false,
      harpoon = true,
      which_key = true,
      vimwiki = true
    }
  })
  SetThemeTelescope()
  vim.cmd[[colorscheme catppuccin]]
end

return M
