""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filename .vimrc                                    "
" Maintainer: Brian Tong <btong34[at]gmail[dot]com   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""
" General Vim Behavior                  "
"""""""""""""""""""""""""""""""""""""""""
set nocompatible      " get rid of VI compatibility mode. SET FIRST! 


"""""""""""""""""""""""""""""""""""""""""
" Theme / Colors                        "
"""""""""""""""""""""""""""""""""""""""""
set t_Co=256          " enable 256-color mode
syntax enable         " enable syntax highlighting

"""""""""""""""""""""""""""""""""""""""""
" UI Behavior                           "
"""""""""""""""""""""""""""""""""""""""""
set number            " show line numbers
set ignorecase        " make searches case-insensitive
set ruler             " show info along bottom
set cul               " highlight current line
set backspace=2       " backspace over everything in insert mode
"""""""""""""""""""""""""""""""""""""""""
" Text Formatting / Layout              "
"""""""""""""""""""""""""""""""""""""""""

set nowrap            " dont wrap text
set autoindent        " auto-indent 
set tabstop=4         " tab spacing
set shiftwidth=4      " indent/outdent # of cols
set expandtab         " use spaces instead of tabs
