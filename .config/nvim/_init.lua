local opt = vim.opt
local api = vim.api
local call = vim.call
local cmd = vim.cmd
local g = vim.g
local keymap = vim.keymap

cmd([[
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif

  " Start installing plugins. We use .vim/bundle for backwards compatibility
  call plug#begin('~/.vim/bundle')

  Plug 'dense-analysis/ale'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'jiangmiao/auto-pairs'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'morhetz/gruvbox'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'preservim/nerdtree'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'tyru/open-browser-github.vim'
  Plug 'tyru/open-browser.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'williamboman/mason.nvim'

  " Language plugins
  Plug 'vim-scripts/c.vim'
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

  call plug#end()  
]])

opt.background = "dark"
opt.backspace = {"indent", "eol", "start"}
opt.clipboard = {"unnamed", "unnamedplus"}
opt.cursorline = true
opt.expandtab = true
opt.hlsearch = true
opt.incsearch = true
opt.mouse = "a"
-- opt.nocp = true
-- opt.nospell = true
opt.number = true
opt.ruler = true
opt.showmatch = true
opt.splitbelow = true
opt.splitright = true
opt.updatetime = 1000
opt.wildmenu = true

keymap.set("n", "gb", ":ls<CR>:b<Space> ", {noremap = true, silent = true})

cmd([[ filetype plugin indent on ]])

g.gruvbox_italic = 0
g.gruvbox_contrast_dark = "hard"
cmd.colorscheme = "gruvbox"

keymap.set({"n", "v", "o"}, "<C-n>", ":NERDTreeToggle<CR>")
keymap.set({"n", "v", "o"}, "Q", "<Nop>")

-- fzf settings
-- g.fzf_layout = {"down" = "40%"}

-- vim-airline settings
g.airline_powerline_fonts = 1
g.airline_theme="deus"

g.airline_left_sep = ""
g.airline_left_alt_sep = ""
g.airline_right_sep = ""
g.airline_right_alt_sep = ""

if not g.airline_symbols then
  g.airline_symbols = {}
end
g.airline_symbols.branch = ""
g.airline_symbols.linenr = ""
g.airline_symbols.paste = "Þ"
g.airline_symbols.readonly = ""
g.airline_symbols.whitespace = "Ξ"

-- File change settings stolen from https://unix.stackexchange.com/a/383044/517031
-- Trigger `autoread` when files change on disk
-- cmd([[ autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif ]])

-- Notification after file change
-- cmd([[ autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None ]])

g.python3_host_prog = "/Users/derek/nvim_venv/bin/python"

