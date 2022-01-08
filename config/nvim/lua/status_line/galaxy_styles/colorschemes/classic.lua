M = {}
local colors = {
    bg = '#111416',
    fg = '#aab2bf',
    section_bg = '#38393f',
    blue = '#61afef',
    green = '#98c379',
    purple = '#c678dd',
    orange = '#ffb86c',
    red1 = '#e06c75',
    red2 = '#be5046',
    yellow = '#e5c07b',
    gray1 = '#5c6370',
    gray2 = '#2c323d',
    gray3 = '#3e4452',
    darkgrey = '#5c6370',
    grey = '#848586',
    middlegrey = '#8791A5'
}

local mode_colors = {
	[110] = colors.green, -- NORMAL
	[105] = colors.blue,  -- INSERT
	[99] = colors.orange, -- COMMAND
	[116] = colors.blue,  -- TERMINAL
	[118] = colors.purple,-- VISUAL
	[22] = colors.purple, -- V-BLOCK
	[86] = colors.purple, -- V-LINE
	[82] = colors.red1,   -- REPLACE
	[115] = colors.red1,  -- SELECT
	[83] = colors.red1    -- S-LINE
}
M.colors = colors
M.mode_colors = mode_colors
return M
