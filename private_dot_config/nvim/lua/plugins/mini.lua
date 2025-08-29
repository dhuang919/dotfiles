return {
  {
    "nvim-mini/mini.ai",
    event = "VeryLazy",
    version = "*",
    config = true,
  },
  {
    "nvim-mini/mini.comment",
    event = "VeryLazy",
    version = "*",
    config = true,
  },
  {
    "nvim-mini/mini.pairs",
    event = "VeryLazy",
    version = "*",
    opts = {
      mappings = {
        -- only auto-insert close when neighbor is newline
        ["("] = { action = "open", pair = "()", neigh_pattern = ".\n" },
        ["["] = { action = "open", pair = "[]", neigh_pattern = ".\n" },
        ["{"] = { action = "open", pair = "{}", neigh_pattern = ".\n" },
        ['"'] = {
          action = "closeopen",
          pair = '""',
          neigh_pattern = ".\n",
          register = { cr = false },
        },
        ["'"] = {
          action = "closeopen",
          pair = "''",
          neigh_pattern = "[^%a].\n",
          register = { cr = false },
        },
        ["`"] = {
          action = "closeopen",
          pair = "``",
          neigh_pattern = ".\n",
          register = { cr = false },
        },
      },
    },
  },
  {
    "nvim-mini/mini.splitjoin",
    event = "VeryLazy",
    version = "*",
    config = true,
  },
  {
    "nvim-mini/mini.surround",
    event = "VeryLazy",
    version = "*",
    opts = {
      mappings = {
        add = "ys", -- sa
        delete = "ds", -- sd
        find = "", -- sf
        find_left = "", -- sF
        highlight = "", -- sh
        replace = "cs", -- sr
        update_n_lines = "", -- sn
      },
      search_method = "cover_or_next",
    },
  },
}
