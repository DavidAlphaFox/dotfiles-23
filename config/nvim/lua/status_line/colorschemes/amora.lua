M = {}
local colors = {
    bg = '#1a1a2e',
    fg = '#1a1a2e',
    section_bg = '#141414',
    -- section_bg = '#1b1f22',
    -- section_bg = '#1e2327',
    blue = '#aabae7',
    green = '#a2baa8',
    purple = '#b982ff',
    orange = '#edabd2',
    red = '#ed3f7f',
    red2 = '#fb5c8e',
    yellow = '#f7d98d',
    middlegrey = '#eacac0'
}

local mode_colors = {
	[110] = colors.purple,   -- NORMAL
	[105] = colors.green, -- INSERT
	[99] = colors.orange,   -- COMMAND
	[116] = colors.red2,-- TERMINAL
	[118] = colors.yellow,-- VISUAL
	[22] = colors.yellow, -- V-BLOCK
	[86] = colors.yellow, -- V-LINE
	[82] = colors.red,   -- REPLACE
	[115] = colors.blue,-- SELECT
	[83] = colors.blue  -- S-LINE
}
M.colors = colors
M.mode_colors = mode_colors
return M
