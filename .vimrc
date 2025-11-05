"------ Mechanical Changes -----
set number relativenumber " Relative line numbers
set tabstop=4             " 1 tab = 4 spaces 
set shiftwidth=4          " Number of spaces to use for each step of (auto)indent
set expandtab             " Convert tabs to spaces
set smartindent           " Enable smart autoindenting when starting a new line
set scrolloff=10          " Keep at least 10 lines above and below cursor while scrolling
set sidescrolloff=10      " Keep at least 10 lines above and below the cursor in 
set ignorecase            " Ignore case when searching
set smartcase             " Searching is case-sensitive only if the pattern contains uppercase chars
set textwidth=100         " Set auto word wrap
set wrap                  " Wrap text automatically 
set linebreak             " Prevent wrap from cutting word in half
set clipboard=unnamedplus " Enable system clipboard.
set path+=**              " Allow find command to search down into subfolders
set wildmenu              " Display all matching files for tab complete
set nocompatible          " Don't pretend to be vi

"" netrw                  
syntax enable             " Turn on syntax highlighting
filetype plugin on        " Load plugin file for detected filetype
let g:netrw_banner=0      " Disable annoying banner
let g:netrw_browse_split=4 " Open in prior window
let g:netrw_altv=1        " Open splits to the right
let g:netrw_liststyle=3   " Tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" Tag Jumping
command! MakeTags !ctags -R . " Create tags file


"----- Visual Changes ----- 
" Set sensible highlighting on braces that does not obscure text
highlight MatchParen cterm=underline ctermbg=black ctermfg=NONE
highlight MatchParen gui=underline guibg=black guifg=NONE
set title "Show filename in status line

colorscheme zaibatsu

"----- HOTKEYS -----
" Navigate through visual lines when they are wrapped at the end.
nnoremap j gj
nnoremap k gk
xnoremap j gj
xnoremap k gk

" (DEPECRIATED) 
" USE "ctrl + u" or "ctrl + d" 
" Quicker navigation
" nmap J 5j
" nmap K 5k
" xmap J 5j
" xmap K 5k

" Easier movement between split windows
nmap gh <C-w>h
nmap gj <C-w>j
nmap gk <C-w>k
nmap gl <C-w>l

