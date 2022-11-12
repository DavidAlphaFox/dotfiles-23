local utils = require "utils"
local M = {}

M.setup = function()
  local betterTerm = require('betterTerm')
  betterTerm.setup()
  utils.map("n", "<leader>e", function()
    betterTerm.send(require("code_runner.commands").get_filetype_command(), 2, true)
  end, { desc = "Excute File" })

  utils.map({ "n", "t" }, "<C-ñ>", betterTerm.open, { desc = "Open terminal" })
  utils.map({ "n", "t" }, "<leader>tt", betterTerm.select, { desc = "Select terminal" })
  local current = 2
  utils.map(
    { "n", "t" }, "<leader>ti",
    function()
      betterTerm.open(current)
      current = current + 1
    end,
    { desc = "New terminal" }
  )
end
return M
