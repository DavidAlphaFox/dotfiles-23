M = {}
local colors = {
    bg = '#1a1e21',
    fg = '#1a1e21',
    section_bg = '#040404',
    -- section_bg = '#1b1f22',
    -- section_bg = '#1e2327',
    blue = '#7cb7ff',
    green = '#7ad88e',
    purple = '#bb98eb',
    orange = '#f47d49',
    red = '#f67e7d',
    red2 = '#f34f4d',
    yellow = '#fee074',
    middlegrey = '#8791a5'
}

local mode_colors = {
	[110] = colors.red,   -- NORMAL
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
