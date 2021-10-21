local utils = require('utils')

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
        layout_strategy = "horizontal",
        layout_config={
            horizontal = {
                mirror = false,
            },
            vertical = {
                mirror = false
            },
            height = 0.50,
            width = 0.70,
        },
        file_sorter =  require'telescope.sorters'.get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
        -- path_display = {
            -- "tail",
            -- "absolute",
        -- },
        winblend = 0,
        border = {},
        results_title = '',
        preview_title = '',
        borderchars = {
            prompt = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' };
            results = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' };
            preview = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' };
        },
        color_devicons = true,
        use_less = true,
        set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
    },
    extensions = {
        media_files = {
            filetypes = {"png", "webp", "jpg", "jpeg"},
            find_cmd = "rg" -- find command (defaults to `fd`)
        }
    }
}

require("telescope").load_extension("media_files")

-- mappings
utils.map(
    "n",
    "<leader>fm",
    [[<Cmd>lua require('telescope').extensions.media_files.media_files()<CR>]])

-- File Pickers
utils.map('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files()<CR>]])
utils.map('n', '<leader>fb' , [[<cmd>lua require('telescope.builtin').file_browser()<CR>]])
utils.map('n', '<leader>fs', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]])
utils.map('n', '<leader>fl', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]])

-- Vim Pickers
utils.map("n", "<Leader>b", [[<Cmd>lua require('telescope.builtin').buffers()<CR>]])
utils.map("n", "<Leader>fo", [[<Cmd>lua require('telescope.builtin').oldfiles()<CR>]])
utils.map('n', '<leader>fc', [[<cmd>lua require('telescope.builtin').commands()<CR>]])
-- utils.map("n", "<Leader>ft", [[<Cmd>lua require('telescope.builtin').help_tags()<CR>]])
utils.map('n', '<leader>fh', [[<cmd>lua require('telescope.builtin').command_history()<CR>]])
utils.map('n', '<leader>ft', [[<cmd>lua require('telescope.builtin').colorscheme()<CR>]])
utils.map('n', '<leader>fk', [[<cmd>lua require('telescope.builtin').keymaps()<CR>]])
utils.map('n', '<leader>fy', [[<cmd>lua require('telescope.builtin').filetypes()<CR>]])
-- utils.map('n', '<leader>bt', [[<cmd>lua require('telescope.builtin').current_buffer_tags()<CR>]])

-- LSP Pickers
utils.map('n', '<leader>fr', [[<cmd>lua require('telescope.builtin').lsp_references()<CR>]])
utils.map('n', '<leader>fds', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]])
utils.map('n', '<leader>fa', [[<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>]])
-- utils.map('n', '<leader>fd', [[<cmd>lua require('telescope.builtin').lsp_definitions()<CR>]])
utils.map('n', '<leader>fd', [[<cmd>lua require('telescope.builtin').lsp_document_diagnostics()<CR>]])
utils.map('n', '<leader>fwd', [[<cmd>lua require('telescope.builtin').lsp_document_diagnostics()<CR>]])

-- Git Pickers
utils.map('n', '<leader>gf', [[<cmd>lua require('telescope.builtin').git_files()<CR>]])
utils.map('n', '<leader>gc', [[<cmd>lua require('telescope.builtin').git_commits()<CR>]])
utils.map('n', '<leader>gbc', [[<cmd>lua require('telescope.builtin').git_bcommits()<CR>]])
utils.map('n', '<leader>gb', [[<cmd>lua require('telescope.builtin').git_branches()<CR>]])
utils.map('n', '<leader>gs',  [[<Cmd>lua require('telescope.builtin').git_status()<CR>]])


-- highlights
local cmd = vim.cmd
cmd "hi TelescopeBorder   guifg=#111416"
cmd "hi TelescopePromptBorder   guifg=#111416"
cmd "hi TelescopeResultsBorder  guifg=#111416"
cmd "hi TelescopePreviewBorder  guifg=#111416"
