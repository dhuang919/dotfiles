-- only auto-close if right neighbor is nothing (eol) or close
-- for example: (cursor = |) |print -> "|print, *not* "|"print
local right_eol_or_close = "[\n%)%]}'\"`]"

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
        ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]" .. right_eol_or_close },
        ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]" .. right_eol_or_close },
        ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]" .. right_eol_or_close },
        ['"'] = {
          action = "closeopen",
          pair = '""',
          neigh_pattern = "[^\\]" .. right_eol_or_close,
          register = { cr = false },
        },
        ["'"] = {
          action = "closeopen",
          pair = "''",
          neigh_pattern = "[^%a\\]" .. right_eol_or_close,
          register = { cr = false },
        },
        ["`"] = {
          action = "closeopen",
          pair = "``",
          neigh_pattern = "[^\\]" .. right_eol_or_close,
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
