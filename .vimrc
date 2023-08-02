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
Plug 'preservim/nerdtree'
Plug 'editorconfig/editorconfig-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" Language plugins
Plug 'vim-scripts/c.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Initialize plugin system
call plug#end()

" ============================================
" Editor Options
" ============================================
let g:gruvbox_italic=0
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox
let NERDTreeShowHidden=1

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
set smartindent
set splitbelow
set splitright
set statusline+=%#warningmsg#
set statusline+=%*
set statusline+=%f
set updatetime=1000
set wildmenu

map <C-n> :NERDTreeToggle<CR>
map Q <Nop>

filetype plugin indent on

