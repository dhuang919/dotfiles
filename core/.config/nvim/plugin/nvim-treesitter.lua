local gh = require("utils").gh

-- https://github.com/nvim-treesitter/nvim-treesitter
vim.pack.add({
  { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },
}, { confirm = false })

-- Add runtime/queries to runtimepath for fold queries
vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/site/pack/core/opt/nvim-treesitter/runtime")

local parsers = {
  "bash",
  "c",
  "cpp",
  "dockerfile",
  "go",
  "javascript",
  "json",
  "lua",
  "make",
  "markdown",
  "markdown_inline",
  "python",
  "sql",
  "toml",
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
