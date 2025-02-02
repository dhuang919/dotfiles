local actions = require("fzf-lua").actions

return {
  "ibhagwan/fzf-lua",
  dependencies = { "echasnovski/mini.icons" },
  opts = {
    winopts = {
      preview = {
        layout = "vertical",
      },
    },
    grep = {
      actions = {
        ["ctrl-g"] = { actions.grep_lgrep },
        -- uncomment to enable '.gitignore' toggle for grep
        -- ["ctrl-r"]   = { actions.toggle_ignore }
      },
    },
  },
  keys = {
    { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "fzf files" },
    { "<leader>fo", "<cmd>FzfLua oldfiles<cr>", desc = "fzf old files" },
    { "<leader>fl", "<cmd>FzfLua live_grep<cr>", desc = "fzf live grep" },
    { "<leader>fg", "<cmd>FzfLua grep<cr>", desc = "fzf grep" },
    { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "fzf buffers" },
  },
}
