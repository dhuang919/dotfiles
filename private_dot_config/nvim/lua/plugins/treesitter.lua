return {
  "nvim-treesitter/nvim-treesitter",

  build = ":TSUpdate",

  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
  end,

  opts = {
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
  },
}
