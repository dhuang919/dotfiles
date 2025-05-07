return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    jump = {
      -- when there's only one match
      autojump = true,
    },
    modes = {
      char = {
        -- exclude ; and ,
        keys = { "f", "F", "t", "T" },
      },
    },
  },
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
    {
      "S",
      mode = { "n", "x", "o" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
    },
  },
}
