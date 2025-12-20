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
o.copyindent = true
o.breakindent = true
o.showbreak = string.rep(" ", 2) -- indent second line when wrapping
o.expandtab = true
o.linebreak = true
o.mouse = ""
o.number = true
o.showmode = false
o.splitbelow = true
o.splitright = true
o.swapfile = false
o.undofile = true -- persistent undo
o.wrap = true
o.backspace = { "indent", "eol", "start" }
o.clipboard = { "unnamed", "unnamedplus" }
o.scrolloff = 3 -- always keep 3 lines above/below the cursor
o.cursorline = true

-- use treesitter for folding
o.foldmethod = "expr"
o.foldlevelstart = 99
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

g.python3_host_prog = vim.fn.expand("~/nvim_venv/bin/python")

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
      ["+"] = function() return vim.split(vim.fn.getreg("0"), "\n") end,
      ["*"] = function() return vim.split(vim.fn.getreg("0"), "\n") end,
    },
  }
end
