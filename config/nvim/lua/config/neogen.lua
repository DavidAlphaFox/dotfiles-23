local utils = require "utils"
local M = {}
function M.setup()
  local neogen = require("neogen")
  neogen.setup {
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

  local mapings = {
    c = { "class", "Comment Class" },
    f = { "func", "Comment Function" },
    i = { "file", "Comment File" },
    t = { "type", "Comment type" },
  }

  for k, v in pairs(mapings) do
    utils.map("n", string.format("<Leader>n%s", k), function()
      neogen.generate { type = v[1] }
    end, { desc = v[2] })
  end
end

return M
