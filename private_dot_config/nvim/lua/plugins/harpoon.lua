return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = function()
      local harpoon = require("harpoon")
      harpoon:setup()
      return {
        {
          "<M-q>",
          function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Harpoon quick menu",
        },

        {
          "<M-a>",
          function()
            harpoon:list():add()
          end,
          desc = "Harpoon add",
        },
        {
          "<M-[>",
          function()
            harpoon:list():prev()
          end,
          desc = "Harpoon prev",
        },
        {
          "<M-]>",
          function()
            harpoon:list():next()
          end,
          desc = "Harpoon next",
        },
        {
          "<M-1>",
          function()
            harpoon:list():select(1)
          end,
          desc = "Harpoon buf1",
        },
        {
          "<M-2>",
          function()
            harpoon:list():select(2)
          end,
          desc = "Harpoon buf2",
        },
        {
          "<M-3>",
          function()
            harpoon:list():select(3)
          end,
          desc = "Harpoon buf3",
        },
        {
          "<M-4>",
          function()
            harpoon:list():select(4)
          end,
          desc = "Harpoon buf4",
        },
      }
    end,
  },
}
