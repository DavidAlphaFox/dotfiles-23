M = {}
local colors = {
    bg = '#111416',
    fg = '#111416',
    section_bg = '#38393f',
    blue = '#7cb7ff',
    green = '#7ad88e',
    purple = '#bb98eb',
    orange = '#ffb86c',
    red1 = '#f67e7d',
    red2 = '#f34f4d',
    yellow = '#fee074',
    gray1 = '#5c6370',
    gray2 = '#2c323d',
    gray3 = '#3e4452',
    darkgrey = '#5c6370',
    grey = '#848586',
    middlegrey = '#8791A5'
}

local mode_colors = {
	[110] = colors.red1,  -- NORMAL
	[105] = colors.green, -- INSERT
	[99] = colors.red2,   -- COMMAND
	[116] = colors.orange,-- TERMINAL
	[118] = colors.purple,-- VISUAL
	[22] = colors.purple, -- V-BLOCK
	[86] = colors.purple, -- V-LINE
	[82] = colors.blue,   -- REPLACE
	[115] = colors.yellow,-- SELECT
	[83] = colors.yellow  -- S-LINE
}
M.colors = colors
M.mode_colors = mode_colors
return M
