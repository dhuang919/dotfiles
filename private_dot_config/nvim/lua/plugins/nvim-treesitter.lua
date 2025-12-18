return {
  "nvim-treesitter/nvim-treesitter",
  event = "VeryLazy",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.install").prefer_git = true
    require("nvim-treesitter.configs").setup({
      auto_install = true,
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "diff",
        "dockerfile",
        "git_config",
        "git_rebase",
        "gitcommit",
        "gitignore",
        "go",
        "html",
        "javascript",
        "json",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "python",
        "sql",
        "toml",
        "tsx",
        "typescript",
        "xml",
        "yaml",
      },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
