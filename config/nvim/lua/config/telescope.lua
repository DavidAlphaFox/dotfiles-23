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
      },
      prompt_prefix = "  ",
      selection_caret = " ",
      entry_prefix = "  ",
      initial_mode = "normal",
      selection_strategy = "reset",
      sorting_strategy = "descending",
      layout_strategy = "bottom_pane",
      -- layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          mirror = false,
          height = 0.70,
          width = 0.70,
          preview_width = 0.6,
        },
        vertical = {
          mirror = false,
        },
      },
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      file_ignore_patterns = { "__pycache__", "node_modules" },
      generic_sorter = require("telescope.sorters").get_fzy_sorter,
      path_display = { "smart" },
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      results_title = "~ Results ~",
      preview_title = "",
      color_devicons = true,
      use_less = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
      mappings = {
        i = {
          ["<CR>"] = actions.select_tab,
          ["<C-l>"] = actions.select_default,
          ["<C-h>"] = actions.select_horizontal,
        },
        n = {
          ["<CR>"] = actions.select_tab,
          ["l"] = actions.select_default,
          ["<C-h>"] = actions.select_horizontal,
        },
      },
    },
    -- pickers = {
    --     find_files = {
    --       theme = "ivy",
    --     }
    -- },
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

  require("telescope").load_extension "themes"
  require("telescope").load_extension "frecency"
  require("telescope").load_extension "media_files"
  require("telescope").load_extension "file_browser"
  require("telescope").load_extension "frecency"

  -- mappings
  utils.map("n", "<leader>fm", require("telescope").extensions.media_files.media_files)

  -- File Pickers
  utils.map("n", "ñe", require("telescope").extensions.file_browser.file_browser)
  utils.map("n", "ñf", require("telescope.builtin").find_files)
  utils.map("n", "ño", require("telescope.builtin").oldfiles)
  utils.map("n", " m", require("telescope.builtin").marks)

  -- Search
  utils.map("n", ",f", "<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>")
  utils.map("n", "<leader>fg", require("telescope.builtin").grep_string)
  utils.map("n", "<leader>fl", require("telescope.builtin").live_grep)
  utils.map("n", "<leader>sh", require("telescope.builtin").search_history)
  utils.map("n", "<leader>ff", require("telescope.builtin").current_buffer_fuzzy_find)
  utils.map("n", "<leader>ch", require("telescope.builtin").command_history)

  -- Vim Pickers
  utils.map("n", "ñb", require("telescope.builtin").buffers)
  utils.map("n", "<leader>fc", require("telescope.builtin").commands)
  utils.map("n", "<leader>fs", require("telescope.builtin").colorscheme)
  utils.map("n", "<leader>fk", require("telescope.builtin").keymaps)
  utils.map("n", "<leader>ft", require("telescope.builtin").filetypes)
  utils.map("n", "<leader>ss", require("telescope.builtin").spell_suggest)
  -- utils.map("n", "<Leader>ft", require('telescope.builtin').help_tags)
  -- utils.map('n', '<leader>bt', require('telescope.builtin').current_buffer_tags)

  -- LSP Pickers
  utils.map("n", "<leader>lr", require("telescope.builtin").lsp_references)
  utils.map("n", "<leader>ls", require("telescope.builtin").lsp_document_symbols)
  utils.map("n", "<leader>la", require("telescope.builtin").lsp_code_actions)
  -- utils.map('n', '<leader>fd', require('telescope.builtin').lsp_definitions)
  utils.map("n", "<leader>ld", require("telescope.builtin").diagnostics)
  utils.map("n", "<leader>li", require("telescope.builtin").lsp_implementations)

  -- Git Pickers
  utils.map("n", "ññ", require("telescope.builtin").git_files)
  utils.map("n", "<leader>gc", require("telescope.builtin").git_commits)
  utils.map("n", "<leader>gbc", require("telescope.builtin").git_bcommits)
  utils.map("n", "<leader>gb", require("telescope.builtin").git_branches)
end
return M
