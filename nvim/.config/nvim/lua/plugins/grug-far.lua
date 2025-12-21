return {
  "MagicDuck/grug-far.nvim",
  opts = {},
  keys = {
    {
      "<leader>gr",
      function()
        require("grug-far").open({ transient = true })
      end,
      mode = { "n", "v" },
      desc = "Search and Replace",
    },
  },
}
