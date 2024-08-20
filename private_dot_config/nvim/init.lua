require("config.autocmds")
require("config.lazy")

vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.clipboard = { "unnamed", "unnamedplus" }

vim.o.expandtab = true
vim.o.formatoptions = "jrl"
vim.o.linebreak = true
vim.o.mouse = "a"
vim.o.number = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.undofile = true

-- Use treesitter for folding
vim.o.foldenable = false
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"

vim.g.python3_host_prog = vim.fn.expand("~/nvim_venv/bin/python")

-- Save all unwritten buffers when switching to a tmux pane
vim.g.tmux_navigator_save_on_switch = 2

-- Custom stuff

-- Unhighlight with esc
vim.keymap.set("n", "<Esc>", ":noh<cr>")

-- Easily view and switch buffers
vim.keymap.set("n", "gb", ":ls<cr>:b", { noremap = true })

-- Open oil.nvim
vim.keymap.set("n", "-", "<cmd>:Oil<cr>")

-- Set line number colors in gutter
vim.api.nvim_set_hl(0, "LineNrAbove", {fg="#51B3EC", bold=true})
vim.api.nvim_set_hl(0, "LineNr", {fg="white", bold=true})
vim.api.nvim_set_hl(0, "LineNrBelow", {fg="#FB508F", bold=true})

-- Disabled stuff

-- Command mode
vim.keymap.set("n", "Q", "")
vim.keymap.set("n", "q:", "")
