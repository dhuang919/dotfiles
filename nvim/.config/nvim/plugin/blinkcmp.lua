local gh = require("utils").gh

-- https://github.com/saghen/blink.cmp
-- https://main.cmp.saghen.dev
vim.pack.add({
  { src = gh("saghen/blink.lib"), version = vim.version.range("*") },
  { src = gh("saghen/blink.cmp"), version = vim.version.range("*") },
})

local cmp = require("blink.cmp")
cmp.build():pwait()
cmp.setup({
  -- 'default' for mappings similar to built-in completion
  -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
  -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
  keymap = { preset = "enter" },
  completion = {
    documentation = { auto_show = false },
    list = {
      max_items = 10,
      selection = { preselect = false, auto_insert = false },
    },
  },
  appearance = { nerd_font_variant = "mono" },
  sources = { default = { "lsp", "path", "snippets", "buffer" } },
  fuzzy = { implementation = "rust" },
})
