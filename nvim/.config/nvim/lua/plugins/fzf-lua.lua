return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-mini/mini.icons" },
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
    { "<leader>fr", "<cmd>FzfLua resume<cr>", desc = "fzf resume" },
    {
      "<leader>fca",
      "<cmd>FzfLua lsp_code_actions<cr>",
      mode = { "n", "v" },
      desc = "fzf lsp code actions",
    },
    { "<leader>flr", "<cmd>FzfLua lsp_references<cr>", desc = "fzf lsp refs" },
  },
}
