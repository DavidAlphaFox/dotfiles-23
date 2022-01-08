vim.cmd [[packadd nvim-web-devicons]]
local gl = require 'galaxyline'
local utils = require 'utils'
local condition = require 'galaxyline.condition'
local diagnostic = require 'galaxyline.provider_diagnostic'
local fileinfo  = require('galaxyline.provider_fileinfo')
local vcs       = require('galaxyline.provider_vcs')
local theme = require('status_line.colorschemes')
local colors = theme.colors
local mode_colors = theme.mode_colors
local gls = gl.section

gl.short_line_list = { 'packer', 'NvimTree', 'Outline', 'LspTrouble' }

-- Local helper functions
local buffer_not_empty = function()
    return condition.buffer_not_empty()
end

local checkwidth = function()
    return utils.has_width_gt(35) and buffer_not_empty()
end

local function has_value(tab, val)
    for _, value in ipairs(tab) do
        if value[1] == val then
            return true
        end
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
    if vim.bo.filetype == 'help' then
        return ''
    end
    if vim.bo.readonly == true then
        return '  '
    end
    return ''
end

local function get_current_file_name()
    local file = vim.fn.expand '%:t'
    if vim.fn.empty(file) == 1 then
        return ''
    end
    if string.len(file_readonly()) ~= 0 then
        return file .. file_readonly()
    end
    if vim.bo.modifiable then
        if vim.bo.modified then
            return file .. '  '
        end
    end
    return file .. ' '
end

local function get_basename(file)
    return file:match '^.+/(.+)$'
end

local GetGitRoot = function()
    local git_dir = require('galaxyline.provider_vcs').get_git_dir()
    if not git_dir then
        return ''
    end

    local git_root = git_dir:gsub('/.git/?$', '')
    return ' ' .. get_basename(git_root) .. ' '
end

local LspStatus = function()
    if #vim.lsp.get_active_clients() > 0 then
        return require('lsp-status').status()
    end
    return ''
end

local LspCheckDiagnostics = function()
    if
        #vim.lsp.get_active_clients() > 0
        and diagnostic.get_diagnostic_error() == nil
        and diagnostic.get_diagnostic_warn() == nil
        and diagnostic.get_diagnostic_info() == nil
        and require('lsp-status').status() == ' '
    then
        return ' '
    end
    return ''
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
            local mode
            if alias ~= nil then
                if utils.has_width_gt(35) then
                    mode = alias
                else
                    mode = alias:sub(1, 1)
                end
            else
                mode = vim.fn.mode():byte()
            end
            return '  ' .. mode .. ' '
        end,
        highlight = { colors.bg, colors.bg, 'bold' },
    },
}
gls.left[getNum()] = {
    FileIcon = {
        condition = condition.buffer_not_empty,
        highlight = {fileinfo.get_file_icon_color, colors.section_bg},
        provider = { function() return '  ' end, 'FileIcon' }
    }
}
gls.left[getNum()] = {
    FileName = {
        provider = function()
                vim.api.nvim_command('hi GalaxyFileName guifg='..mode_color())
                return get_current_file_name()
            end,
        condition = buffer_not_empty,
        highlight = { colors.bg, colors.section_bg },
        separator = '',
        separator_highlight = { colors.section_bg, colors.bg },
    },
}
gls.left[getNum()] = {
    DiagnosticsCheck = {
        provider = { LspCheckDiagnostics },
        highlight = { colors.middlegrey, colors.bg },
    },
}
gls.left[getNum()] = {
    DiagnosticError = {
        provider = { 'DiagnosticError' },
        icon = '  ',
        highlight = { colors.red, colors.bg },
    },
}
gls.left[getNum()] = {
    DiagnosticWarn = {
        provider = { 'DiagnosticWarn' },
        icon = '  ',
        highlight = { colors.orange, colors.bg },
    },
}
gls.left[getNum()] = {
    DiagnosticInfo = {
        provider = { 'DiagnosticInfo' },
        icon = '  ',
        highlight = { colors.blue, colors.bg },
        -- separator = ' ',
        -- separator_highlight = {colors.section_bg, colors.bg}
    },
}
gls.left[getNum()] = {
    LspStatus = {
        provider = { LspStatus },
        -- separator = ' ',
        -- separator_highlight = {colors.bg, colors.bg},
        highlight = { colors.middlegrey, colors.bg },
    },
}

