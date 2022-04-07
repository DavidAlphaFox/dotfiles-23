local utils = require "utils"

local M = {}
function M.setup()
  local actions = require "telescope.actions"
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
      layout_strategy = "bottom_pane",
      -- layout_strategy = "horizontal",
      layout_config = {
        bottom_pane = {
          prompt_position = "top",
        },
      },
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      file_ignore_patterns = { "__pycache__", "node_modules" },
      path_display = { "smart" },
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      results_title = "~ Results ~",
      color_devicons = true,
      use_less = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      preview_title = "",
      mappings = {
        i = {
          ["<CR>"] = actions.select_tab,
          ["<C-l>"] = actions.select_default,
        },
        n = {
          ["<CR>"] = actions.select_tab,
          ["l"] = actions.select_default,
        },
      },
    },
    pickers = {
      find_files = {
        find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
      },
    },
    extensions = {
      media_files = {
        filetypes = { "png", "webp", "jpg", "jpeg" },
        find_cmd = "rg", -- find command (defaults to `fd`)
      },
      file_browser = {
        theme = "ivy",
      },
    },
  }

  -- require("telescope").load_extension "themes"
  require("telescope").load_extension "media_files"
  require("telescope").load_extension "file_browser"
  require("telescope").load_extension "frecency"

  -- Extensions
  local extensions = require("telescope").extensions
  utils.map("n", "<leader>fm", extensions.media_files.media_files)
  utils.map("n", "ñe", extensions.file_browser.file_browser)
  utils.map("n", "ñf", extensions.frecency.frecency)

  local builtin = require "telescope.builtin"

  -- File Pickers
  local project_files = function()
    local opts = {} -- define here if you want to define something
    local ok = pcall(builtin.git_files, opts)
    if not ok then
      builtin.find_files(opts)
    end
  end
  utils.map("n", " ñ", project_files)
  utils.map("n", "<leader>fg", builtin.grep_string)
  utils.map("n", "<leader>fl", builtin.live_grep)

  -- Vim Pickers
  utils.map("n", "ñb", builtin.buffers)
  utils.map("n", "ño", builtin.oldfiles)
  utils.map("n", "<leader>fc", builtin.commands)
  utils.map("n", "<leader>ch", builtin.command_history)
  utils.map("n", "<leader>sh", builtin.search_history)
  -- utils.map("n", "<Leader>ft", require('telescope.builtin').help_tags)
  utils.map("n", "<leader>m", builtin.marks)
  utils.map("n", "<leader>fs", builtin.colorscheme)
  utils.map("n", "<leader>ss", builtin.spell_suggest)
  utils.map("n", "<leader>fk", builtin.keymaps)
  utils.map("n", "<leader>ft", builtin.filetypes)
  utils.map("n", "<leader>ff", builtin.current_buffer_fuzzy_find)
  -- utils.map('n', '<leader>bt', require('telescope.builtin').current_buffer_tags)

  -- LSP Pickers
  utils.map("n", "<leader>lr", builtin.lsp_references)
  utils.map("n", "<leader>ls", builtin.lsp_document_symbols)
  utils.map("n", "<leader>la", builtin.lsp_code_actions)
  -- utils.map('n', '<leader>fd', require('telescope.builtin').lsp_definitions)
  utils.map("n", "<leader>ld", builtin.diagnostics)
  utils.map("n", "<leader>li", builtin.lsp_implementations)

  -- Git Pickers
  utils.map("n", "<leader>gc", builtin.git_commits)
  utils.map("n", "<leader>gbc", builtin.git_bcommits)
  utils.map("n", "<leader>gb", builtin.git_branches)
  utils.map("n", "<leader>gs", builtin.git_status)
  utils.map("n", "<leader>gt", builtin.git_stash)
end
return M
