" ============================================
" Plugin Management (vim-plug)
" ============================================

" Install vim-plug if it is not there already. Bootstrapping!
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Start installing plugins. We use .vim/bundle for backwards compatibility
call plug#begin('~/.vim/bundle')

Plug 'editorconfig/editorconfig-vim'
Plug 'dense-analysis/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tyru/open-browser.vim'
Plug 'tyru/open-browser-github.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Language plugins
Plug 'vim-scripts/c.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

" ============================================
" Editor Options
" ============================================
set background=dark
set backspace=indent,eol,start
set clipboard=unnamed
set cursorline
set expandtab
set hlsearch
set incsearch
set mouse=a
set nocp
set nospell
set number
set ruler
set runtimepath^=~/.vim/bundle/ctrlp.vim
set showmatch
set splitbelow
set splitright
set updatetime=1000
set wildmenu

" list all loaded buffers and populate prompt, waiting for a buffer id
nnoremap gb :ls<CR>:b<Space>

filetype plugin indent on

" gruvbox settings
let g:gruvbox_italic=0
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox

" NERDTree settings
let NERDTreeShowHidden = 1
map <C-n> :NERDTreeToggle<CR>
map Q <Nop>

" fzf settings
let g:fzf_layout = { 'down': '40%' }

" vim-airline settings
let g:airline_powerline_fonts = 1
let g:airline_theme='deus'

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.branch = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.readonly = ''
let g:airline_symbols.whitespace = 'Ξ'

" File change settings stolen from https://unix.stackexchange.com/a/383044/517031
" Trigger `autoread` when files change on disk
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
  \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

" Notification after file change
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
