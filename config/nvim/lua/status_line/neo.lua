local gl  = require('galaxyline')
local gls = gl.section

local buffer    = require('galaxyline.provider_buffer')
local condition = require('galaxyline.condition')
local fileinfo  = require('galaxyline.provider_fileinfo')
local lsp       = require('galaxyline.provider_lsp')
local vcs       = require('galaxyline.provider_vcs')
local colors = {
	magenta = '#d3a0ce',
	green = '#9ece6a',
	blue = '#61afef',
	cyan = '#b4d5ff',
	purple = '#c678dd',
	orange = '#ffb86c',
	yellow = '#e5c07b',
	black = '#111416',
	bg = '#111416',
	bg_statusline = '#111416',
	red = '#e68183'
}

gl.short_line_list = {'NvimTree', 'help', 'tagbar'}

-- Maps {{{1
local mode_color = { -- {{{2
	c  = colors.magenta, ['!'] = colors.red,
	i  = colors.orange,   ic    = colors.yellow, ix     = colors.yellow,
	n  = colors.red,
	no = colors.red,    nov   = colors.red,   noV    = colors.red,
	r  = colors.cyan,    rm    = colors.cyan,   ['r?'] = colors.cyan,
	R  = colors.green,  Rv    = colors.green,
	s  = colors.orange,  S     = colors.orange, [''] = colors.orange,
	t  = colors.blue,
	v  = colors.purple,     V     = colors.purple,    [''] = colors.purple,
}
-- }}}2

local mode_icon = { --- {{{2
	c = "🅒 ", ['!'] = "🅒 ",
	i = "🅘 ", ic    = "🅘 ", ix     = "🅘 ",
	n = "🅝 ",
	R = "🅡 ", Rv    = "🅡 ",
	r = "🅡 ", rm    = "🅡 ", ['r?'] = "🅡 ",
	s = "🅢 ", S     = "🅢 ", [''] = "🅢 ",
	t = "🅣 ",
	v = "🅥 ", V     = "🅥 ", [''] = "🅥 ",
}
-- }}}2

local num_icons = {"➊ ", "❷ ", "➌ ", "➍ ", "➎ ", "➏ ", "➐ ", "➑ ", "➒ ", " "}
-- }}}1
local position = 0
local function getNum()
	position = position + 1
	return position
end
-- Left hand side modules {{{1
gls.left[position] = { Left = { -- {{{2
	highlight = {colors.blue, colors.bg_statusline},

	provider = function ()
		vim.api.nvim_command('hi GalaxyLeft guifg='..mode_color[vim.fn.mode()])
		return "█"
	end,
}}
-- }}}2
gls.left[getNum()] = { ModeNum = { -- {{{2
	highlight = {colors.black, colors.bg_statusline, 'bold'},

	provider = function ()
		vim.api.nvim_command('hi GalaxyModeNum guibg='..mode_color[vim.fn.mode()])
		return mode_icon[vim.fn.mode()] .. num_icons[math.min(10, buffer.get_buffer_number())]
	end,
}}
-- }}}2

gls.left[getNum()] = { BufSep = { -- {{{2
	highlight = {colors.bg_statusline, colors.bg_statusline},

	provider = function ()
		vim.api.nvim_command("hi GalaxyBufSep guibg="..mode_color[vim.fn.mode()])
		return "█"
	end,
}}
-- }}}2

gls.left[getNum()] = { FileIcon = { -- {{{2
	condition = condition.buffer_not_empty,
	highlight = {fileinfo.get_file_icon_color, colors.bg_statusline},
	provider  = 'FileIcon',
}}
-- }}}2

gls.left[getNum()] = { FileName = { -- {{{2
	condition = condition.buffer_not_empty,
	highlight = {colors.white, colors.bg_statusline, 'bold'},
	provider  = 'FileName',
}}

-- }}}2

gls.left[getNum()] = { FileSep = { -- {{{2
	highlight = {colors.bg_statusline, colors.bg_statusline},

	provider = function ()
		vim.api.nvim_command('hi GalaxyFileSep guibg='..mode_color[vim.fn.mode()])
		return " "
	end,
}}
-- }}}2

gls.left[getNum()] = { FileEF = { -- {{{2
	highlight = {colors.black, colors.bg_statusline, 'bold'},

	provider = function ()
		local format_icon = {['DOS'] = " ", ['MAC'] = " ", ['UNIX'] = " "}
		local encode      = fileinfo.get_file_encode()
		local format      = fileinfo.get_file_format()

		vim.api.nvim_command('hi GalaxyFileEF guibg='..mode_color[vim.fn.mode()])
		return encode..' '..format_icon[format]
	end,
}}
-- }}}2

gls.left[getNum()] = { EFSep = { -- {{{2
	highlight = {colors.bg_statusline, colors.bg_statusline},

	provider = function ()
		vim.api.nvim_command('hi GalaxyEFSep guibg='..mode_color[vim.fn.mode()])
		return "█"
	end,
}}
-- }}}2

gls.left[getNum()] = { Git = { -- {{{2
	condition = condition.check_git_workspace,
	highlight = {colors.bg_statusline, colors.bg_statusline, 'bold'},

	provider = function ()
		vim.api.nvim_command('hi GalaxyGit guifg='..mode_color[vim.fn.mode()])
		local branch = vcs.get_git_branch()
		if (branch == nil) then branch = '???' end
		return ' '..branch..' '
	end,
}}
-- }}}2
-- }}}1

