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

Plug 'jiangmiao/auto-pairs'
Plug 'morhetz/gruvbox'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'preservim/nerdtree'

" Initialize plugin system
call plug#end()

" ============================================
" Editor Options
" ============================================
if !exists('g:os')
  if has('win64') || has ('win32') || has('win16')
    let g:os='Windows'
  else
    let g:os=substitute(system('uname'), '\n', '', '')
  endif
endif

" Already set by vim-plug but kept here for clarity
syntax on
syntax enable
filetype plugin indent on

if (has("termguicolors"))
  set termguicolors
endif

if has('clipboard')
  if has('unnamedplus')
    set clipboard=unnamedplus
  else
    set clipboard=unnamed
  endif
endif

let g:gruvbox_italic=1

colorscheme gruvbox

let mapleader=";"
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_italicize_comments=1
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

set pastetoggle=<F3>
set background=dark
set laststatus=2
set statusline+=%f
set number
set mouse=a
set tabstop=2
set shiftwidth=2
set autoindent
set expandtab
set cursorline
set wildmenu
set showmatch
set splitbelow
set splitright
set nospell
set incsearch
set updatetime=1000
set runtimepath^=~/.vim/bundle/ctrlp.vim
set tags+=.git/tags;~
set nocp
set backspace=indent,eol,start
set ruler
set completeopt+=menuone
set statusline+=%#warningmsg#
set statusline+=%*
set hlsearch

nmap ß <C-w>s

match SpellRare /\s\+$/ " highlight trailing whitespace

" map ctrl-t to tagbar toggle
map <C-t> :TagbarOpen j<CR>

" Map grep to ag
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --color\ -Q\ 

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command='ag %s -l --nocolor -g $BIO_ROOT'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching=0
endif

map <C-K> :Autoformat<cr>
imap <C-K> <c-o>:Autoformat<cr>

" Shortcut to remove trailing whitespace in a file
:nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

filetype plugin on

" Autoclose YCM Preview Window
let g:ycm_autoclose_preview_window_after_completion=1

