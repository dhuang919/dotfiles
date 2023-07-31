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

Plug 'morhetz/gruvbox'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'preservim/nerdtree'
Plug 'editorconfig/editorconfig-vim'
Plug 'jiangmiao/auto-pairs'

" Initialize plugin system
call plug#end()

" ============================================
" Editor Options
" ============================================
colorscheme gruvbox
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
let NERDTreeShowHidden=1

set background=dark
set statusline+=%f
set number
set mouse=a
set smartindent
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
set nocp
set backspace=indent,eol,start
set ruler
set statusline+=%#warningmsg#
set statusline+=%*
set hlsearch

map <C-n> :NERDTreeToggle<CR>

filetype plugin indent on

