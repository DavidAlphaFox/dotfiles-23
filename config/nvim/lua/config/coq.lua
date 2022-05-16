local M = {}

vim.g.coq_settings = {
  keymap = {
    -- recommended = false,
    jump_to_mark = "<C-,>",
  },
  clients = {
    tabnine = {
      enabled = true,
    },
    paths = {
      path_seps = {
        "/"
      }
    },
    buffers = {
      match_syms = true
    }
  },
  display = {
    icons = {
      mode = "short",
    },
    ghost_text = {
      enabled = true
    }
  },
}

function M.setup()
  local coq = require "coq"
  coq.Now() -- Start coq

  -- 3party sources
  require "coq_3p" {
    { src = "nvimlua", short_name = "nLUA", conf_only = true },
    { src = "bc", short_name = "MATH", precision = 6 },
    { src = "figlet", trigger = "!big" }, -- figlet command
    -- { src = "copilot", short_name = "COP", accept_key = "<c-f>" },
    {
      src = "repl",
      sh = "zsh",
      shell = { p = "perl", n = "node" },
      max_lines = 99,
      deadline = 500,
      unsafe = { "rm", "poweroff", "mv" },
    },
  }
end

return M
