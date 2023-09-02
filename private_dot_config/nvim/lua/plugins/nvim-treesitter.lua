return {
  "nvim-treesitter/nvim-treesitter",

  build = ":TSUpdate",

  auto_install = true,

  opts = {
    ensure_installed = {
      "bash",
      "c",
      "html",
      "javascript",
      "json",
      "lua",
      "luadoc",
      "markdown",
      "python",
      "query",
      "regex",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
    },
  },
}
