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
      selection_caret = "» ",
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
    },
  }

  local extensions = {"frecency", "zf-native", "dap", "media_files", "file_browser"}
  for _, extension in ipairs(extensions) do
    require("telescope").load_extension(extension)
  end

  local builtin = require "telescope.builtin"
  local ext = require("telescope").extensions

  -- File Pickers
  local project_files = function()
    local opts = {} -- define here if you want to define something
    local ok = pcall(builtin.git_files, opts)
    if not ok then
      builtin.find_files(opts)
    end
  end

  local cwd_conf = {
    cwd = vim.fs.dirname(vim.fs.find({'.git'}, { upward = true })[1])
  }

  local maps = {
    {
      prefix = "ñ",
      maps = {
        {"e", ext.file_browser.file_browser, "File Browser" },
        {"f", ext.frecency.frecency, "Frequent Files" },
        {"l", builtin.buffers, "List Buffers" },
        {"o", builtin.oldfiles, "Old Files" },
        {"t", builtin.treesitter, "TreeSitter Symbols" },
        {"ñ", project_files, "Project Files"}
      }
    },
    {
      prefix = "<leader>f",
      maps = {
        {"b", builtin.builtin, "Telescope Builtin"},
        {"ñ", require('telescope-tabs').list_tabs, "List Tabs"},
        {"m", ext.media_files.media_files, "Media Files"},
        {"g", function() builtin.grep_string(cwd_conf) end, "Find Grep"},
        {"l", function() builtin.live_grep(cwd_conf) end, "Find Live Grep"},
        {"h", builtin.search_history, "Search History"},
        {"cc", builtin.colorscheme, "Select Colorscheme"},
        {"cs", builtin.commands, "Search Commands"},
        {"ch", builtin.command_history, "Search Commands History"},
        {"k", builtin.keymaps, "Show All Keymaps"},
        {"t", builtin.filetypes, "Select Filetype"},
        {"f", builtin.current_buffer_fuzzy_find, "Buffer Fuzzy Find"},
        {"r", builtin.lsp_references, "LSP References"},
        {"s", builtin.lsp_document_symbols, "LSP Symbols"},
        {"i", builtin.lsp_implementations, "LSP Implementations"},
        {"d", builtin.diagnostics, "LSP diagnostics"},
      },
    },
    {
      prefix = "<leader>g",
      maps = {
        {"c", builtin.git_bcommits, "Git Buffer commits"},
        {"b", builtin.git_branches, "Git Branches"},
        {"s", builtin.git_status, "Git Status"},
        {"t", builtin.git_stash, "Git Stash"},
      },
    },
  }

  utils.maps(maps)
  -- utils.map("n", "<Leader>ft", require('telescope.builtin').help_tags)
  utils.map("n", "<leader>m", builtin.marks, { desc = "Show Marks" })
  utils.map("n", "<leader>ss", builtin.spell_suggest, { desc = "Spell Suggest" })
  -- utils.map('n', '<leader>bt', builtin.current_buffer_tags, { desc = "Buffer Tags" })

  -- -- LSP Pickers
  -- utils.map('n', '<leader>fd', builtin.lsp_definitions)
  --
  -- Git Pickers
  -- utils.map("n", "<leader>gc", builtin.git_commits)
end

return M
