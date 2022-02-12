local M = {}
-- _ \_)
-- |  ||  -_)  _` |  _ \
--___/_|\___|\__, |\___/
--           ____/

function M.setup()
	local coq = require "coq"
	-- 3party sources
	require "coq_3p" {
		{ src = "nvimlua", short_name = "nLUA", conf_only = false }, -- Lua
		{ src = "bc", short_name = "MATH", precision = 6 }, -- Calculator
		-- { src = "cow", trigger = "!cow" }, -- cow command
		{ src = "figlet", short_name = "BIG", trigger = "!big" }, -- figlet command
		{
			src = "repl",
			sh = "zsh",
			shell = { p = "perl", n = "node", y = "python", l = "lua" },
			max_lines = 99,
			deadline = 500,
			unsafe = { "rm", "poweroff", "mv", "mkdir", "systemctl" }
		},
	}
	require("lsp_config.supports").setup()
	coq.Now() -- Start coq
end

return M

