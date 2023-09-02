require("config.autocmd")
require("config.lazy")


vim.opt.backspace = {"indent", "eol", "start"}
vim.opt.clipboard = {"unnamed", "unnamedplus"}
vim.opt.formatoptions = vim.opt.formatoptions + {
  c = false,
  o = false, -- O and o don't continue comments
  r = true, -- Return will continue comments
}

vim.o.expandtab = true
vim.o.mouse = "a"
vim.o.number = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.termguicolors = true

vim.g.python3_host_prog = vim.fn.expand("~/nvim_venv/bin/python")
vim.g.tmux_navigator_save_on_switch = 2


-- disable stuff
vim.keymap.set("n", "Q", "<Nop>")
vim.keymap.set("n", "q:", "<Nop>")


-- Easily view and switch buffers
vim.keymap.set("n", "gb", ":ls<CR>:b<Space>", { noremap = true })
