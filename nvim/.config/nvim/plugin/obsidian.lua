local k = vim.keymap
local utils = require("utils")

if utils.is_ssh() then
  return
end

-- https://github.com/obsidian-nvim/obsidian.nvim
vim.pack.add({
  { src = utils.gh("obsidian-nvim/obsidian.nvim") },
})

require("obsidian").setup({
  ui = { enable = false },
  footer = { enabled = false },
  legacy_commands = false,
  workspaces = { { name = "notes", path = "~/dev/notes" } },
  picker = { name = "fzf-lua" },
  frontmatter = { enabled = false },
})

k.set(
  "n",
  "<leader>qs",
  "<cmd>Obsidian quick_switch<cr>",
  { desc = "Obsidian Quick Switch" }
)
k.set(
  "n",
  "<leader>ch",
  function()
    local line = vim.api.nvim_get_current_line()
    local oa = require("obsidian.actions")
    if line:match("%[x%]") then
      oa.set_checkbox(" ")
    else
      oa.set_checkbox("x")
    end
  end,
  { buffer = true, desc = "Toggle checkbox done" }
)
