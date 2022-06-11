local utils = require "utils"
local M = {}

-- local function keymap(lhs, rhs, desc)
--   vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
-- end

function M.setup()
  local keymap = {
    R = require 'dap'.run_to_cursor,
    E = function() require 'dapui'.eval(vim.fn.input '[Expression] > ') end,
    C = function() require 'dap'.set_breakpoint(vim.fn.input '[Condition] > ') end,
    U = require 'dapui'.toggle,
    b = require 'dap'.step_back,
    c = require 'dap'.continue,
    D = require 'dap'.disconnect,
    e = require 'dapui'.eval,
    g = require 'dap'.session,
    -- h = require 'dap.ui.widgets'.hover,
    -- S = require 'dap.ui.widgets'.scopes,
    i = require 'dap'.step_into,
    o = require 'dap'.step_over,
    -- p = require 'dap'.pause.toggle,
    q = require 'dap'.close,
    r = require 'dap'.repl.toggle,
    s = require 'dap'.continue,
    t = require 'dap'.toggle_breakpoint,
    x = require 'dap'.terminate,
    u = require 'dap'.step_out,
  }

  for k, v in pairs(keymap) do
    utils.map("n", "<Leader>d%" .. k, v)
  end
  utils.map("v", "<Leader>de", require 'dapui'.eval)
end

return M
