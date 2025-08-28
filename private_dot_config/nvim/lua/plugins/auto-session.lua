return {
  "rmagatti/auto-session",
  lazy = false,
  keys = {
    { "<leader>se", "<cmd>AutoSession search<CR>", desc = "Session search" },
    { "<leader>ss", "<cmd>AutoSession save<CR>", desc = "Save session" },
    { "<leader>sr", "<cmd>AutoSession restore<CR>", desc = "Restore session" },
  },
  config = function()
    vim.o.sessionoptions = "blank,buffers,curdir,help,tabpages,winsize,winpos,terminal,localoptions"
    require("auto-session").setup({
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    })
  end,
}
