local utils = require('utils')

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
            "--smart-case"
        },
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = "  ",
        initial_mode = "normal",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "bottom_pane",
        layout_config={
            horizontal = {
                mirror = false,
                height = 0.70,
                width = 0.70,
                preview_width = 0.6
            },
            vertical = {
                mirror = false
            },
        },
        file_sorter =  require'telescope.sorters'.get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter =  require'telescope.sorters'.get_fzy_sorter,
        path_display = { "smart", },
        winblend = 0,
        border = false,
        results_title = '',
        preview_title = '',
        color_devicons = true,
        use_less = true,
        set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
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
            }
        },
    },
    -- pickers = {
    --     find_files = {
    --       theme = "ivy",
    --     }
    -- },
    extensions = {
        media_files = {
            filetypes = {"png", "webp", "jpg", "jpeg"},
            find_cmd = "rg" -- find command (defaults to `fd`)
        },
        file_browser = {
            theme = "ivy",
        }
    }
}

require("telescope").load_extension("media_files")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("frecency")

-- mappings
utils.map(
    "n",
    "<leader>fm",
    [[<Cmd>lua require('telescope').extensions.media_files.media_files()<CR>]])

-- File Pickers
utils.map('n', ' ñ' , [[<cmd>lua require 'telescope'.extensions.file_browser.file_browser()<CR>]])
utils.map('n', 'ñf', [[<cmd>lua require('telescope.builtin').find_files()<CR>]])
utils.map("n", "ño", [[<Cmd>lua require('telescope.builtin').oldfiles()<CR>]])
utils.map("n", " m", [[<Cmd>lua require('telescope.builtin').marks()<CR>]])

-- Search
utils.map("n", ",f", "<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>")
utils.map('n', '<leader>fg', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]])
utils.map('n', '<leader>fl', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]])
utils.map('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').search_history()<CR>]])
utils.map('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]])
utils.map('n', '<leader>ch', [[<cmd>lua require('telescope.builtin').command_history()<CR>]])

-- Vim Pickers
utils.map("n", "ñb", [[<Cmd>lua require('telescope.builtin').buffers()<CR>]])
utils.map('n', '<leader>fc', [[<cmd>lua require('telescope.builtin').commands()<CR>]])
utils.map('n', '<leader>fs', [[<cmd>lua require('telescope.builtin').colorscheme()<CR>]])
utils.map('n', '<leader>fk', [[<cmd>lua require('telescope.builtin').keymaps()<CR>]])
utils.map('n', '<leader>ft', [[<cmd>lua require('telescope.builtin').filetypes()<CR>]])
utils.map('n', '<leader>ss', [[<cmd>lua require('telescope.builtin').spell_suggest()<CR>]])
-- utils.map("n", "<Leader>ft", [[<Cmd>lua require('telescope.builtin').help_tags()<CR>]])
-- utils.map('n', '<leader>bt', [[<cmd>lua require('telescope.builtin').current_buffer_tags()<CR>]])

-- LSP Pickers
utils.map('n', '<leader>lr', [[<cmd>lua require('telescope.builtin').lsp_references()<CR>]])
utils.map('n', '<leader>ls', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]])
utils.map('n', '<leader>la', [[<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>]])
-- utils.map('n', '<leader>fd', [[<cmd>lua require('telescope.builtin').lsp_definitions()<CR>]])
utils.map('n', '<leader>ld', [[<cmd>lua require('telescope.builtin').diagnostics()<CR>]])
utils.map('n', '<leader>li', [[<cmd>lua require('telescope.builtin').lsp_implementations()<CR>]])

-- Git Pickers
utils.map('n', 'ññ', [[<cmd>lua require('telescope.builtin').git_files()<CR>]])
utils.map('n', '<leader>gc', [[<cmd>lua require('telescope.builtin').git_commits()<CR>]])
utils.map('n', '<leader>gbc', [[<cmd>lua require('telescope.builtin').git_bcommits()<CR>]])
utils.map('n', '<leader>gb', [[<cmd>lua require('telescope.builtin').git_branches()<CR>]])
utils.map('n', '<leader>gs',  [[<Cmd>lua require('telescope.builtin').git_status()<CR>]])
