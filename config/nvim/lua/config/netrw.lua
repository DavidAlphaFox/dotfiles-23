local utils = require "utils"

vim.cmd [[hi! link netrwMarkFile Search]]
vim.g.netrw_hide = 1
-- vim.g.netrw_keepdir = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_list_hide = [[.*\.swp$,.DS_Store,*/tmp/*,*.so,*.swp,*.zip,*.git,^\.\.\=/\=$]]
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 3
vim.g.netrw_winsize = 15
vim.g.netrw_localcopydircmd = "cp -r"

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "netrw",
--   callback = function()
--     vim.opt.bufhidden = "hide"
--   end,
-- })

-- Toggle Netrw
-- local netrw_info = {
--   bufid = -1,
--   winid = -1,
--   before_wind_id = -1,
--   hidden = false,
-- }

-- local function show_netrw(wind_id)
--   netrw_info.before_wind_id = wind_id
--   vim.cmd("topleft" .. vim.g.netrw_winsize + 15 .. " vs new | buffer " .. netrw_info.bufid)
--   netrw_info.winid = vim.api.nvim_get_current_win()
--   netrw_info.bufid = vim.api.nvim_buf_get_number(0)
--   netrw_info.hidden = false
-- end
--
-- local function toggle_netrw()
--   local buf_exist = vim.api.nvim_buf_is_valid(netrw_info.bufid)
--   local current_wind_id = vim.api.nvim_get_current_win()
--   if buf_exist then
--     utils.info('entre', 'netrw')
--     if netrw_info.hidden then
--       show_netrw(current_wind_id)
--     else
--       vim.fn.win_gotoid(netrw_info.winid)
--       vim.cmd ":hide"
--       netrw_info.hidden = true
--       if current_wind_id ~= netrw_info.before_wind_id and current_wind_id ~= netrw_info.winid then
--         vim.fn.win_gotoid(current_wind_id)
--         show_netrw(current_wind_id)
--       end
--     end
--   else
--     netrw_info.before_wind_id = current_wind_id
--     vim.cmd [[silent Lexplore]]
--     netrw_info.winid = vim.api.nvim_get_current_win()
--     netrw_info.bufid = vim.api.nvim_buf_get_number(0)
--     netrw_info.hidden = false
--   end
-- end

local cwd = "%:p:h"
local first = true
local function toggle_netrw()
  local winds = vim.api.nvim_tabpage_list_wins(0)
  local hide = true

  for _, winid in pairs(winds) do
    local ft = vim.bo[vim.fn.winbufnr(winid)].ft
    if ft == "netrw" then
      hide = false
      vim.cmd [[Lexplore]]
      break
    end
  end

  if hide then
    if first then
      cwd = vim.fn.expand(cwd)
      first = fasle
    end
    utils.info(cwd, "netrw")
    vim.cmd([[silent Lexplore ]] .. cwd)
  end
end

local M = {}
function M.setup()
  require("netrw").setup {
    use_devicons = true,
  }

  utils.map("n", "<leader><leader>", toggle_netrw) -- open explorer in vertical split

  -- vim.cmd [[
  --   augroup AutoDeleteNetrwHiddenBuffers
  --     au!
  --     au FileType netrw setlocal bufhidden=hide
  --   augroup end
  -- ]]
end

return M
