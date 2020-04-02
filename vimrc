""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filename .vimrc                                    "
" Maintainer: Brian Tong <btong34[at]gmail[dot]com   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""
" Load plugins using vim-plug           "
"""""""""""""""""""""""""""""""""""""""""
call plug#begin()

Plug 'scrooloose/nerdtree'             " Tree directory
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " fuzzy search
Plug 'junegunn/fzf.vim'                " fuzzy search
Plug 'ntpeters/vim-better-whitespace'  " Highlight and trim whitespace
Plug 'terryma/vim-multiple-cursors'    " Sublime style multiple cursors
Plug 'scrooloose/nerdcommenter'        " comment stuff like toggling lines
Plug 'vim-airline/vim-airline'         " status line
Plug 'tpope/vim-fugitive'              " git integration
Plug 'junegunn/seoul256.vim'           " seoul256 colorscheme
Plug 'mileszs/ack.vim'                 " search tool
Plug 'vim-syntastic/syntastic'         " syntax checks / linting
Plug 'christoomey/vim-tmux-navigator'  " navigate b/w tmux splits and vim splits
Plug 'yggdroot/indentline'

" Language / framework specific plugins
Plug 'mattn/emmet-vim'                 " HTML snippets
Plug 'pangloss/vim-javascript'         " JS syntax
Plug 'mxw/vim-jsx'                     " JSX (depends on ^ pangloss/vim-javascript)
"Plug 'vim-erlang/vim-erlang-runtime'   " Erlang
"Plug 'elixir-lang/vim-elixir'          " Elixir syntax
Plug 'vim-ruby/vim-ruby'               " Ruby syntax
Plug 'tpope/vim-rails'                 " Rails
Plug 'lervag/vimtex'                   " LaTeX support
"Plug 'kchmck/vim-coffee-script'        " Coffeescript
Plug 'posva/vim-vue'                   " VueJS

call plug#end()

"""""""""""""""""""""""""""""""""""""""""
" General Vim Behavior                  "
"""""""""""""""""""""""""""""""""""""""""
set nocompatible              " get rid of VI compatibility mode. SET FIRST!
let mapleader = ","           " map leader key to ','
set noswapfile                " swap files are not that helpful anymore
command! W w                  " map W to w so it save happens anyway
command! Q q                  " map Q to q
vmap <C-c> :w !pbcopy<CR><CR> " CTRL+c to copy to clipboard
nnoremap z<space> za          " map code fold toggle to 'z space'

"""""""""""""""""""""""""""""""""""""""""
" Theme / Colors                        "
"""""""""""""""""""""""""""""""""""""""""
set t_Co=256                      " enable 256-color mode
syntax enable                     " enable syntax highlighting
let g:seoul256_background = 235   " background darkness (233 darkest - 239 lightest)
colorscheme seoul256              " colorscheme from plugin above
set background=dark               " toggle light/dark
"set background=light

"""""""""""""""""""""""""""""""""""""""""
" UI Behavior                           "
"""""""""""""""""""""""""""""""""""""""""
set number            " show line numbers
set ignorecase        " make searches case-insensitive
set ruler             " show info along bottom
set cursorline        " show cursorline
set cursorcolumn
set hlsearch          " highlight searching
set incsearch         " search as you type
set smartcase         " lets you search for ALL CAPS
set backspace=2       " backspace over everything in insert mode
set laststatus=2      " always display status line
set ttyfast           " ttyfast and lazyredraw both perf optimizations
set lazyredraw
set scroll=4          " number of lines to scroll with ^U/^D
set showmatch
set scrolloff=5       " keep cursor this many lines away from top/bottom of screen
set colorcolumn=110   " show vertical bar at column 110 for line length

"""""""""""""""""""""""""""""""""""""""""
" Text Formatting / Layout              "
"""""""""""""""""""""""""""""""""""""""""
set nowrap            " dont wrap text
set autoindent        " auto-indent
set tabstop=2         " tab spacing
set shiftwidth=2      " indent/outdent # of cols
set expandtab         " use spaces instead of tabs

let g:xml_syntax_folding = 0

"""""""""""""""""""""""""""""""""""""""""
" Language Specific Configuration         "
"""""""""""""""""""""""""""""""""""""""""
autocmd FileType vue setlocal shiftwidth=2 softtabstop=2 expandtab

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

" fzf
nnoremap <silent> <C-p> :Files<CR>

" vim-jsx
let g:jsx_ext_required = 0 " enable jsx highlighting even for non *.jsx files

" vim-airline
let g:airline_section_x = ''
let g:airline_section_y = ''
let g:airline_section_z = ''
