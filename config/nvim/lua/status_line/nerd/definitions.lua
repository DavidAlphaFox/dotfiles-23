local gl = require("galaxyline")
local gls = gl.section

local M = {}

M.colors = {
	bg = '#1a1e21',
	blue = '#7cb7ff',
	deep_blue = "#b4d5ff",
	fg = '#e6d6ac',
	fg_green = "#cae7b9",
	gray = "#8791a5",
	green = '#7ad88e',
	magenta = "#f9adad",
	orange = '#f47d49',
	purple = '#bb98eb',
	red = '#f67e7d',
	yellow = '#fee074',
	violet= '#d3a0bc',
}

M.icons = {
	n = " ",
	i = " ",
	c = "ﲵ ",
	V = " ",
	[""] = " ",
	v = " ",
	C = "ﲵ ",
	R = "﯒ ",
	t = " ",
}

M.alias = {
	n = "N",
	i = "I",
	c = "C",
	V = "VL",
	[""] = "V",
	v = "V",
	C = "C",
	["r?"] = ":CONFIRM",
	rm = "--MORE",
	R = "R",
	Rv = "R&V",
	s = "S",
	S = "S",
	["r"] = "HIT-ENTER",
	[""] = "SELECT",
	t = "T",
	["!"] = "SH",
}

M.mode_color = {
	n = M.colors.yellow,
	i = M.colors.green,
	v = M.colors.blue,
	[""] = M.colors.blue,
	V = M.colors.blue,
	c = M.colors.magenta,
	no = M.colors.red,
	s = M.colors.orange,
	S = M.colors.orange,
	[""] = M.colors.orange,
	ic = M.colors.yellow,
	R = M.colors.violet,
	Rv = M.colors.violet,
	cv = M.colors.red,
	ce = M.colors.red,
	r = M.colors.blue,
	rm = M.colors.blue,
	["r?"] = M.colors.blue,
	["!"] = M.colors.red,
	t = M.colors.red,
}

--M.trailing_whitespace = function()
--  local trail = vim.fn.search("\\s$", "nw")
--  if trail ~= 0 then
--    return " "
--  else
--    return nil
--  end
--end

M.semi_circle = function(is_left)
	if is_left then
		return " "
	else
		return " "
	end
end

M.transparent_border = {
	provider = function()
		return "  "
	end,
}

M.left_border = {
	provider = function()
		return M.semi_circle(true)
	end,
	highlight = { M.colors.bg, M.colors.bg },
}

M.right_border = {
	provider = function()
		return M.semi_circle(false)
	end,
	highlight = { M.colors.bg, M.colors.bg },
}

M.space = {
	provider = function()
		return " "
	end,
	highlight = { M.colors.bg, M.colors.bg },
}

M.has_file_type = function()
	local f_type = vim.bo.filetype
	if not f_type or f_type == "" then
		return false
	end
	return true
end

M.buffer_not_empty = function()
	if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
		return true
	end
	return false
end

M.insert_left = function(element)
	table.insert(gls.left, element)
end

M.insert_blank_line_at_left = function()
	M.insert_left({ Space = M.space })
end

M.insert_mid = function(element)
	table.insert(gls.mid, element)
end

M.insert_blank_line_at_mid = function()
	M.insert_mid({ Space = M.space })
end

M.insert_right = function(element)
	table.insert(gls.right, element)
end

M.insert_blank_line_at_right = function()
	M.insert_right({ Space = M.space })
end

M.checkwidth = function()
	local squeeze_width = vim.fn.winwidth(0) / 2
	if squeeze_width > 40 then
		return true
	end
	return false
end

return M