-- Centered modules {{{1
--[[ gls.mid[0] = { Empty = {
	highlight = {colors.bg_statusline, colors.bg_statusline},
	provider  = function()
		vim.api.nvim_command('hi GalaxyEmpty guifg='..mode_color[vim.fn.mode()])
		return
	end
}} --]]
-- }}}1

-- Right hand side modules {{{1
position = 0
gls.right[position] = { FileNumTab = { -- {{{2
	highlight = {colors.bg_statusline, colors.bg_statusline, 'bold'},
	provider  = function()
		vim.api.nvim_command('hi GalaxyFileNumTab guifg='..mode_color[vim.fn.mode()])
		return string.format("%d/%d ", vim.fn.tabpagenr(), vim.fn.tabpagenr('$'))
	end
}}

gls.right[getNum()] = { LspClient = { -- {{{2
	highlight = {colors.bg_statusline, colors.bg_statusline, 'bold'},

	provider = function ()
		local icon = ' '
		local active_lsp = lsp.get_lsp_client()

		if active_lsp == 'No Active Lsp' then
			icon = ''
			active_lsp  = ''
		end

		vim.api.nvim_command('hi GalaxyLspClient guifg='..mode_color[vim.fn.mode()])
		return icon..active_lsp..' '
	end,
}}
-- }}}2

gls.right[getNum()] = { DiagnosticError = { -- {{{2
	highlight = {colors.red, colors.bg_statusline, 'bold'},

	provider = function ()
		local icon = ' '
		local count = vim.lsp.diagnostic.get_count(0, 'Error')

		if count == 0 then
			return
		else
			return icon..count..' '
		end
	end,
}}
-- }}}2

gls.right[getNum()] = { DiagnosticWarn = { -- {{{2
	highlight = {colors.yellow, colors.bg_statusline, 'bold'},

	provider = function ()
		local icon = ' '
		local count = vim.lsp.diagnostic.get_count(0, 'Warning')

		if count == 0 then
			return
		else
			return icon..count..' '
		end
	end,
}}
-- }}}2

gls.right[getNum()] = { DiagnosticHint = { -- {{{2
	highlight = {colors.cyan, colors.bg_statusline, 'bold'},

	provider = function ()
		local icon = ' '
		local count = vim.lsp.diagnostic.get_count(0, 'Hint')

		if count == 0 then
			return
		else
			return icon..count..' '
		end
	end,
}}
-- }}}2

gls.right[getNum()] = { DiagnosticInfo = { -- {{{2
	highlight = {colors.blue, colors.bg_statusline, 'bold'},

	provider = function ()
		local icon = ' '
		local count = vim.lsp.diagnostic.get_count(0, 'Information')

		if count == 0 then
			return
		else
			return icon..count..' '
		end
	end,
}}
-- }}}2

gls.right[getNum()] = { LineSep = { -- {{{2
	highlight = {colors.bg_statusline, colors.bg_statusline},

	provider = function ()
		vim.api.nvim_command('hi GalaxyLineSep guibg='..mode_color[vim.fn.mode()])
		return " "
	end,
}}
-- }}}2

gls.right[getNum()] = { LineInfo = { -- {{{2
	highlight = {colors.black, colors.bg_statusline, 'bold'},

	provider = function ()
		local cursor = vim.api.nvim_win_get_cursor(0)

		vim.api.nvim_command('hi GalaxyLineInfo guibg='..mode_color[vim.fn.mode()])
		return '☰ '..cursor[1]..'/'..vim.api.nvim_buf_line_count(0)..':'..cursor[2]
	end,
}}
-- }}}2

gls.right[getNum()] = { Right = { -- {{{2
	highlight = {colors.blue, colors.bg_statusline},

	provider = function ()
		vim.api.nvim_command('hi GalaxyRight guifg='..mode_color[vim.fn.mode()])
		return '█'
	end,
}}
-- }}}2
-- }}}1
position = 0
-- Short line left hand side modules {{{1
gls.short_line_left[position] = { Left = { -- {{{2
	highlight = {colors.bg_statusline, colors.bg},

	provider = function ()
		vim.api.nvim_command('hi GalaxyLeft guifg='..mode_color[vim.fn.mode()])
		return "█"
	end,
}}
-- }}}2

gls.short_line_left[getNum()] = { ModeNum = { -- {{{2
	highlight = {colors.black, colors.bg, 'bold'},

	provider = function ()
		vim.api.nvim_command('hi GalaxyModeNum guibg='..mode_color[vim.fn.mode()])
		return
			mode_icon[vim.fn.mode()]..
			num_icons[math.min(10, buffer.get_buffer_number())]
	end,
}}
-- }}}2

gls.short_line_left[getNum()] = { BufSep = { -- {{{2
	highlight = {colors.bg, colors.bg},

	provider = function ()
		vim.api.nvim_command("hi GalaxyBufSep guibg="..mode_color[vim.fn.mode()])
		return "█"
	end,
}}
-- }}}2

gls.short_line_left[getNum()] = { FileIcon = { -- {{{2
	condition = condition.buffer_not_empty,
	highlight = {fileinfo.get_file_icon_color, colors.bg},
	provider  = 'FileIcon',
}}
-- }}}2

gls.short_line_left[getNum()] = { FileName = { -- {{{2
	highlight = {colors.white, colors.bg, 'bold'},
	provider  = 'FileName',
}}
-- }}}2
-- }}}1
position = 1
-- Short line right hand side modules {{{1
gls.short_line_right[position] = { LineSep = { -- {{{2
	highlight = {colors.bg, colors.bg},

	provider = function ()
		vim.api.nvim_command('hi GalaxyLineSep guibg='..mode_color[vim.fn.mode()])
		return " "
	end,
}}
-- }}}2

gls.short_line_right[getNum()] = { LineInfo = { -- {{{2
	highlight = {colors.black, colors.bg, 'bold'},

	provider = function ()
		local cursor = vim.api.nvim_win_get_cursor(0)

		vim.api.nvim_command('hi GalaxyLineInfo guibg='..mode_color[vim.fn.mode()])
		return '☰ '..cursor[1]..'/'..vim.api.nvim_buf_line_count(0)..':'..cursor[2]
	end,
}}
-- }}}2

gls.short_line_right[getNum()] = { Right = { -- {{{2
	highlight = {colors.blue, colors.bg},

	provider = function ()
		vim.api.nvim_command('hi GalaxyRight guifg='..mode_color[vim.fn.mode()])
		return '█'
	end,
}}
-- }}}2
-- }}}1
