--  _____
-- () | ,_  o  _  |)   ,
--    |/  | | /   |/) / \_
--  (/    |/|/\__/| \/ \/
--
local utils = require "utils"
-- local autopairs = {
--   ['('] = ')',
--   ['['] = ']',
--   ['{'] = '}',
--   ['<'] = '>',
--   [ [=[']=] ] = [=[']=],
--   [ [=["]=] ] = [=["]=],
-- }
-- local set_pairs = vim.keymap.set
-- for k, v in pairs(autopairs) do
--   set_pairs('i', k, function()
--     return k .. v .. '<Left>'
--   end, { expr = true, noremap = true })
-- end

local set_quit_maps = function()
  vim.keymap.set('n', 'q', ':bd!<CR>', { buffer = true, silent = true })
  vim.keymap.set('n', '<ESC>', ':bd!<CR>', { buffer = true, silent = true })
end

function cheat_sh()
  vim.ui.input({ width = 30 }, function(query)
    query = table.concat(vim.split(query, " "), "+")
    local cmd = ('curl "https://cht.sh/%s/%s"'):format(vim.bo.ft, query)
    vim.cmd("split | term " .. cmd)
    vim.cmd [[stopinsert!]]
    set_quit_maps()
  end)
end

utils.map({ "n", "t" }, "<leader>ch", cheat_sh)
