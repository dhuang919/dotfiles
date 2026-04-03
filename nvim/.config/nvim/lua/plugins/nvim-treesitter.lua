return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "main",
  build = ":TSUpdate",
  config = function()
    -- Add runtime/queries to runtimepath for fold queries
    vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/runtime")

    local parsers = {
      "bash",
      "c",
      "cpp",
      "dockerfile",
      "go",
      "html",
      "javascript",
      "json",
      "lua",
      "make",
      "markdown",
      "markdown_inline",
      "python",
      "rust",
      "sql",
      "toml",
      "tsx",
      "typescript",
      "xml",
      "yaml",
    }

    local installed = require("nvim-treesitter.config").get_installed()
    local missing = vim.tbl_filter(function(lang)
      return not vim.list_contains(installed, lang)
    end, parsers)

    if #missing > 0 then
      vim.cmd("TSInstall " .. table.concat(missing, " "))
    end
  end,
}