-- Right side
position = 0
gls.right[position] = {
    ShowLspClient = {
        provider = 'GetLspClient',
        condition = function()
            local tbl = {['dashboard'] = true, [''] = true}
            if tbl[vim.bo.filetype] then return false end
            return true
        end,
        icon = ' ',
        highlight = {colors.middlegrey, colors.bg},
        separator = ' ',
        separator_highlight = {colors.middlegrey, colors.bg}
    }
}
gls.right[getNum()] = {
    DiffAdd = {
        provider = 'DiffAdd',
        condition = checkwidth,
        icon = '✚ ',
        highlight = { colors.green, colors.bg },
        separator = ' ',
        separator_highlight = { colors.section_bg, colors.bg },
    },
}
gls.right[getNum()] = {
    DiffModified = {
        provider = 'DiffModified',
        condition = checkwidth,
        icon = '✹ ',
        highlight = { colors.orange, colors.bg },
    },
}
gls.right[getNum()] = {
    DiffRemove = {
        provider = 'DiffRemove',
        condition = checkwidth,
        icon = '✖ ',
        highlight = { colors.red, colors.bg },
    },
}
gls.right[getNum()] = {
    GitIcon = {
        provider = function() return '  ' end,
        condition = condition.check_git_workspace,
            vcs.check_git_workspace,
        highlight = {colors.red2, colors.bg}
    }
}
gls.right[getNum()] = {
    GitBranch = {
        provider = "GitBranch",
        condition = condition.buffer_not_empty,
        highlight = {colors.middlegrey, colors.bg}
    }
}
gls.right[getNum()] = {
    GitRoot = {
        -- provider = { GetGitRoot },
        provider  = function()
            vim.api.nvim_command('hi GalaxyGitRoot guifg='..mode_color())
            return GetGitRoot()
        end,
        condition = function()
            return utils.has_width_gt(50) and condition.check_git_workspace
        end,
        -- icon = '  ',
        highlight = { colors.bg, colors.section_bg },
        separator = '',
        separator_highlight = { colors.section_bg, colors.bg },
    },
}
gls.right[getNum()] = {
    PerCent = {
        -- provider = 'LinePercent',
        provider = { function()
            vim.api.nvim_command('hi GalaxyPerCent guibg='..mode_color())
            return ' '
        end, 'LinePercent' },
        highlight = { colors.bg, colors.bg },
    },
}

-- Short status line
position = 0
gls.short_line_left[position] = {
    FileIcon = {
        provider = { function()
            return '  '
        end, 'FileIcon' },
        condition = function()
            return buffer_not_empty and has_value(
                gl.short_line_list,
                vim.bo.filetype
            )
        end,
        highlight = {
            require('galaxyline.provider_fileinfo').get_file_icon,
            colors.section_bg,
        },
    },
}
gls.short_line_left[getNum()] = {
    FileName = {
        -- provider = get_current_file_name,
        provider  = function()
            vim.api.nvim_command('hi GalaxyFileName guifg='..mode_color())
            return get_current_file_name()
        end,
        condition = buffer_not_empty,
        highlight = { colors.fg, colors.section_bg },
        separator = '',
        separator_highlight = { colors.section_bg, colors.bg },
    },
}

gls.short_line_right[0] = {
    BufferIcon = {
        provider = 'BufferIcon',
        highlight = { colors.yellow, colors.section_bg },
        separator = '',
        separator_highlight = { colors.section_bg, colors.bg },
    },
}

-- Force manual load so that nvim boots with a status line
gl.load_galaxyline()
