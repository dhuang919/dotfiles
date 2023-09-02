return {
  "nvim-treesitter/nvim-treesitter",

  build = ":TSUpdate",

  config = true,

  opts = {
    auto_install = true,
    ensure_installed = {
      "bash",
      "c",
      "css",
      "dockerfile",
      "git_config",
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
    modules = {
      highlight = {
        enable = true,
      },
    },
  },
}
