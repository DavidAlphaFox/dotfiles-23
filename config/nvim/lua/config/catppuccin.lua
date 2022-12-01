local M = {}
local utils = require "utils"
local function SetStyle()
  local colors = require("catppuccin.palettes").get_palette()
  -- Telescope
  -- utils.fg_bg("TelescopePromptBorder", "NONE", "NONE")
  utils.fg_bg("TelescopePromptNormal", colors.flamingo, "NONE")
  utils.fg_bg("TelescopePromptPrefix", colors.sapphire, "NONE")
  utils.fg("TelescopePromptCounter", "white")

  utils.fg_bg("TelescopePromptTitle", colors.base, colors.red)
  utils.fg_bg("TelescopePreviewTitle", colors.base, colors.teal)
  utils.fg_bg("TelescopeResultsTitle", colors.base, colors.peach)

  -- utils.bg("TelescopeResults", "NONE")
  -- utils.bg("TelescopeNormal", "NONE")
  -- utils.bg("TelescopeSelection", colors.mantle)
  utils.fg("TelescopeSelectionCaret", colors.red)
  utils.fg("TelescopeMatching", colors.green)
  -- TelescopeResultsNormal = { bg = cp.mantle},
  -- TelescopePreviewNormal = { bg = cp.crust },
  -- TelescopeResultsBorder = { bg = cp.mantle, fg = cp.crust },
  -- TelescopePreviewBorder = { bg = cp.crust, fg = cp.crust },
  if vim.g.cmp_enable then
    utils.fg_bg("CmpItemKindClass", colors.base, colors.green)
    utils.fg_bg("CmpItemKindInterface", colors.base, colors.teal)
    utils.fg_bg("CmpItemKindConstructor", colors.base, colors.sky)
    utils.fg_bg("CmpItemKindMethod", colors.base, colors.sapphire)
    utils.fg_bg("CmpItemKindFunction", colors.base, colors.red)
    utils.fg_bg("CmpItemKindVariable", colors.base, colors.peach)
    utils.fg_bg("CmpItemKindProperty", colors.base, colors.yellow)
    utils.fg_bg("CmpItemKindKeyword", colors.base, colors.blue)
    utils.fg_bg("CmpItemKindField", colors.base, colors.rosewater)
    utils.fg_bg("CmpItemKindText", colors.base, colors.mauve)
    utils.fg_bg("CmpItemKindUnit", colors.base, colors.lavender)
    utils.fg_bg("CmpItemKindValue", colors.base, colors.pink)
    utils.fg_bg("CmpItemKindSnippet", colors.base, colors.maroon)
    utils.fg_bg("CmpItemKindFile", colors.base, colors.flamingo)
    utils.fg_bg("CmpItemKindFolder", colors.base, colors.subtext0)
    utils.fg_bg("CmpItemKindTypeParameter", colors.base, colors.surface1)
  end
end

