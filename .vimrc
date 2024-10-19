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
