-- | | _____ _   _ _ __ ___   __ _ _ __
-- | |/ / _ \ | | | '_ ` _ \ / _` | '_ \
-- |   <  __/ |_| | | | | | | (_| | |_) |
-- |_|\_\___|\__, |_| |_| |_|\__,_| .__/
--           |___/                |_|

local utils = require "utils"
local opts = { noremap = true, silent = false }

utils.map("n", "-", "`")
utils.map("n", "Y", "yg$")
utils.map("n", "k", "gk")
utils.map("n", "j", "gj")

-- Search in the current buffer
utils.map("n", "<leader>s", "?", opts)
-- Search and  replace in the current buffer
utils.map({ "n", "v" }, "<leader>r", ":s/", opts)
-- Set ; to end line
utils.map("n", ";", "<esc>mzA;<esc>`z")

-- No yank
utils.map("n", "x", '"_x')
utils.map({ "n", "x" }, "c", '"_c')
utils.map("n", "C", '"_C')
utils.map("v", "p", '"_dP', opts)
-- Better indent
utils.map("v", "<", "<gv", opts)
utils.map("v", ">", ">gv", opts)

-- Toggle spell checker
utils.map("n", "<F2>", ":setlocal spell! spelllang=es<CR>")
utils.map("n", "<F3>", ":setlocal spell! spelllang=en_us<CR>")

-- Search and replace word
utils.map("n", "cn", [[/\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgn]]) -- replace world and nexts word with .
utils.map("n", "cN", [[?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN]]) -- replace world and prev word with .

-- sudo
-- vim.cmd [[cmap w!! w !sudo tee > /dev/null %]]

-- Tab mappings

for i = 9, 1, -1 do
  local kmap = string.format("<leader>%d", i)
  local command = string.format("%dgt", i)
  utils.map("n", kmap, command, { desc = string.format("Jump Tab %d", i) })
  utils.map("n", string.format("tt%d", i), string.format(":tabmove %d<CR>", i == 1 and 0 or i), { desc = string.format("Tab Move to %d", i) })
end
local maps = {
  {
    prefix = "<leader>t",
    maps = {
      {"s", [[:execute 'set showtabline=' . (&showtabline ==# 0 ? 2 : 0)<CR>]], "Show Tabs"},
      {"n", ":tabnew<CR>", "New Tab"},
      {"o", ":tabonly<CR>", "Tab Only"},
      {"d", ":tabclose<CR>", "Tab Close"},
      {"l", ":tabmove +1<CR>", "Tab Move Right"},
      {"h", ":tabmove -1<CR>", "Tab Move Left"}
    }
  },
  {
    prefix = "<leader>",
    maps = {
      {"w", ":bnext<CR>", "Buffer Next"},
      {"b", ":bprev<CR>", "Buffer Prev"},
      -- Move between splits
      {"k", ":wincmd k<CR>", "Move Up"},
      {"l", ":wincmd l<CR>", "Move Right"},
      {"j", ":wincmd j<CR>", "Move Down"},
      {"h", ":wincmd h<CR>", "Move Left"},
      --Delete search result
      {"c", ':let @/=""<cr>'}
    }
  },
  {
    prefix = "ñ",
    maps = {
      {"s", "/", vim.tbl_extend("force", { desc = "Search" }, opts)},
      {"r", ":%s/", vim.tbl_extend("force", { desc = "Search and Replace" }, opts)},
      {"cw", [[:%s/\<<C-r><C-w>\>/]], vim.tbl_extend("force", { desc = "Replace Word" }, opts)},
      {"d", ":bd<CR>", "Buffer Delete"},
      {"m", require("harpoon.mark").add_file, "Mark File"},
      {"g", require("harpoon.ui").toggle_quick_menu, "Show Files Marked"},
      {"w", require("harpoon.ui").nav_next, "Next File Marked"},
      {"b", require("harpoon.ui").nav_prev, "Prev File Marked"},
      {
        ".",
        function()
          require("harpoon.term").sendCommand(10, vim.api.nvim_replace_termcodes('<C-c> <C-l>', true, true, true))
          vim.loop.sleep(100)
          require("harpoon.term").sendCommand(10, require("code_runner.commands").get_filetype_command() .. "\n")
        end,
        "CodeRunner in Harpoon Term"
      },

      {
        " ",
        function()
          require("harpoon.term").gotoTerminal(10)
        end,
        "Goto Buffer Term"
      },
    }
  },
}
utils.maps(maps)


-- Resize pane
utils.map("n", "<A-Left>", ":vertical resize +5<CR>")
utils.map("n", "<A-Right>", ":vertical resize -5<CR>")
utils.map("n", "<A-Down>", ":resize +5<CR>")
utils.map("n", "<A-Up>", ":resize -5<CR>")

--Move line to up or down
utils.map("n", "J", ":m .+1<CR>==", opts)
utils.map("n", "K", ":m .-2<CR>==", opts)
-- utils.map("i", "J", "<Esc>:m .+1<CR>==gi", opts)
-- utils.map("i", "K", "<Esc>:m .-2<CR>==gi", opts)
utils.map("v", "J", ":m '>+1<CR>gv=gv", opts)
utils.map("v", "K", ":m '<-2<CR>gv=gv", opts)

--Esc in terminal mode
utils.map("t", "<Esc>", "<C-\\><C-n>")
utils.map("t", "<M-[>", "<Esc>")
utils.map("t", "<C-v><Esc>", "<Esc>")
-- utils.map('n', '<bs>', '<c-^>`”zz')
utils.map("n", "<bs>", ":<c-u>exe v:count ? v:count . 'b' : 'b' . (bufloaded(0) ? '#' : 'n')<cr>")

-- Motions
utils.map("n", "ç", "%")

utils.map("n", "<leader>fo", ":TodoTelescope<CR>", { desc = "Todo List" })

local neogen = {
  c = {"class", "Comment Class"},
  f = {"func", "Comment Function"},
  i = {"file", "Comment File"},
  t = {"type", "Comment type"},
}

for k, v in pairs(neogen) do
  utils.map("n", string.format("<Leader>n%s", k), function()
    require("neogen").generate { type = v[1] }
  end, { desc = v[2] })
end

-- diffview.nvim
utils.map("n", "<leader>do", ":DiffviewOpen<CR>", { desc = "Diff Open" })
utils.map("n", "<leader>dc", ":DiffviewClose<CR>", { desc = "Diff Close" })
for i = 9, 1, -1 do
  utils.map("n", string.format("<leader>d%d", i), string.format(":DiffviewOpen HEAD~%d<CR>", i), { desc = string.format("Diff Open HEAD~%d<CR>", i) })
end

-- utils.map("n", "<leader>e", require("code_runner.commands").run_code, opts)
local betterTerm = require('betterTerm')
utils.map("n", "<leader>e", function()
  betterTerm.send(require("code_runner.commands").get_filetype_command(), 1, true)
end, { desc = "Excute File" })

utils.map({"n", "t"}, "<C-ñ>", betterTerm.open, { desc = "Open terminal"})
utils.map({"n", "t"}, "<leader>tt", betterTerm.select, { desc = "Select terminal"})
local current = 2
utils.map(
    {"n", "t"}, "<leader>ti",
    function()
        betterTerm.open(current)
        current = current + 1
    end,
    { desc = "New terminal"}
)
