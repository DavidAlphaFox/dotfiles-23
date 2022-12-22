local M = {}

local function db_completion()
  require("cmp").setup.buffer { sources = { { name = "vim-dadbod-completion" } } }
end

local function UI()
  vim.g.db_ui_use_nerd_fonts = 1
  vim.g.db_ui_show_database_icon = 1
  vim.g.db_ui_force_echo_notifications = 1
  vim.g.db_ui_win_position = "right"
  vim.g.db_ui_winwidth = 80

  vim.g.db_ui_table_helpers = {
    mysql = {
      Count = "select count(1) from {optional_schema}{table}",
      Explain = "EXPLAIN {last_query}",
    },
    sqlite = {
      Describe = "PRAGMA table_info({table})",
    },
  }

  vim.g.db_ui_icons = {
    expanded = {
      db = "▾ ",
      buffers = "▾ ",
      saved_queries = "▾ ",
      schemas = "▾ ",
      schema = "▾ פּ",
      tables = "▾ 藺",
      table = "▾ ",
    },
    collapsed = {
      db = "▸ ",
      buffers = "▸ ",
      saved_queries = "▸ ",
      schemas = "▸ ",
      schema = "▸ פּ",
      tables = "▸ 藺",
      table = "▸ ",
    },
    saved_query = "",
    new_query = "璘",
    tables = "離",
    buffers = "﬘",
    add_connection = "",
    connection_ok = "✓",
    connection_error = "✕",
  }
end

function M.setup()
  vim.g.db_ui_save_location = vim.fn.stdpath "config" .. require("plenary.path").path.sep .. "db_ui"

  vim.api.nvim_create_autocmd("FileType", {
    pattern = {
      "sql",
    },
    command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = {
      "sql",
      "mysql",
      "plsql",
    },
    callback = function()
      vim.schedule(db_completion)
    end,
  })
  UI()
end

return M
