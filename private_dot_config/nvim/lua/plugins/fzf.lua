return {
  "ibhagwan/fzf-lua",
  dependencies = { "echasnovski/mini.icons" },
  configure = function()
    local fzf_lua = require("fzf-lua")
    fzf_lua.setup({
      winopts = {
        preview = {
          layout = "vertical",
        },
      },
    })
  end,
  keys = {
    { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "fzf files" },
    { "<leader>fo", "<cmd>FzfLua oldfiles<cr>", desc = "fzf old files" },
    { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "fzf live grep" },
    { "<leader>fl", "<cmd>FzfLua grep<cr>", desc = "fzf grep" },
    { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "fzf buffers" },
  },
}
