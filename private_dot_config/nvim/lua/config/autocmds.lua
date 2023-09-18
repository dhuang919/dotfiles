local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup



autocmd("BufEnter", {
  desc = "mini.splitjoin hooks",
  callback = function()
    local msj = require("mini.splitjoin")

    local gen_hook = msj.gen_hook
    local all_bracks = { brackets = { "%b()", "%b[]", "%b{}" } }

    -- Add trailing comma when splitting inside all brackets
    local add_comma_curly = gen_hook.add_trailing_separator(all_bracks)

    -- Delete trailing comma when joining inside all brackets
    local del_comma_curly = gen_hook.del_trailing_separator(all_bracks)

    vim.b.minisplitjoin_config = {
      split = { hooks_post = { add_comma_curly } },
      join  = { hooks_post = { del_comma_curly } },
    }
  end
})

autocmd("BufWritePre", {
  desc = "Auto-format go",
  pattern = "*.go",
  group = augroup("GoFormat", {}),
  callback = function()
    require("go.format").goimport()
  end,
})

autocmd("TextYankPost", {
  desc = "Briefly highlight yanked text",
  callback = function()
    vim.highlight.on_yank()
  end,
})
