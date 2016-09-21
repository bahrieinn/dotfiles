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
Plug 'flazz/vim-colorschemes'          " Set of colorschemes
Plug 'ntpeters/vim-better-whitespace'  " Highlight and trim whitespace
Plug 'terryma/vim-multiple-cursors'    " Sublime style multiple cursors
Plug 'scrooloose/nerdcommenter'        " comment stuff like toggling lines
Plug 'nathanaelkane/vim-indent-guides' " indent guides
Plug 'vim-airline/vim-airline'         " status line

" Language / framework specific plugins
Plug 'mattn/emmet-vim'                 " HTML snippets
Plug 'pangloss/vim-javascript'         " JS syntax
Plug 'vim-erlang/vim-erlang-runtime'   " Erlang
Plug 'elixir-lang/vim-elixir'          " Elixir syntax
Plug 'vim-ruby/vim-ruby'               " Ruby syntax
Plug 'tpope/vim-rails'                 " Rails

call plug#end()

"""""""""""""""""""""""""""""""""""""""""
" General Vim Behavior                  "
"""""""""""""""""""""""""""""""""""""""""
set nocompatible      " get rid of VI compatibility mode. SET FIRST!
:let mapleader = ","  " map leader key to ','

"""""""""""""""""""""""""""""""""""""""""
" Theme / Colors                        "
"""""""""""""""""""""""""""""""""""""""""
set t_Co=256                      " enable 256-color mode
syntax enable                     " enable syntax highlighting
colorscheme tomorrow-night-bright " a bunch of colorschemes available from vim-colorschemes package

"""""""""""""""""""""""""""""""""""""""""
" UI Behavior                           "
"""""""""""""""""""""""""""""""""""""""""
set number            " show line numbers
set ignorecase        " make searches case-insensitive
set ruler             " show info along bottom
set cul               " highlight current line
set backspace=2       " backspace over everything in insert mode
set laststatus=2      " always display status line

"""""""""""""""""""""""""""""""""""""""""
" Text Formatting / Layout              "
"""""""""""""""""""""""""""""""""""""""""
set nowrap            " dont wrap text
set autoindent        " auto-indent
set tabstop=4         " tab spacing
set shiftwidth=4      " indent/outdent # of cols
set expandtab         " use spaces instead of tabs


"""""""""""""""""""""""""""""""""""""""""
" Plugin Specific Configuration         "
"""""""""""""""""""""""""""""""""""""""""

" vim-better-whitespace
autocmd BufWritePre * StripWhitespace

" nerdcommenter
filetype plugin on    " used for nerdcommenter
