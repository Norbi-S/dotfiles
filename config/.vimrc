"" General
set nocompatible
syntax on
colorscheme molokai

set number          " Disable absolute line numbers
set relativenumber	" Show relative line numbers
set linebreak	" Break lines at word (requires Wrap lines)
set showbreak=+++	" Wrap-broken line prefix
set colorcolumn=80  " 80 chars ruler
set textwidth=100	" Line wrap (number of cols)
set scrolloff=5     " Minimal number of lines viisble above and below cursor
set showmatch	" Highlight matching brace
set hidden

set hlsearch	" Highlight all search results
set smartcase	" Enable smart-case search
set ignorecase	" Always case-insensitive
set incsearch	" Searches for strings incrementally

set autoindent	" Auto-indent new lines
set expandtab	" Use spaces instead of tabs
set shiftwidth=4	" Number of auto-indent spaces
set smartindent	" Enable smart-indent
set smarttab	" Enable smart-tabs
set softtabstop=4	" Number of spaces per Tab

"" Advanced
set ruler	" Show row and column ruler information

set undolevels=1000	" Number of undo levels
set backspace=indent,eol,start	" Backspace behaviour

set term=screen-256color

set autoread        " Auto reload

"" Plugins

so ~/.vim/plugins.vim

" Vim-airline
set noshowmode
let g:airline#extensions#tabline#enabled = 1
let g:bufferline_echo = 0
let g:airline_powerline_fonts = 1
autocmd VimEnter *
    \ let &statusline='%{bufferline#refresh_status()}'
    \ .bufferline#get_status_string()

" NERD Tree
map <C-o> :NERDTreeToggle<CR>

