local M = {}

function M.setup()
  vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
  vim.g.coq_settings = {
    keymap = {
      -- recommended = true,
      jump_to_mark = "<C-l>",
      -- jump_to_mark = "",
    },
    clients = {
      tabnine = {
        enabled = true,
        -- weight_adjust = 1.3
        always_on_top = true
      },
      lsp = {
        enabled = true,
        -- resolve_timeout = 0.04,
        weight_adjust = 1.3
      },
      snippets = {
        enabled = true,
        weight_adjust = 1.2
      },
      tree_sitter = {
        enabled = false,
        -- weight_adjust = 1.7
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
  -- local t = function(str)
  --     return vim.api.nvim_replace_termcodes(str, true, true, true)
  -- end
  --
  -- _G.tab_complete = function()
  --     if vim.fn.pumvisible() == 1 then
  --         return t "<C-n>"
  --     elseif _G.COQmarks_available() == true then
  --         return t "<C-h>"
  --     else
  --         return t "<Tab>"
  --     end
  -- end
  --
  -- vim.api.nvim_set_keymap("n", "<Tab>", "v:lua.tab_complete()", {expr = true})
  -- vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
  -- vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
end

return M
