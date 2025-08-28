return {
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    version = "*",
    config = true,
  },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    version = "*",
    config = true,
  },
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    version = "*",
    config = true,
  },
  {
    "echasnovski/mini.splitjoin",
    event = "VeryLazy",
    version = "*",
    config = true,
  },
  {
    "echasnovski/mini.surround",
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
