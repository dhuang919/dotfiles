local utils = require("utils")

local g = vim.g
local o = vim.opt

g.mapleader = " "
g.maplocalleader = "\\"

require("config.autocmds")
require("config.keymaps")
require("config.lazy")

-- NOTE: formatoptions set in autocmds.lua
-- https://neovim.discourse.group/t/options-formatoptions-not-working-when-put-in-init-lua/3746
o.copyindent = true -- preserve indent structure when auto-indenting
o.breakindent = true -- wrapped lines continue visually indented
o.showbreak = string.rep(" ", 2) -- indent wrapped lines by 2 spaces
o.expandtab = true -- use spaces instead of tabs
o.linebreak = true -- wrap at word boundaries, not mid-word
o.mouse = "" -- disable mouse support
o.number = true -- show line numbers
o.showmode = false -- hide mode indicator (shown in statusline)
o.splitbelow = true -- horizontal splits open below
o.splitright = true -- vertical splits open to the right
o.swapfile = false -- disable swap files
o.undofile = true -- persistent undo across sessions
o.wrap = true -- wrap long lines
o.backspace = { "indent", "eol", "start" } -- allow backspace over everything
o.clipboard = { "unnamed", "unnamedplus" } -- use system clipboard
o.scrolloff = 3 -- keep 3 lines visible above/below cursor
o.cursorline = true -- highlight current line
o.laststatus = 3 -- global statusline; required for horizontal pane separators

-- use treesitter for folding
o.foldmethod = "expr"
o.foldlevelstart = 99 -- start with all folds open
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

g.python3_host_prog = vim.fn.expand("~/nvim_venv/bin/python") -- python provider for plugins

-- prefer after/ftplugin over built-in editorconfig
g.editorconfig = false

-- filetype mappings for docker compose files expected by lsps
vim.filetype.add({
  filename = {
    ["compose.yaml"] = "yaml.docker-compose",
    ["compose.yml"] = "yaml.docker-compose",
    ["docker-compose.yaml"] = "yaml.docker-compose",
    ["docker-compose.yml"] = "yaml.docker-compose",
  },
})

-- dynamically enable lsps
local lsps = require("config.lsps")

for name, opts in pairs(lsps) do
  vim.lsp.config(name, opts)
end

vim.lsp.enable(vim.tbl_keys(lsps))

-- make sure yanking works through ssh
if utils.is_ssh() then
  vim.g.clipboard = {
    name = "OSC52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = function()
        return vim.split(vim.fn.getreg("0"), "\n")
      end,
      ["*"] = function()
        return vim.split(vim.fn.getreg("0"), "\n")
      end,
    },
  }
end
