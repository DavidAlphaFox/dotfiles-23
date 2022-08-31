local autopairs = {
  ['('] = ')',
  ['['] = ']',
  ['{'] = '}',
  ['<'] = '>',
  [ [=[']=] ] = [=[']=],
  [ [=["]=] ] = [=["]=],
}
local set_pairs = vim.keymap.set
for k, v in pairs(autopairs) do
  set_pairs('i', k, function()
    return k .. v .. '<Left>'
  end, { expr = true, noremap = true })
end
