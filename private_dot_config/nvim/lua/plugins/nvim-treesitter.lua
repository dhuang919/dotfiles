return {
  "nvim-treesitter/nvim-treesitter",

  build = ":TSUpdate",

  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,

  opts = {
    auto_install = true,
    ensure_installed = {
      "bash",
      "c",
      "dockerfile",
      "git_config",
      "go",
      "javascript",
      "jq",
      "json",
      "lua",
      "make",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "regex",
      "rust",
      "sql",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "xml",
      "yaml",
    },
    highlight = {
      enable = true,
    },
  },
}
