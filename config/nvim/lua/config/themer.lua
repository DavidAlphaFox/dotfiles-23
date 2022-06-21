local utils = require "utils"

local M = {}

-- TODO: colors
-- amora.lua
-- astron.lua
-- ayu.lua
-- ayu_dark.lua
-- ayu_mirage.lua
-- boo.lua
-- catppuccin.lua
-- darknight.lua
-- doom_one.lua
-- dracula.lua
-- everforest.lua
-- github_dark.lua
-- github_dark_colorblind.lua
-- github_light.lua
-- gruvbox-material-dark-hard.lua
-- gruvbox-material-dark-medium.lua
-- gruvbox-material-dark-soft.lua
-- gruvbox.lua
-- javacafe.lua
-- jellybeans.lua
-- kanagawa.lua
-- kurai.lua
-- monokai.lua
-- monokai_pro.lua
-- nightlamp.lua
-- nord.lua
-- onedark.lua
-- onedark_deep.lua
-- papa_dark.lua
-- rose_pine.lua
-- rose_pine_dawn.lua
-- rose_pine_moon.lua
-- sakura.lua
-- scery.lua
-- shado.lua
-- tokyodark.lua
-- tokyonight.lua
-- uwu.lua

function M.setup()
  require("themer").setup {
    colorscheme = vim.g.colorscheme,
    transparent = true,
    styles = {
      keyword = { style = 'italic' },
      keywordBuiltIn = { style = 'italic' },
      ["function"] = { style = "italic" },
      functionbuiltin = { style = "italic" },
      parameter = { style = "italic" },
      property = { style = "bold" },
      comment = { style = "bold" },
      number = { style = "bold" },
      variable = { style = "italic" },
      variableBuiltIn = { style = "bold" },
      type = { style = "bold" },
      typeBuiltin = { style = "bold" },
    },
  }

  local theme = require("themer.modules.core.api").get_cp(vim.g.colorscheme)
  utils.fg_bg("FoldColumn", theme.syntax.string, "NONE")
  -- Telescope
  utils.fg_bg("TelescopeBorder", theme.bg.base, "NONE")
  -- -- utils.fg_bg("TelescopeBorder", "#161925", "NONE")
  utils.fg_bg("TelescopePromptBorder", "NONE", "NONE")
  utils.fg_bg("TelescopePromptNormal", "white", "NONE")
  utils.fg_bg("TelescopePromptPrefix", theme.syntax.string, "NONE")
  utils.fg("TelescopePromptCounter", "white")

  utils.fg_bg("TelescopePromptTitle", "black", theme.syntax.include)
  utils.fg_bg("TelescopePreviewTitle", "black", theme.syntax['function'])
  utils.fg_bg("TelescopeResultsTitle", "black", theme.syntax.field)

  utils.bg("TelescopeResults", "NONE")
  utils.bg("TelescopeNormal", "NONE")
  utils.bg("TelescopeSelection", theme.bg.selected)
end

return M
