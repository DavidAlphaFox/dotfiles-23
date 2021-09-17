-- utils.map('n', '<Leader><PageDown>' ':BufferLineCycleNext<CR>
-- utils.map('n', '<Leader><PageUP>' ':BufferLineCyclePrev<CR>
-- utils.map('n', '<c-p>' ':BufferLinePick<CR>
-- utils.map('n', <leader>1' ':lua require"bufferline".go_to_buffer(1)<CR>
-- utils.map('n', <leader>2' ':lua require"bufferline".go_to_buffer(2)<CR>
-- utils.map('n', <leader>3' ':lua require"bufferline".go_to_buffer(3)<CR>
-- utils.map('n', <leader>4' ':lua require"bufferline".go_to_buffer(4)<CR>
-- utils.map('n', <leader>5' ':lua require"bufferline".go_to_buffer(5)<CR>
-- utils.map('n',  '<leader>R', ':Lspsaga open_floaterm crlvc %<CR>', opts)

--[[ require("buftabline").setup {
    modifier = ":t",
    index_format = "%d: ",
    padding = 1,
    icons = true,
    start_hidden = true,
    disable_commands = false,
    go_to_maps = true,
    kill_maps = false,
    custom_command = nil,
    custom_map_prefix = nil,
    hlgroup_current = "TabLineSel",
    hlgroup_normal = "TabLineFill",}
utils.map('n', '<leader>t', ':ToggleBuftabline<cr>', opts)
]]

require('tabline').setup{
    no_name = '[No Name]',    -- Name for buffers with no name
    modified_icon = '',      -- Icon for showing modified buffer
    close_icon = '',         -- Icon for closing tab with mouse
    separator = "",          -- Separator icon on the left side
    padding = 3,              -- Prefix and suffix space
    color_all_icons = true,  -- Color devicons in active and inactive tabs
    always_show_tabs = false, -- Always show tabline
    right_separator = false,  -- Show right separator on the last tab
}

vim.cmd [[ hi TabLineSel guibg=#111416 guifg=#5b5b5b]]

vim.o.showtabline = 0

-- local formatTab = require'luatab'.formatTab
-- Tabline = function()
--     local i = 1
--     local line = ''
--     while i <= vim.fn.tabpagenr('$') do
--         line = line .. formatTab(i)
--         i = i + 1
--     end
--     local infoTabs = string.format("%d/%d ", vim.fn.tabpagenr(), vim.fn.tabpagenr('$'))
--     return  infoTabs .. line .. '%T%#TabLineFill#%='
-- end
-- vim.o.tabline = '%!v:lua.Tabline()'
