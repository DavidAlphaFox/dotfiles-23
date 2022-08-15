local utils = require("utils")
local bufname = "TerminalCrag"
local splitconfig = "bot 20 new "
local jobid = -1
local bufid = -1
local terminal_opened_win_id = -1

local function OpenTerm()
  local buf_exist = vim.api.nvim_buf_is_valid(bufid)
  local current_wind_id = vim.api.nvim_get_current_win()
  if buf_exist then
    local bufinfo = vim.fn.getbufinfo(bufid)[1]
    if bufinfo.hidden == 1 then
      terminal_opened_win_id = current_wind_id
      vim.cmd(splitconfig .. "| buffer " .. bufname)
      vim.cmd("startinsert")
    else
      vim.fn.win_gotoid(bufinfo.windows[1])
      vim.cmd(":hide")
      if current_wind_id ~= terminal_opened_win_id and current_wind_id ~= bufinfo.windows[1] then
        vim.fn.win_gotoid(current_wind_id)
        terminal_opened_win_id = current_wind_id
        vim.cmd(splitconfig .. "| buffer " .. bufname)
        vim.cmd("startinsert")
      end
    end
  else
    terminal_opened_win_id = current_wind_id
    vim.cmd(splitconfig .. "| term")
    vim.cmd("file " .. bufname)
    vim.wo.relativenumber = false
    vim.o.number = false
    vim.bo.buflisted = false
    vim.wo.foldcolumn = '0'
    bufid = vim.api.nvim_buf_get_number(0)
    jobid = vim.b.terminal_job_id
    vim.cmd("startinsert")
  end
end

function _G.CragTermSend(cmd)
  local buf_exist = vim.api.nvim_buf_is_valid(bufid)
  if buf_exist then
    vim.fn.chansend(jobid, vim.api.nvim_replace_termcodes('<C-c> ', true, true, true))
    vim.loop.sleep(100)
    vim.fn.chansend(jobid, cmd .. "\n")
  else
    OpenTerm()
    vim.fn.chansend(jobid, cmd .. "\n")
  end
end

utils.map({ "n", "t" }, "<C-ñ>", OpenTerm)

vim.api.nvim_create_user_command("Tsc", function(opts) CragTermSend(opts.args) end, { nargs = 1 })
