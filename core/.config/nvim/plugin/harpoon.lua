local k = vim.keymap
local gh = require("utils").gh

-- https://github.com/ThePrimeagen/harpoon
vim.pack.add({
  { src = gh("nvim-lua/plenary.nvim") },
  { src = gh("ThePrimeagen/harpoon"), version = "harpoon2" },
}, { confirm = false })

local h = require("harpoon").setup()

k.set(
  "n",
  "<leader>a",
  function() h:list():add() end,
  { desc = "Harpoon add" }
)
k.set(
  "n",
  "<leader>h",
  function() h.ui:toggle_quick_menu(h:list()) end,
  { desc = "Harpoon quick menu" }
)
k.set(
  "n",
  "<leader>[",
  function() h:list():prev() end,
  { desc = "Harpoon prev" }
)
k.set(
  "n",
  "<leader>]",
  function() h:list():next() end,
  { desc = "Harpoon next" }
)

for i = 1, 9 do
  k.set(
    "n",
    "<leader>" .. i,
    function()
      h:list():select(i)
    end,
    { desc = "Harpoon to file " .. i }
  )
end

-- Put today's daily note and put it in the first slot, replacing yesterday's note
k.set("n", "<leader>A", function()
  -- assumes this is being run from ~/dev/notes
  local path = vim.fs.joinpath(
    "scratch",
    os.date("%Y/%m/%d_%a"):lower() .. ".md"
  )

  -- open today's note
  vim.cmd.edit(path)

  -- replace_at overwrites slot 1 in place, so yesterday's note leaves the list
  -- without shifting the rest or leaving a hole.
  local list = h:list()
  list:replace_at(1, list.config.create_list_item(list.config, path))
end, { desc = "Harpoon put daily note first" })
