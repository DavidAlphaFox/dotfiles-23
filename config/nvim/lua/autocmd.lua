--
--- Goto last position
--

function Goto_last_pos()
  local last_pos = vim.fn.line "'\""
  if last_pos > 0 and last_pos <= vim.fn.line "$" then
    vim.api.nvim_win_set_cursor(0, { last_pos, 0 })
  end
end

--
-- Autocmd
--
-- au FileType python setlocal tabstop=4 shiftwidth=4 expandtab
-- au FileType typescript setlocal tabstop=2 shiftwidth=2 expandtab
-- au FileType lua setlocal tabstop=2 shiftwidth=2 expandtab
-- au BufEnter *.py set ai sw=4 ts=4 sta et fo=croq
vim.cmd [[
  augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
  augroup END
  au FileType cs setlocal shiftwidth=4 softtabstop=4 expandtab
  autocmd BufReadPost * lua Goto_last_pos()
  autocmd FileType make setlocal noexpandtab
  autocmd BufEnter * :let @/=""
  autocmd BufWritePre * :%s/\s\+$//e
  autocmd BufEnter * silent! lcd %:p:h
]]
