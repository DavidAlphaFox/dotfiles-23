local gl = require('galaxyline')
local utils = require('utils')
local condition = require('galaxyline.condition')
local fileinfo  = require('galaxyline.provider_fileinfo')
local vcs       = require('galaxyline.provider_vcs')
local theme = require('status_line.colorschemes')
local colors = theme.colors
local mode_colors = theme.mode_colors

local gls = gl.section
gl.short_line_list = {'defx', 'packager', 'vista', 'NvimTree'}

local checkwidth = function()
    return utils.has_width_gt(35) and condition.buffer_not_empty()
end

local function has_value(tab, val)
    for _, value in ipairs(tab) do
        if value[1] == val then return true end
    end
    return false
end

local mode_color = function()
    local color = mode_colors[vim.fn.mode():byte()]
    if color ~= nil then
        return color
    else
        return colors.purple
    end
end

local function file_readonly()
    if vim.bo.filetype == 'help' then return '' end
    if vim.bo.readonly == true then return '  ' end
    return ''
end

local function get_current_file_name()
    local file = vim.fn.expand('%:t')
    if vim.fn.empty(file) == 1 then return '' end
    if string.len(file_readonly()) ~= 0 then return file .. file_readonly() end
    if vim.bo.modifiable then
        if vim.bo.modified then return file .. '  ' end
    end
    return file .. ' '
end

local position = 0
local function getNum()
	position = position + 1
	return position
end

-- Left side
gls.left[position] = {
    ViMode = {
        provider = function()
            local aliases = {
                [110] = 'NORMAL',
                [105] = 'INSERT',
                [99] = 'COMMAND',
                [116] = 'TERMINAL',
                [118] = 'VISUAL',
                [22] = 'V-BLOCK',
                [86] = 'V-LINE',
                [82] = 'REPLACE',
                [115] = 'SELECT',
                [83] = 'S-LINE'
            }
            vim.api.nvim_command('hi GalaxyViMode guibg=' .. mode_color())
            local alias = aliases[vim.fn.mode():byte()]
            local mode = ""
            if alias ~= nil then
                if utils.has_width_gt(35) then
                    mode = alias
                else
                    mode = alias:sub(1, 1)
                end
            else
                mode = vim.fn.mode():byte()
            end
            return '  ' .. mode .. ' '
        end,
        highlight = {colors.bg, colors.bg, 'bold'},
    }
}

gls.left[getNum()] = {
    FileIcon = {
        condition = condition.buffer_not_empty,
        highlight = {fileinfo.get_file_icon_color, colors.bg},
        provider = { function() return '  ' end, 'FileIcon' }
    }
}

gls.left[getNum()] = {
    FileName = {
        condition = condition.buffer_not_empty,
        highlight = {colors.fg, colors.bg},
        provider  = function()
            vim.api.nvim_command('hi GalaxyFileName guifg='..mode_color())
            return get_current_file_name()
        end
    }
}
gls.left[getNum()] = {
    DiagnosticError = {
        provider = 'DiagnosticError',
        icon = '  ',
        highlight = {colors.red1, colors.bg}
    }
}
gls.left[getNum()] = {
    Space = {
        provider = function() return ' ' end,
        highlight = {colors.bg, colors.bg}
    }
}
gls.left[getNum()] = {
    DiagnosticWarn = {
        provider = 'DiagnosticWarn',
        icon = '  ',
        highlight = {colors.orange, colors.bg}
    }
}
gls.left[getNum()] = {
    Space = {
        provider = function() return ' ' end,
        highlight = {colors.bg, colors.bg}
    }
}
gls.left[getNum()] = {
    DiagnosticInfo = {
        provider = 'DiagnosticInfo',
        icon = '  ',
        highlight = {colors.blue, colors.bg},
        separator = ' ',
        separator_highlight = {colors.bg, colors.bg}
    }
}

position = 1
-- Right side
gls.right[position] = {
    DiffAdd = {
        provider = 'DiffAdd',
        condition = checkwidth,
        icon = '✚ ',
        highlight = {colors.green, colors.bg}
    }
}
gls.right[getNum()] = {
    DiffModified = {
        provider = 'DiffModified',
        condition = checkwidth,
        icon = '✹ ',
        highlight = {colors.orange, colors.bg}
    }
}
gls.right[getNum()] = {
    DiffRemove = {
        provider = 'DiffRemove',
        condition = checkwidth,
        icon = '✖ ',
        highlight = {colors.red1, colors.bg}
    }
}
gls.right[getNum()] = {
    Space = {
        provider = function() return ' ' end,
        highlight = {colors.section_bg, colors.bg}
    }
}
gls.right[getNum()] = {
    GitIcon = {
        provider = function() return '  ' end,
        condition = condition.buffer_not_empty and
            vcs.check_git_workspace,
        highlight = {colors.red2, colors.bg}
    }
}
gls.right[getNum()] = {
    GitBranch = {
        provider = function()
            vim.api.nvim_command('hi GalaxyGitBranch guifg='..mode_color())
            return vcs.get_git_branch()
        end,
        condition = condition.buffer_not_empty,
        highlight = {colors.middlegrey, colors.bg}
    }
}
--[[ gls.right[getNum()] = {
    PerCent = {
        provider = 'LinePercent',
        separator = '',
        separator_highlight = {colors.blue, mode_color()},
        highlight = {colors.gray2, colors.blue}
    }
} --]]
-- gls.right[8] = {
--     ScrollBar = {
--         provider = 'ScrollBar',
--         highlight = {colors.purple, colors.section_bg}
--     }
-- }

position = 1
-- Short status line
gls.short_line_left[position] = {
    FileIcon = {
        provider = {function() return '  ' end, 'FileIcon'},
        condition = function()
            return condition.buffer_not_empty and
                       has_value(gl.short_line_list, vim.bo.filetype)
        end,
        highlight = {
            require('galaxyline.provider_fileinfo').get_file_icon,
            colors.section_bg
        }
    }
}
gls.short_line_left[getNum()] = {
    FileName = {
        provider = get_current_file_name,
	condition = condition.buffer_not_empty,
        highlight = {colors.fg, colors.section_bg},
        separator = '',
        separator_highlight = {colors.section_bg, colors.bg}
    }
}

gls.short_line_right[getNum()] = {
    BufferIcon = {
        provider = 'BufferIcon',
        highlight = {colors.yellow, colors.section_bg},
        separator = '',
        separator_highlight = {colors.section_bg, colors.bg}
    }
}

-- Force manual load so that nvim boots with a status line
gl.load_galaxyline()
