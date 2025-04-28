" Set relative line numbers
set number relativenumber

" Set the number of spaces tabs count for
set tabstop=4

" Sets the number of spaces to use for each step of (auto)indent
set shiftwidth=4

" Convert tabs to spaces
set expandtab

" Enable smart autoindenting when starting a new line
set smartindent

" Keep at least 10 lines above and below cursor while scrolling
set scrolloff=10

" Keep at least 10 lines above and below the cursor in 
set sidescrolloff=10

" Ignore case when searching
set ignorecase

" Searching is case-sensitive only if the pattern contains uppercase chars
set smartcase

" Set sensible highlighting on braces that does not obscure text
highlight MatchParen cterm=underline ctermbg=black ctermfg=NONE
highlight MatchParen gui=underline guibg=black guifg=NONE

" Set auto word wrap
set textwidth=100
set wrap

" Navigate through visual lines when they are wrapped at the end.
nnoremap j gj
nnoremap k gk
xnoremap j gj
xnoremap k gk

" Quicker navigation
nmap J 5j
nmap K 5k
xmap J 5j
xmap K 5k

" Easier movement between split windows
nmap gh <C-w>h
nmap gj <C-w>j
nmap gk <C-w>k
nmap gl <C-w>l




