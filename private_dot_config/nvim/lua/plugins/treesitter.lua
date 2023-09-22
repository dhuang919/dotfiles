return {
  "nvim-treesitter/nvim-treesitter",

  event = "VeryLazy",

  build = ":TSUpdate",

  config = function()
    require("nvim-treesitter.configs").setup({
      auto_install = true,
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "csv",
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
    })
  end,
}
