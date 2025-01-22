""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filename .vimrc                                    "
" Maintainer: Brian Tong <btong34[at]gmail[dot]com   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""
" Load plugins using vim-plug           "
"""""""""""""""""""""""""""""""""""""""""
call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'             " Tree directory
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " fuzzy search NOTE: If encountering errors running :FILES, try reinstalling vim. This config should work on unix with Vim 8.2
Plug 'junegunn/fzf.vim'                " fuzzy search
Plug 'ntpeters/vim-better-whitespace'  " Highlight and trim whitespace
" Plug 'terryma/vim-multiple-cursors'    " Sublime style multiple cursors
Plug 'preservim/nerdcommenter'         " comment stuff like toggling lines
Plug 'vim-airline/vim-airline'         " status line
Plug 'tpope/vim-fugitive'              " git integration
Plug 'junegunn/seoul256.vim'           " seoul256 colorscheme (good for dark)
Plug 'NLKNguyen/papercolor-theme'      " papercolor colorscheme (good for light)
Plug 'sainnhe/everforest'              " everforest colorscheme
Plug 'morhetz/gruvbox'                 " gruvbox colorscheme
Plug 'lifepillar/vim-solarized8'       " soloarized colorscheme
Plug 'mileszs/ack.vim'                 " search tool
Plug 'vim-syntastic/syntastic'         " syntax checks / linting
Plug 'christoomey/vim-tmux-navigator'  " navigate b/w tmux splits and vim splits
Plug 'yggdroot/indentline'

" Language / framework specific plugins
Plug 'mattn/emmet-vim'                 " HTML snippets
Plug 'pangloss/vim-javascript'         " JS syntax
Plug 'maxmellon/vim-jsx-pretty'
"Plug 'vim-erlang/vim-erlang-runtime'   " Erlang
"Plug 'elixir-lang/vim-elixir'          " Elixir syntax
Plug 'vim-ruby/vim-ruby'               " Ruby syntax
Plug 'tpope/vim-rails'                 " Rails
" Plug 'lervag/vimtex'                   " LaTeX support
"Plug 'kchmck/vim-coffee-script'        " Coffeescript
Plug 'posva/vim-vue'                   " VueJS
Plug 'briancollins/vim-jst'            " JST/EJS syntax
Plug 'ngmy/vim-rubocop'                " Rubocop
Plug 'eslint/eslint'                   " eslint
" Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'amadeus/vim-mjml'                " mjml syntax support
Plug 'github/copilot.vim'              " Github copilot will take my job :(

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
:autocmd BufWinEnter * let &foldlevel = max(map(range(1, line('$')), 'foldlevel(v:val)')) " Don't fold on start

"""""""""""""""""""""""""""""""""""""""""
" Theme / Colors                        "
"""""""""""""""""""""""""""""""""""""""""
if has('termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

set t_Co=256                      " enable 256-color mode
syntax enable                     " enable syntax highlighting
let g:seoul256_background = 235   " background darkness (233 darkest - 239 lightest)
colorscheme seoul256              " colorscheme from plugin above
set background=dark               " toggle light/dark
" colorscheme PaperColor          " use in conjunction with backgrond=light
" colorscheme everforest          " use in conjunction with backgrond=light
hi CursorLine   cterm=NONE ctermbg=16 ctermfg=NONE
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
" set foldmethod=syntax " enable code folding
let g:vim_json_conceal=0 " Override IndentLine's conceal behavior for JSON files (so double quotes are shown)

let g:xml_syntax_folding = 0

"""""""""""""""""""""""""""""""""""""""""
" Language Specific Configuration         "
"""""""""""""""""""""""""""""""""""""""""
autocmd FileType vue setlocal shiftwidth=2 softtabstop=2 expandtab
au BufRead,BufNewFile *.rabl setf ruby " treat .rabl as .rb file

"""""""""""""""""""""""""""""""""""""""""
" Plugin Specific Configuration         "
"""""""""""""""""""""""""""""""""""""""""

" vim-better-whitespace
autocmd BufWritePre * StripWhitespace

" nerdcommenter
filetype plugin on              " used for nerdcommenter
let g:NERDSpaceDelims = 1       " add a space after comment delimiters by default
let g:NERDDefaultAlign = 'left' " align delimiters to the left

" Add hooks for switching delimiters within Vue files (html, css, js)
let g:ft = ''
function! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
      endif
    endif
  endif
endfunction
function! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    let g:ft = ''
  endif
endfunction

" nerdtree
nmap <leader>nt :NERDTreeToggle<cr>
nmap <leader>nf :NERDTreeFind<cr>
let NERDTreeIgnore = ['node_modules']
let NERDTreeQuitOnOpen=1
let NERDTreeWinSize=42

" Needed bc setting vim-json-conceal to 0 reveals brackets around folders in
" nerdtree
exec 'autocmd filetype nerdtree set conceallevel=3'
exec 'autocmd filetype nerdtree set concealcursor=nvic'

" nerdtree-syntax-highlighting
let g:NERDTreeLimitedSyntax = 1


" fzf

" ctrl+p opens up fzf pane
" change popup to anchor to bottom, with full width, and half height
nnoremap <silent> <C-p> :Files<CR>
let g:fzf_layout = { 'window': { 'width': 1.0, 'height': 0.5, 'relative': v:true, 'yoffset': 1.0 } }

" ack.vim
let g:ackprg = 'ag --nogroup --nocolor --column'

""""""""""""""
" coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json',
  \ ]
" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

command! -nargs=0 Prettier :CocCommand prettier.formatFile

"""""""""""" END coc config """""""""""""""

" vim-jsx
let g:jsx_ext_required = 0 " enable jsx highlighting even for non *.jsx files

" vim-airline
" let g:airline#extensions#branch#enabled = 1
let g:airline_section_b = fnamemodify(getcwd(), ':t')
let g:airline_section_x = ''
let g:airline_section_y = ''
let g:airline_section_z = airline#section#create(['branch'])

" Recognize Jenkinsfile as groovy syntax
autocmd BufRead,BufNewFile Jenkinsfile set filetype=groovy
