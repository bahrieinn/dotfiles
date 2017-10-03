""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filename .vimrc                                    "
" Maintainer: Brian Tong <btong34[at]gmail[dot]com   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""
" Load plugins using vim-plug           "
"""""""""""""""""""""""""""""""""""""""""
call plug#begin()

Plug 'scrooloose/nerdtree'             " Tree directory
Plug 'kien/ctrlp.vim'                  " fuzzy search
Plug 'ntpeters/vim-better-whitespace'  " Highlight and trim whitespace
Plug 'terryma/vim-multiple-cursors'    " Sublime style multiple cursors
Plug 'scrooloose/nerdcommenter'        " comment stuff like toggling lines
Plug 'vim-airline/vim-airline'         " status line
Plug 'tpope/vim-fugitive'              " git integration
Plug 'jacoborus/tender'                " colorscheme
Plug 'mileszs/ack.vim'                 " search tool
Plug 'valloric/youcompleteme'          " autocomplete plugin that works with a compiled component (pre-req MacVim)
Plug 'vim-syntastic/syntastic'         " syntax checks / linting

" Language / framework specific plugins
Plug 'mattn/emmet-vim'                 " HTML snippets
Plug 'pangloss/vim-javascript'         " JS syntax
Plug 'mxw/vim-jsx'                     " JSX (depends on ^ pangloss/vim-javascript)
Plug 'vim-erlang/vim-erlang-runtime'   " Erlang
Plug 'elixir-lang/vim-elixir'          " Elixir syntax
Plug 'vim-ruby/vim-ruby'               " Ruby syntax
Plug 'tpope/vim-rails'                 " Rails
Plug 'lervag/vimtex'                   " LaTeX support
Plug 'kchmck/vim-coffee-script'        " Coffeescript
call plug#end()

"""""""""""""""""""""""""""""""""""""""""
" General Vim Behavior                  "
"""""""""""""""""""""""""""""""""""""""""
set nocompatible              " get rid of VI compatibility mode. SET FIRST!
:let mapleader = ","          " map leader key to ','
:set noswapfile               " swap files are not that helpful anymore
:command W w                  " map W to w so it save happens anyway
:command Q q                  " map Q to q
vmap <C-c> :w !pbcopy<CR><CR> " CTRL+c to copy to clipboard
nnoremap z<space> za          " map code fold toggle to 'z space'

"""""""""""""""""""""""""""""""""""""""""
" Theme / Colors                        "
"""""""""""""""""""""""""""""""""""""""""
set t_Co=256                      " enable 256-color mode
syntax enable                     " enable syntax highlighting
colorscheme tender                " colorscheme from plugin above

"""""""""""""""""""""""""""""""""""""""""
" UI Behavior                           "
"""""""""""""""""""""""""""""""""""""""""
set number            " show line numbers
set ignorecase        " make searches case-insensitive
set ruler             " show info along bottom
set cursorline        " show cursorline
set backspace=2       " backspace over everything in insert mode
set laststatus=2      " always display status line
set ttyfast           " ttyfast and lazyredraw both perf optimizations
set lazyredraw

"""""""""""""""""""""""""""""""""""""""""
" Text Formatting / Layout              "
"""""""""""""""""""""""""""""""""""""""""
set nowrap            " dont wrap text
set autoindent        " auto-indent
set tabstop=2         " tab spacing
set shiftwidth=2      " indent/outdent # of cols
set expandtab         " use spaces instead of tabs


"""""""""""""""""""""""""""""""""""""""""
" Plugin Specific Configuration         "
"""""""""""""""""""""""""""""""""""""""""

" vim-better-whitespace
autocmd BufWritePre * StripWhitespace

" nerdcommenter
filetype plugin on    " used for nerdcommenter

" nerdtree
nmap <leader>nt :NERDTreeToggle<cr>
let NERDTreeIgnore = ['node_modules']
let NERDTreeQuitOnOpen=1
let NERDTreeWinSize=42

" CtrlP
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_custom_ignore = '\v[\/](node_modules)|(\.(swp|ico|git|svn))$'
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files --exclude-standard -co']
let g:ctrlp_dont_split = 'NERD' " only take over nerdtree window on initial open
let g:ctrlp_max_files = 0
let g:ctrlp_max_depth = 40

" ack.vim
let g:ackprg = 'ag --nogroup --column' " use silver searcher as backend for ack

" vim-jsx
let g:jsx_ext_required = 0 " enable jsx highlighting even for non *.jsx files

