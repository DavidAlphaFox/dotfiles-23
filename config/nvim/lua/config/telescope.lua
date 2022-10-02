local utils = require "utils"
local M = {}
function M.setup()
  local actions = require "telescope.actions"
  local mappings = {
    i = {
      ["<CR>"] = actions.select_tab,
      ["<C-l>"] = actions.select_default,
    },
    n = {
      ["<CR>"] = actions.select_tab,
      ["l"] = actions.select_default,
    },
  }
  require("telescope").setup {
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--trim", -- add this value
      },
      prompt_prefix = "  ",
      selection_caret = " ",
      initial_mode = "normal",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      -- layout_strategy = "bottom_pane",
      layout_strategy = "horizontal",
      layout_config = {
        bottom_pane = {
          prompt_position = "top",
          preview_cutoff = 0,
        },
        horizontal = {
          prompt_position = "top",
          preview_cutoff = 0,
        },
      },
      -- file_sorter = require("telescope.sorters").get_fuzzy_file,
      -- file_sorter = require("telescope.sorters").get_fzy_file,
      file_ignore_patterns = { "__pycache__", "node_modules" },
      path_display = { "shorten" },
      winblend = 0,
      border = {},
      -- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
      results_title = "Results",
      color_devicons = true,
      use_less = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    },
    pickers = {
      find_files = {
        find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
        mappings = mappings
      },
      git_files = {
        mappings = mappings
      },
      oldfiles = {
        mappings = mappings
      },
      live_grep = {
        mappings = mappings
      },
      grep_string = {
        mappings = mappings
      },
    },
    extensions = {
      media_files = {
        filetypes = { "png", "webp", "jpg", "jpeg" },
        find_cmd = "rg", -- find command (defaults to `fd`)
      },
      file_browser = {
        hijack_netrw = true,
        mappings = mappings
      },
      frecency = {
        mappings = mappings,
        show_unindexed = false,
        ignore_patterns = {"*.git/*", "*/tmp/*"},
        workspaces = {
          ["dotfiles"]    = "~/Git/dotfiles",
        }
      },
      tele_tabby = {
        use_highlighter = true,
      }
    },
  }

  local extensions = {"frecency", "zf-native", "dap", "media_files", "file_browser", "tele_tabby"}
  for _, extension in ipairs(extensions) do
    require("telescope").load_extension(extension)
  end

  local builtin = require "telescope.builtin"
  utils.map("n", "<leader>fb", builtin.builtin)
  -- Most used
  local ext = require("telescope").extensions
  utils.map("n", "ñe", ext.file_browser.file_browser)
  utils.map("n", "ñf", ext.frecency.frecency)
  utils.map("n", "ñb", builtin.buffers)
  utils.map("n", "ño", builtin.oldfiles)
  utils.map("n", "ñt", builtin.treesitter)

  -- File Pickers
  local project_files = function()
    local opts = {} -- define here if you want to define something
    local ok = pcall(builtin.git_files, opts)
    if not ok then
      builtin.find_files(opts)
    end
  end
  utils.map("n", "ññ", project_files)
  utils.map("n", "<leader>fm", ext.media_files.media_files)
  utils.map("n", "<leader>gg", ext.tele_tabby.list)

  local cwd_conf = {
    cwd = vim.fs.dirname(vim.fs.find({'.git'}, { upward = true })[1])
  }
  utils.map("n", "<leader>fg", function() builtin.grep_string(cwd_conf) end)
  utils.map("n", "<leader>fl", function() builtin.live_grep(cwd_conf) end)

  -- Vim Pickers
  utils.map("n", "<leader>fcc", builtin.commands)
  utils.map("n", "<leader>fch", builtin.command_history)
  utils.map("n", "<leader>fsh", builtin.search_history)
  -- utils.map("n", "<Leader>ft", require('telescope.builtin').help_tags)
  utils.map("n", "<leader>m", builtin.marks)
  utils.map("n", "<leader>fc", builtin.colorscheme)
  utils.map("n", "<leader>ss", builtin.spell_suggest)
  utils.map("n", "<leader>fk", builtin.keymaps)
  utils.map("n", "<leader>ft", builtin.filetypes)
  utils.map("n", "<leader>ff", builtin.current_buffer_fuzzy_find)
  utils.map('n', '<leader>bt', builtin.current_buffer_tags)

  -- -- LSP Pickers
  utils.map("n", "<leader>fr", builtin.lsp_references)
  utils.map("n", "<leader>fs", builtin.lsp_document_symbols)
  -- utils.map('n', '<leader>fd', builtin.lsp_definitions)
  utils.map("n", "<leader>fd", builtin.diagnostics)
  utils.map("n", "<leader>fi", builtin.lsp_implementations)
  --
  -- Git Pickers
  -- utils.map("n", "<leader>gc", builtin.git_commits)
  utils.map("n", "<leader>gc", builtin.git_bcommits)
  utils.map("n", "<leader>gb", builtin.git_branches)
  utils.map("n", "<leader>gs", builtin.git_status)
  utils.map("n", "<leader>gt", builtin.git_stash)
end

return M
