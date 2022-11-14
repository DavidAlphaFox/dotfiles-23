local utils = require "utils"
local M = {}

function M.setup()
  require("harpoon").setup {
    global_settings = {
      save_on_toggle = true,
      enter_on_sendcmd = true,
    }
  }
  local ui = require("harpoon.ui")
  local term = require("harpoon.term")

  local maps = {
    { "m", require("harpoon.mark").add_file, "Mark File" },
    { "g", ui.toggle_quick_menu, "Show Files Marked" },
    { "w", ui.nav_next, "Next File Marked" },
    { "b", ui.nav_prev, "Prev File Marked" },
    {
      ".",
      function()
        term.sendCommand(10, vim.api.nvim_replace_termcodes('<C-c> <C-l>', true, true, true))
        vim.loop.sleep(100)
        term.sendCommand(10, require("code_runner.commands").get_filetype_command() .. "\n")
      end,
      "CodeRunner in Harpoon Term"
    },

    {
      " ",
      function()
        term.gotoTerminal(10)
      end,
      "Goto Buffer Term"
    },
  }
  utils.pmaps('ñ', maps)
end

return M
