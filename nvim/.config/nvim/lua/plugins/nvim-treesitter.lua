return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "main",
  build = ":TSUpdate",
  config = function()
    -- Add runtime/queries to runtimepath for fold queries
    vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/runtime")
    require("nvim-treesitter").setup({ auto_install = true })
  end,
}
