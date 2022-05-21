require('telescope').load_extension('dap')
require('debug.python')
require('debug.typescript')

local utils = require('utils')

utils.map('n', '<leader>dc', require "dap".continue)
utils.map('n', '<leader>dsv', require "dap".step_over)
utils.map('n', '<leader>dsi', require "dap".step_into)
utils.map('n', '<leader>dso', require "dap".step_out)
utils.map('n', '<leader>dtb', require "dap".toggle_breakpoint)
utils.map('n', '<leader>dsbr', function() require "dap".set_breakpoint(vim.fn.input("Breakpoint condition: ")) end)
utils.map('n', '<leader>dsbm', function() require "dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end)
utils.map('n', '<leader>dro', require "dap".repl.open)
utils.map('n', '<leader>drl', require "dap".repl.run_last)

-- telescope-dap
utils.map('n', '<leader>dcc', require "telescope".extensions.dap.commands)
utils.map('n', '<leader>dco', require "telescope".extensions.dap.configurations)
utils.map('n', '<leader>dlb', require "telescope".extensions.dap.list_breakpoints)
utils.map('n', '<leader>dv', require "telescope".extensions.dap.variables)
utils.map('n', '<leader>df', require "telescope".extensions.dap.frames)
