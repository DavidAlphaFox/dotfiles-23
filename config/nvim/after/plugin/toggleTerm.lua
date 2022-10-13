local utils = require("utils")
local splitconfig = "20 new "
local terms = {}

local function newTermcConfig(num)
  table.insert(terms,{
    bufname = string.format("Term-%d", num),
    jobid = -1,
    bufid = -1,
    terminal_opened_win_id = -1,
    })
 end

local function showTerm(num, wind_id)
  terms[num].terminal_opened_win_id = wind_id
  vim.cmd(splitconfig .. "| buffer " .. terms[num].bufname)
  vim.cmd("startinsert")
end

local function newTerm(num, wind_id)
  terms[num].terminal_opened_win_id = wind_id
  vim.cmd(splitconfig .. "| term")
  vim.cmd("file " .. terms[num].bufname)
  vim.wo.relativenumber = false
  vim.o.number = false
  vim.bo.buflisted = false
  vim.wo.foldcolumn = '0'
  terms[num].bufid = vim.api.nvim_buf_get_number(0)
  terms[num].jobid = vim.b.terminal_job_id
  vim.cmd("startinsert")
end

local function hideLastTerm()
  local name = vim.fn.bufname("%")
  if name:find('^Term-') ~= nil then
    vim.cmd(":hide")
  end
end


--- Open or create terminal
function _G.ToggleTerm(num)
  if not terms[num] then
    newTermcConfig(num)
  end
  local buf_exist = vim.api.nvim_buf_is_valid(terms[num].bufid)
  local current_wind_id = vim.api.nvim_get_current_win()
  if buf_exist then
    local bufinfo = vim.fn.getbufinfo(terms[num].bufid)[1]
    if bufinfo.hidden == 1 then
      hideLastTerm()
      showTerm(num, current_wind_id)
    else
      vim.fn.win_gotoid(bufinfo.windows[1])
      vim.cmd(":hide")
      if current_wind_id ~= terms[num].terminal_opened_win_id and current_wind_id ~= bufinfo.windows[1] then
        vim.fn.win_gotoid(current_wind_id)
        hideLastTerm()
        showTerm(num, current_wind_id)
      end
    end
  else
    hideLastTerm()
    newTerm(num, current_wind_id)
  end
end

function _G.SingleTermSend(cmd, num, interrupt)
  interrupt = interrupt or false
  local buf_exist = vim.api.nvim_buf_is_valid(terms[num].bufid)
  if buf_exist then
    if interrupt then
      ToggleTerm(num)
      vim.api.nvim_chan_send(terms[num].jobid, vim.api.nvim_replace_termcodes('<C-c> <C-l>', true, true, true))
      vim.loop.sleep(100)
    end
    vim.api.nvim_chan_send(terms[num].jobid, cmd .. "\n")
  else
    ToggleTerm(num)
    vim.api.nvim_chan_send(terms[num].jobid, cmd .. "\n")
  end
end

-- Define your keymaping
utils.map({ "n", "t" }, "<C-ñ>", function() ToggleTerm(1) end)

-- vim.api.nvim_create_user_command({ nargs = 1 }, function(opts) SingleTermSend(opts.args) end, "Tsc")
