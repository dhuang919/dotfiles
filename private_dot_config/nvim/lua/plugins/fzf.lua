return {
  "ibhagwan/fzf-lua",
  dependencies = { "echasnovski/mini.icons" },
  config = function()
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
    { "<leader>fg", "<cmd>FzfLua live grep<cr>", desc = "fzf live grep" },
    { "<leader>fl", "<cmd>FzfLua grep<cr>", desc = "fzf grep" },
    { "<leader>gl", "<cmd>FzfLua grep last<cr>", desc = "fzf grep last" },
    { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "fzf buffers" },
    { "<leader>gc", "<cmd>FzfLua git_commits<cr>", desc = "fzf git commit log" },
  },
}
