local M = require("status_line.nerd.definitions")

-- Lsp panel
-- M.insert_mid({ Start = M.transparent_border })

-- M.insert_blank_line_at_mid()

--M.insert_mid({
--  TrailingWhiteSpace = {
--    provider = M.trailing_whitespace,
--    icon = "  ",
--    highlight = { M.colors.yellow, M.colors.bg },
--  },
--})

M.insert_mid({
	DiagnosticError = {
		provider = "DiagnosticError",
		icon = "  ",
		highlight = { M.colors.red, M.colors.bg },
	},
})

M.insert_mid({
	DiagnosticHint = {
		provider = "DiagnosticHint",
		icon = "  ",
		highlight = { M.colors.blue, M.colors.bg },
	},
})

M.insert_mid({
	DiagnosticWarn = {
		provider = "DiagnosticWarn",
		icon = "  ",
		highlight = { M.colors.orange, M.colors.bg },
	},
})

-- M.insert_blank_line_at_mid()

-- M.insert_mid({ Start = M.transparent_border })
