require("config.lazy")


-- TODO: move to tmux nav
vim.g.tmux_navigator_save_on_switch = 2


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
-- TODO: move to navic
vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
vim.g.python3_host_prog = vim.fn.expand("~/nvim_venv/bin/python")


-- disable stuff
vim.keymap.set("n", "Q", "<Nop>")
vim.keymap.set("n", "q:", "<Nop>")


-- TODO: move to nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


-- Easily view and switch buffers
vim.keymap.set("n", "gb", ":ls<CR>:b<Space>", { noremap = true })


-- File change settings stolen from https://unix.stackexchange.com/a/383044/517031
vim.api.nvim_create_autocmd({"FocusGained", "BufEnter", "CursorHold", "CursorHoldI"}, {
  command = "if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif",
  pattern = {"*"},
})


-- Notification after file change
vim.api.nvim_create_autocmd({"FileChangedShellPost"}, {
  command = "echohl WarningMsg | echo 'File changed on disk. Buffer reloaded.' | echohl None",
  pattern = {"*"},
})

