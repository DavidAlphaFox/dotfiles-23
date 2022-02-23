local M = {}

local utils = require("utils")
local nls_sources = require("null-ls.sources")

local method = require("null-ls").methods.FORMATTING

M.autoformat = true

function M.toggle()
	M.autoformat = not M.autoformat
	if M.autoformat then
		utils.info("Enabled format on save", "Formatting")
	else
		utils.warn("Disabled format on save", "Formatting")
	end
end

function M.format()
	if M.autoformat then
		vim.lsp.buf.formatting_sync(nil, 2000)
	end
end

function M.setup(client, buf)
	local filetype = vim.api.nvim_buf_get_option(buf, "filetype")

	local enable = false
	if M.has_formatter(filetype) then
		enable = client.name == "null-ls"
	else
		enable = not (client.name == "null-ls")
	end

	client.resolved_capabilities.document_formatting = enable
	client.resolved_capabilities.document_range_formatting = enable
	if client.resolved_capabilities.document_formatting then
		vim.cmd([[
      augroup LspFormat
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua require("config.lsp.null-ls.formatters").format()
      augroup END
    ]])
	end
end

function M.has_formatter(filetype)
	local available = nls_sources.get_available(filetype, method)
	return #available > 0
end

return M
