return {
  "rmagatti/auto-session",
  dependencies = "ibhagwan/fzf-lua",
  lazy = false,
  keys = {
    { "<leader>se", "<cmd>AutoSession search<CR>", desc = "Session search" },
    { "<leader>ss", "<cmd>AutoSession save<CR>", desc = "Save session" },
  },
  config = function()
    vim.o.sessionoptions = "blank,buffers,curdir,help,tabpages,winsize,winpos,terminal"
    require("auto-session").setup({
      auto_save = false,
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    })
  end,
}