function M.setup()
  require("catppuccin").setup {
    flavour = "mocha",
    background = { light = "latte", dark = "mocha" },
    dim_inactive = {
      enabled = false,
      -- Dim inactive splits/windows/buffers.
      -- NOT recommended if you use old palette (a.k.a., mocha).
      shade = "dark",
      percentage = 0.15,
    },
    -- term_colors = true,
    styles = {
      comments = { "bold" },
      properties = { "italic" },
      functions = { "italic" },
      -- keywords = { "italic" },
      operators = {},
      conditionals = { "italic" },
      loops = { "italic" },
      -- booleans = { "bold", "italic" },
      numbers = {},
      types = { "italic" },
      strings = {},
      variables = {},
    },
    integrations = {
      dashboard = false,
      treesitter = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "bold" },
          hints = { "italic" },
          warnings = { "bold" },
          information = { "italic" },
        },
      },
      notify = true,
      mini = true,
      noice = true,
      coc_nvim = false,
      cmp = vim.g.cmp_enable,
      lsp_saga = true,
      gitsigns = true,
      leap = true,
      telescope = true,
      nvimtree = false,
      markdown = true,
      ts_rainbow = true,
      dap = {
        enabled = true,
        enable_ui = true,
      },
      lsp_trouble = true,
      fidget = true,
      harpoon = true,
      which_key = true,
      vimwiki = true,
    },
    color_overrides = {
      mocha = {
        rosewater = "#F5E0DC",
        flamingo = "#F2CDCD",
        mauve = "#DDB6F2",
        pink = "#F5C2E7",
        red = "#F28FAD",
        maroon = "#E8A2AF",
        peach = "#F8BD96",
        yellow = "#FAE3B0",
        green = "#ABE9B3",
        blue = "#96CDFB",
        sky = "#89DCEB",
        teal = "#B5E8E0",
        lavender = "#C9CBFF",

        text = "#D9E0EE",
        subtext1 = "#BAC2DE",
        subtext0 = "#A6ADC8",
        overlay2 = "#C3BAC6",
        overlay1 = "#988BA2",
        overlay0 = "#6E6C7E",
        surface2 = "#6E6C7E",
        surface1 = "#575268",
        surface0 = "#302D41",

        base = "#1E1E2E",
        mantle = "#1A1826",
        crust = "#161320",
      },
    },
    highlight_overrides = {
      mocha = function(cp)
        return {
          -- For base configs.
          CursorLineNr = { fg = cp.green },
          Search = { bg = cp.surface1, fg = cp.pink, style = { "bold" } },
          IncSearch = { bg = cp.pink, fg = cp.surface1 },

          -- For native lsp configs.
          DiagnosticVirtualTextError = { bg = cp.none },
          DiagnosticVirtualTextWarn = { bg = cp.none },
          DiagnosticVirtualTextInfo = { bg = cp.none },
          DiagnosticVirtualTextHint = { fg = cp.rosewater, bg = cp.none },

          DiagnosticHint = { fg = cp.rosewater },
          LspDiagnosticsDefaultHint = { fg = cp.rosewater },
          LspDiagnosticsHint = { fg = cp.rosewater },
          LspDiagnosticsVirtualTextHint = { fg = cp.rosewater },
          LspDiagnosticsUnderlineHint = { sp = cp.rosewater },

          -- For fidget.
          FidgetTask = { bg = cp.none, fg = cp.surface2 },
          FidgetTitle = { fg = cp.blue, style = { "bold" } },

          -- For treesitter.
          ["@field"] = { fg = cp.rosewater },
          ["@property"] = { fg = cp.yellow },

          ["@include"] = { fg = cp.teal },
          ["@operator"] = { fg = cp.sky },
          ["@keyword.operator"] = { fg = cp.sky },
          ["@punctuation.special"] = { fg = cp.maroon },

          -- ["@float"] = { fg = cp.peach },
          -- ["@number"] = { fg = cp.peach },
          -- ["@boolean"] = { fg = cp.peach },

          ["@constructor"] = { fg = cp.lavender },
          -- ["@constant"] = { fg = cp.peach },
          -- ["@conditional"] = { fg = cp.mauve },
          -- ["@repeat"] = { fg = cp.mauve },
          ["@exception"] = { fg = cp.peach },

          ["@constant.builtin"] = { fg = cp.lavender },
          -- ["@function.builtin"] = { fg = cp.peach, style = { "italic" } },
          -- ["@type.builtin"] = { fg = cp.yellow, style = { "italic" } },
          ["@variable.builtin"] = { fg = cp.red, style = { "italic" } },

          -- ["@function"] = { fg = cp.blue },
          ["@function.macro"] = { fg = cp.red, style = {} },
          ["@parameter"] = { fg = cp.rosewater },
          ["@keyword.function"] = { fg = cp.maroon },
          ["@keyword"] = { fg = cp.red },
          ["@keyword.return"] = { fg = cp.pink, style = {} },

          -- ["@text.note"] = { fg = cp.base, bg = cp.blue },
          -- ["@text.warning"] = { fg = cp.base, bg = cp.yellow },
          -- ["@text.danger"] = { fg = cp.base, bg = cp.red },
          -- ["@constant.macro"] = { fg = cp.mauve },

          -- ["@label"] = { fg = cp.blue },
          ["@method"] = { style = { "italic" } },
          ["@namespace"] = { fg = cp.rosewater, style = {} },

          ["@punctuation.delimiter"] = { fg = cp.teal },
          ["@punctuation.bracket"] = { fg = cp.overlay2 },
          -- ["@string"] = { fg = cp.green },
          -- ["@string.regex"] = { fg = cp.peach },
          -- ["@type"] = { fg = cp.yellow },
          ["@variable"] = { fg = cp.text },
          ["@tag.attribute"] = { fg = cp.mauve, style = { "italic" } },
          ["@tag"] = { fg = cp.peach },
          ["@tag.delimiter"] = { fg = cp.maroon },
          ["@text"] = { fg = cp.text },

          -- ["@text.uri"] = { fg = cp.rosewater, style = { "italic", "underline" } },
          -- ["@text.literal"] = { fg = cp.teal, style = { "italic" } },
          -- ["@text.reference"] = { fg = cp.lavender, style = { "bold" } },
          -- ["@text.title"] = { fg = cp.blue, style = { "bold" } },
          -- ["@text.emphasis"] = { fg = cp.maroon, style = { "italic" } },
          -- ["@text.strong"] = { fg = cp.maroon, style = { "bold" } },
          -- ["@string.escape"] = { fg = cp.pink },

          -- ["@property.toml"] = { fg = cp.blue },
          -- ["@field.yaml"] = { fg = cp.blue },

          -- ["@label.json"] = { fg = cp.blue },

          ["@function.builtin.bash"] = { fg = cp.red, style = { "italic" } },
          ["@parameter.bash"] = { fg = cp.yellow, style = { "italic" } },

          ["@field.lua"] = { fg = cp.lavender },
          ["@constructor.lua"] = { fg = cp.flamingo },

          ["@constant.java"] = { fg = cp.teal },

          ["@property.typescript"] = { fg = cp.lavender, style = { "italic" } },
          -- ["@constructor.typescript"] = { fg = cp.lavender },

          -- ["@constructor.tsx"] = { fg = cp.lavender },
          -- ["@tag.attribute.tsx"] = { fg = cp.mauve },

          ["@type.css"] = { fg = cp.lavender },
          ["@property.css"] = { fg = cp.yellow, style = { "italic" } },

          ["@property.cpp"] = { fg = cp.text },

          -- ["@symbol"] = { fg = cp.flamingo },
        }
      end,
    },
  }
  vim.cmd [[colorscheme catppuccin]]
  SetStyle()
end

return M
