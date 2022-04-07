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
    colorscheme = "amora",
    styles = {
      ["function"] = { style = "italic" },
      functionbuiltin = { style = "italic" },
      variable = { style = "italic" },
      variableBuiltIn = { style = "italic" },
      parameter = { style = "italic" },
    },
  }

  -- Telescope
  utils.fg_bg("TelescopeBorder", "#1a1a2e", "NONE")
  -- utils.fg_bg("TelescopeBorder", "#161925", "NONE")
  utils.fg_bg("TelescopePromptBorder", "NONE", "NONE")
  utils.fg_bg("TelescopePromptNormal", "white", "NONE")
  utils.fg_bg("TelescopePromptPrefix", "#84c49b", "NONE")

  utils.fg_bg("TelescopePromptTitle", "black", "#fb5c8e")
  utils.fg_bg("TelescopePreviewTitle", "black", "#a29dff")
  utils.fg_bg("TelescopeResultsTitle", "black", "#f79f79")

  utils.bg("TelescopeResults", "NONE")
  utils.bg("TelescopeNormal", "NONE")
  utils.bg("TelescopeSelection", "#2c223c")
end

return M
