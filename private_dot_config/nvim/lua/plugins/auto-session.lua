return {
  "rmagatti/auto-session",
  lazy = false,
  keys = {
    { "<leader>se", "<cmd>SessionSearch<CR>", desc = "Session search" },
    { "<leader>ss", "<cmd>SessionSave<CR>", desc = "Save session" },
    { "<leader>sr", "<cmd>SessionRestore<CR>", desc = "Restore session" },
  },
  config = function()
    vim.o.sessionoptions = "blank,buffers,curdir,help,tabpages,winsize,winpos,terminal,localoptions"
    require("auto-session").setup({
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    })
  end,
}
