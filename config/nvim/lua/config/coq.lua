local M = {}

function M.setup()
  vim.g.coq_settings = {
    keymap = {
      recommended = true,
      jump_to_mark = "<C-l>",
    },
    clients = {
      tabnine = {
        enabled = true,
        weight_adjust = 1.9
      },
      snippets = {
        enabled = true,
        weight_adjust = 1.8
      },
      lsp = {
        enabled = true,
        resolve_timeout = 0.04,
        weight_adjust = 1.7
      },
      tree_sitter = {
        enabled = true,
        weight_adjust = 1.6
      },
      paths = {
        path_seps = {
          "/"
        }
      },
      buffers = {
        match_syms = true,
        weight_adjust = - 1.9
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

  local coq = require "coq"
  coq.Now() -- Start coq

  -- 3party sources
  require "coq_3p" {
    { src = "nvimlua", short_name = "nLUA", conf_only = true },
    { src = "bc", short_name = "MATH", precision = 6 },
    { src = "figlet", trigger = "!big" }, -- figlet command
    -- { src = "copilot", short_name = "COP", accept_key = "<c-f>" },
    -- {
    --   src = "repl",
    --   sh = "zsh",
    --   shell = { p = "perl", n = "node" },
    --   max_lines = 99,
    --   deadline = 500,
    --   unsafe = { "rm", "poweroff", "mv" },
    -- },
  }
end

return M
