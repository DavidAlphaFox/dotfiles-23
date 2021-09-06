local snippets = require'snippets'
snippets.set_ux(require'snippets.inserters.vim_input')
local U = require'snippets.utils'
local function loadsnip(language)
  return require('config.lsp.snippets.' .. language)
end
snippets.snippets = {
  lua = loadsnip('luasnip'),
  python = loadsnip('python'),
  _global = {
    -- If you aren't inside of a comment, make the line a comment.
    copyright = U.force_comment [[Copyright (C) Ashkan Kiani ${=os.date("%Y")}]];
  };
}
