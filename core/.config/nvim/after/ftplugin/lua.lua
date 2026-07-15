local msj = require("mini.splitjoin")

local gen_hook = msj.gen_hook
local all_bracks = { brackets = { "%b()", "%b[]", "%b{}" } }

-- Add trailing comma when splitting inside all brackets
local add_comma_curly = gen_hook.add_trailing_separator(all_bracks)

-- Delete trailing comma when joining inside all brackets
local del_comma_curly = gen_hook.del_trailing_separator(all_bracks)

-- Pad curly brackets with single space after join
local pad_curly = gen_hook.pad_brackets(all_bracks)

vim.b.minisplitjoin_config = {
  split = { hooks_post = { add_comma_curly } },
  join = { hooks_post = { del_comma_curly, pad_curly } },
}

vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2
