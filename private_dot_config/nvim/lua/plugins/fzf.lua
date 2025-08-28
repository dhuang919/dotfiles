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
    { "<leader>fo", "<cmd>FzfLua oldfiles<cr>", desc = "fzf old files" },
    { "<leader>fr", "<cmd>FzfLua resume<cr>", desc = "fzf resume" },
    {
      "<leader>fca",
      "<cmd>FzfLua lsp_code_actions<cr>",
      mode = { "n", "v" },
      desc = "fzf lsp code actions",
    },
    { "<leader>fco", "<cmd>FzfLua git_commits<cr>", desc = "fzf git commit log" }, -- not fgc to keep fg fast
    { "<leader>flr", "<cmd>FzfLua lsp_references<cr>", desc = "fzf lsp refs" },
    { "<leader>fls", "<cmd>FzfLua lsp_live_workspace_symbols<cr>", desc = "fzf lsp symbol search" },
    { "<leader>xx", "<cmd>FzfLua diagnostics_document<cr>", desc = "fzf document diagnostics" },
    { "<leader>xw", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "fzf workspace diagnostics" },
  },
}
