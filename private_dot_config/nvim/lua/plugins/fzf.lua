return {
  "ibhagwan/fzf-lua",
  dependencies = { "echasnovski/mini.icons" },
  config = function()
    local fzflua = require("fzf-lua")
    local default_rgopts = fzflua.defaults.grep.rg_opts
    fzflua.setup({
      actions = {
        files = {
          true,
          ["ctrl-x"] = fzflua.actions.file_split,
        },
      },
      grep = {
        rg_opts = "--sortr=modified " .. default_rgopts,
      },
      winopts = {
        preview = {
          layout = "vertical",
        },
      },
    })
  end,
  keys = {
    { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "fzf buffers" },
    { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "fzf files" },
    { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "fzf live grep" },
    { "<leader>fl", "<cmd>FzfLua grep<cr>", desc = "fzf grep" },
    { "<leader>fo", "<cmd>FzfLua oldfiles<cr>", desc = "fzf old files" },
    { "<leader>fr", "<cmd>FzfLua resume<cr>", desc = "fzf resume" },
    { "<leader>gc", "<cmd>FzfLua git_commits<cr>", desc = "fzf git commit log" },
    { "<leader>gl", "<cmd>FzfLua grep last<cr>", desc = "fzf grep last" },
  },
}
