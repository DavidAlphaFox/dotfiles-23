local M = {}

function M.setup()
  vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
  vim.g.coq_settings = {
    keymap = {
      recommended = false,
      -- recommended = true,
      jump_to_mark = "<C-l>",
    },
    clients = {
      lsp = {
        enabled = true,
        -- resolve_timeout = 0.04,
        -- always_on_top = {}
        weight_adjust = 1.1
      },
      tabnine = {
        enabled = true,
        weight_adjust = 1.2
        -- always_on_top = true
      },
      snippets = {
        enabled = true,
        -- weight_adjust = 1.3
        always_on_top = true
      },
      tree_sitter = {
        enabled = true,
        weight_adjust = 1.3
        -- always_on_top = true
      },
      -- paths = {
      --   path_seps = {
      --     "/"
      --   }
      -- },
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
        enabled = false
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
