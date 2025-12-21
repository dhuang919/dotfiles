-- Highlight the indent line, and highlight the code chunk according to the current cursor position.

return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    -- chunk = {
    --   enable = true,
    --   duration = 100,
    --   delay = 200,
    -- },
    indent = {
      enable = true,
      chars = {
        "│",
        "¦",
        "┆",
        "┊",
      },
    },
  },
}
