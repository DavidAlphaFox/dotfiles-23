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
      -- initial_mode = "normal",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "bottom_pane",
      layout_config = {
        bottom_pane = {
          prompt_position = "top",
        },
        horizontal = {
          prompt_position = "top",
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
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
      media_files = {
        filetypes = { "png", "webp", "jpg", "jpeg" },
        find_cmd = "rg", -- find command (defaults to `fd`)
      },
      file_browser = {
        hijack_netrw = true,
        mappings = mappings
      },
      frecency = {
        mappings = mappings
      },
    },
  }

  local extensions = {"fzy_native" , "dap","media_files", "file_browser", "frecency", "themes", "tele_tabby"}
  for _, extension in ipairs(extensions) do
    require("telescope").load_extension(extension)
  end

  -- Extensions
  local ext = require("telescope").extensions
  utils.map("n", "<leader>fm", ext.media_files.media_files)
  utils.map("n", "ñe", ext.file_browser.file_browser)
  utils.map("n", "ñf", ext.frecency.frecency)
  utils.map("n", "<leader>w", ext.tele_tabby.list)

  local builtin = require "telescope.builtin"

  -- File Pickers
  local project_files = function()
    local opts = {} -- define here if you want to define something
    local ok = pcall(builtin.git_files, opts)
    if not ok then
      builtin.find_files(opts)
    end
  end
  utils.map("n", "ññ", project_files)
  utils.map("n", "<leader>fg", builtin.grep_string)
  utils.map("n", "<leader>gg", builtin.live_grep)

  -- Vim Pickers
  utils.map("n", "ñb", builtin.buffers)
  utils.map("n", "ño", builtin.oldfiles)
  utils.map("n", "<leader>cc", builtin.commands)
  utils.map("n", "<leader>ch", builtin.command_history)
  utils.map("n", "<leader>sh", builtin.search_history)
  -- utils.map("n", "<Leader>ft", require('telescope.builtin').help_tags)
  utils.map("n", "<leader>m", builtin.marks)
  utils.map("n", "<leader>fs", builtin.colorscheme)
  utils.map("n", "<leader>ss", builtin.spell_suggest)
  utils.map("n", "<leader>fk", builtin.keymaps)
  utils.map("n", "<leader>ft", builtin.filetypes)
  utils.map("n", "<leader>ff", builtin.current_buffer_fuzzy_find)
  utils.map('n', '<leader>bt', builtin.current_buffer_tags)

  -- -- LSP Pickers
  utils.map("n", "<leader>lr", builtin.lsp_references)
  utils.map("n", "ñu", builtin.lsp_document_symbols)
  utils.map('n', '<leader>lf', builtin.lsp_definitions)
  utils.map("n", "<leader>ld", builtin.diagnostics)
  utils.map("n", "ñi", builtin.lsp_implementations)
  --
  -- Git Pickers
  -- utils.map("n", "<leader>gc", builtin.git_commits)
  utils.map("n", "<leader>gc", builtin.git_bcommits)
  utils.map("n", "<leader>gb", builtin.git_branches)
  utils.map("n", "<leader>gs", builtin.git_status)
  utils.map("n", "<leader>gt", builtin.git_stash)
  utils.map("n", "ñt", builtin.treesitter)
  utils.map("n", "ñp", builtin.builtin)
end

return M
