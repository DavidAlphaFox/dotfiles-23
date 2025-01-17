--   __,
--  /  |       _|_  _   _           _|
-- |   |  |  |  |  / \_/   /|/|/|  / |
--  \_/\_/ \/|_/|_/\_/ \__/ | | |_/\/|_/
--

local api = vim.api
local cmd = vim.cmd
--- Goto last position
--

-- Highlight on yank
local highlight_group = api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { timeout = 170 }
  end,
  group = highlight_group,
  pattern = "*",
})

-- show cursor line only in active window
local cursorGrp = api.nvim_create_augroup("CursorLine", { clear = true })
api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, { pattern = "*", command = "set cursorline", group = cursorGrp })
api.nvim_create_autocmd(
  { "InsertEnter", "WinLeave" },
  { pattern = "*", command = "set nocursorline", group = cursorGrp }
)

function Goto_last_pos()
  local last_pos = vim.fn.line "'\""
  if last_pos > 0 and last_pos <= vim.fn.line "$" then
    vim.api.nvim_win_set_cursor(0, { last_pos, 0 })
  end
end

--
-- Autocmd
--
api.nvim_create_autocmd("FocusGained", { command = [[:checktime]] })
api.nvim_create_autocmd("BufReadPost", { command = "lua Goto_last_pos()" })
-- Delete spaces
api.nvim_create_autocmd("BufWritePre", { command = [[%s/\s\+$//e]] })
api.nvim_create_autocmd("BufEnter", { command = [[let @/=""]] })
-- Pwd in currente buffer
api.nvim_create_autocmd("BufEnter", { command = "silent! lcd %:p:h" })
-- Format options
api.nvim_create_autocmd("FileType", { pattern = "cs", command = [[setlocal shiftwidth=4 softtabstop=4 expandtab]] })
api.nvim_create_autocmd("FileType", { pattern = "make", command = [[setlocal noexpandtab]] })
-- don't auto comment new line
api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })
api.nvim_create_autocmd("FileType", { pattern = "man", command = [[nnoremap <buffer><silent> q :quit<CR>]] })

-- Create an autocmd User PackerCompileDone to update it every time packer is compiled
-- vim.api.nvim_create_autocmd("User", {
-- 	pattern = "PackerCompileDone",
-- 	callback = function()
-- 		vim.cmd "CatppuccinCompile"
-- 		vim.defer_fn(function()
-- 			vim.cmd "colorscheme catppuccin"
-- 		end, 0) -- Defered for live reloading
-- 	end
-- })
-- Fix highlight issue
api.nvim_create_autocmd("BufEnter", { command = [[syntax enable]] })

-- au FileType python setlocal tabstop=4 shiftwidth=4 expandtab
-- au FileType typescript setlocal tabstop=2 shiftwidth=2 expandtab
-- au FileType lua setlocal tabstop=2 shiftwidth=2 expandtab
-- au BufEnter *.py set ai sw=4 ts=4 sta et fo=croq
