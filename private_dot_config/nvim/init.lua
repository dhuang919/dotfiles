local utils = require("utils")

local a = vim.api
local k = vim.keymap
local g = vim.g
local o = vim.opt

g.mapleader = " "
g.maplocalleader = "\\"

require("config.autocmds")
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

-- disable command mode
k.set("n", "Q", "")
k.set("n", "q:", "")

-- unhighlight with esc
k.set("n", "<Esc>", ":noh<cr>", { desc = "Unhighlight" })

k.set("n", "<leader>o", "o<esc>>>A ", { desc = "New indented line" })
k.set("n", "<leader>w", ":wa<cr>", { desc = "Write all buffers", noremap = true, silent = true })

-- copy file path to clipboard
k.set("n", "<leader>yp", ":let @+=expand('%:.')<cr>", { desc = "Copy relative path" })
k.set("n", "<leader>yP", ":let @+=@%<cr>", { desc = "Copy absolute path" })

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
local servers = require("lsp.servers")

for name, opts in pairs(servers) do
  vim.lsp.config(name, opts)
end

vim.lsp.enable(vim.tbl_keys(servers))

-- make sure yanking works through ssh
if utils.is_ssh() then
  vim.g.clipboard = "osc52"
end
