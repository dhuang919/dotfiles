vim.g.mapleader = " "
vim.g.maplocalleader = ","

require("config.autocmds")
require("config.lazy")

-- NOTE: formatoptions set in autocmds.lua
-- https://neovim.discourse.group/t/options-formatoptions-not-working-when-put-in-init-lua/3746
vim.o.breakindent = true
vim.o.expandtab = true
vim.o.linebreak = true
vim.o.mouse = "a"
vim.o.number = true
vim.o.showbreak = string.rep(" ", 2) -- long lines wrap smartly
vim.o.showmode = false
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.undofile = true
vim.o.wrap = true
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.clipboard = { "unnamed", "unnamedplus" }

-- use treesitter for folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevelstart = 99

vim.g.python3_host_prog = vim.fn.expand("~/nvim_venv/bin/python")

-- disable to allow after/ftplugin settings work
vim.g.editorconfig = false

-- custom stuff

-- disabled
-- command mode
vim.keymap.set("n", "Q", "")
vim.keymap.set("n", "q:", "")

-- unhighlight with esc
vim.keymap.set("n", "<Esc>", ":noh<cr>")

-- prev/next buffers
vim.keymap.set("n", "[b", ":bprev<cr>", { noremap = true })
vim.keymap.set("n", "]b", ":bnext<cr>", { noremap = true })

vim.keymap.set("n", "<leader>o", "o<esc>>>A ", { desc = "New indented line" })
vim.keymap.set(
  "n",
  "<leader>w",
  ":wa<cr>",
  { desc = "Write all buffers", noremap = true, silent = true }
)
vim.keymap.set("n", "<leader>h2", function()
  local days = {
    Sunday = "sun",
    Monday = "mon",
    Tuesday = "tues",
    Wednesday = "wed",
    Thursday = "thurs",
    Friday = "fri",
    Saturday = "sat",
  }
  local date = os.date("%m/%d/%y")
  local weekday = days[os.date("%A")]
  -- 01/01/25 mon w newline after
  local lines = { "## " .. date .. " " .. weekday, "" }
  vim.api.nvim_put(lines, "l", true, true)
  vim.api.nvim_feedkeys("kO", "n", false)
end, { desc = "Insert H2 markdown header with date and day of week" })

-- set line number colors in gutter
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#98d2f4" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#cccccc" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#fd9dc0" })
vim.api.nvim_set_hl(0, "Cursor", { reverse = true })
