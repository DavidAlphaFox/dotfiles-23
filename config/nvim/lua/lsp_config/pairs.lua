local utils = require'utils'
local npairs = require('nvim-autopairs')

vim.g.coq_settings = {
  auto_start = 'shut-up',
  keymap = {
    recommended = false,
    jump_to_mark = "ñn"
  },
  clients = {
    tabnine = {
      enabled = true
    }
  },
  display = {
    icons = {
      mode = "short"
    }
  }
}

npairs.setup({ map_bs = false })

-- these mappings are coq recommended mappings unrelated to nvim-autopairs
utils.map('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
utils.map('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
utils.map('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
utils.map('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

-- skip it, if you use another global object
_G.MUtils= {}

MUtils.CR = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
      return npairs.esc('<c-y>')
    else
      return npairs.esc('<c-e>') .. npairs.autopairs_cr()
    end
  else
    return npairs.autopairs_cr()
  end
end
utils.map('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })

MUtils.BS = function()
  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
    return npairs.esc('<c-e>') .. npairs.autopairs_bs()
  else
    return npairs.autopairs_bs()
  end
end
utils.map('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })
