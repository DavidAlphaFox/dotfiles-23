local M = {}
function M.setup()
	require('neogen').setup{
		enabled = true,
		languages = {
			lua = {
				template = {
					annotation_convention = "emmylua" -- for a full list of annotation_conventions, see supported-languages below,
				}
			},
			cs = {
				template = {
					annotation_convention = "xmldoc"
				}
			},
			python = {
				template = {
					annotation_convention = "google_docstrings"
				}
			},
			typescript = {
				template = {
					annotation_convention = "jsdoc"
				}
			},
		}
	}
end

return M
