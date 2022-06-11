local M = {}

-- Debugger installation location
local HOME = os.getenv "HOME"
function M.setup()
  local dap = require "dap"

  -- Adapter configuration
  dap.adapters.coreclr = {
    type = "executable",
    command = "/bin/netcoredbg",
    args = { "--interpreter=vscode" },
  }

  -- Configuration
  dap.configurations.cs = {
    {
      type = "coreclr",
      name = "launch - netcoredbg",
      request = "launch",
      program = function()
        return vim.fn.input("Path to DLL > ", vim.fn.getcwd() .. "/bin/Debug/", "file")
      end,
    },
  }
end

return M
