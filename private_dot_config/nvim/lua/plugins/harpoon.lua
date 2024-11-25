return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      { "nvim-lua/plenary.nvim", event = "VeryLazy" },
      { "nvim-telescope/telescope.nvim", event = "VeryLazy" },
    },
    keys = function()
      local harpoon = require("harpoon")
      harpoon:setup()

      -- basic telescope configuration
      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require("telescope.pickers")
          .new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
              results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
          })
          :find()
      end

      return {
        -- telescope
        {
          "<leader>fh",
          function()
            toggle_telescope(harpoon:list())
          end,
          desc = "Telescope Harpoon",
        },

        -- ui
        {
          "<a-h>",
          function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Harpoon quick menu",
        },

        {
          "<a-a>",
          function()
            harpoon:list():add()
          end,
          desc = "Harpoon add",
        },
        {
          "<a-p>",
          function()
            harpoon:list():prev()
          end,
          desc = "Harpoon prev",
        },
        {
          "<a-n>",
          function()
            harpoon:list():next()
          end,
          desc = "Harpoon next",
        },
        {
          "<a-1>",
          function()
            harpoon:list():select(1)
          end,
          desc = "Harpoon buf1",
        },
        {
          "<a-2>",
          function()
            harpoon:list():select(2)
          end,
          desc = "Harpoon buf2",
        },
        {
          "<a-3>",
          function()
            harpoon:list():select(3)
          end,
          desc = "Harpoon buf3",
        },
        {
          "<a-4>",
          function()
            harpoon:list():select(4)
          end,
          desc = "Harpoon buf4",
        },
      }
    end,
  },
}
