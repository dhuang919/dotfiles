return {
  "nvim-treesitter/nvim-treesitter",

  build = ":TSUpdate",

  config = function(_, opts)
    -- TODO: make this dynamic
    -- require("nvim-treesitter.install").command_extra_args = {
    --   curl = {"--proxy", "http://proxy.bloomberg.com:81"}
    -- }
    require("nvim-treesitter.configs").setup(opts)
    vim.opt.foldenable = false
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
  end,

  event = "VeryLazy",

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
