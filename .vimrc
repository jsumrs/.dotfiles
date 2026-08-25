" TODO:
"   Create a githook to create ctags when committing (or pushing, or w/e)
" Features to get more familiar with
"   Tabs (tabe <file>)
"   easy-align plugin
"   marks
"   ctags
"   fzf
"   folds
"   netrw


"----- Mac Defaults ---- "
" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup nobackup

"------ Vim Plugins ------------

"------ Put Plugins Here -------
call plug#begin()
Plug 'junegunn/vim-easy-align'
Plug 'NoahTheDuke/vim-just'
Plug 'OmniSharp/omnisharp-vim'
Plug 'dense-analysis/ale'
" Run :PlugInstall after installation
"-------------------------------
call plug#end()

" EasyAlign Binding
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" OmniSharp
let g:OmniSharp_server_stdio = 1   " Use stdio instead of HTTP for LSP communication


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
set path+=**              " Allow find command to search down into subfolders
set wildmenu              " Display all matching files for tab complete
set nocompatible          " Don't pretend to be vi
set modelines=0           " CVE-2007-2438
set backspace=2           " more powerful backpacing

let skip_defaults_vim=1


"" netrw                  
syntax enable              " Turn on syntax highlighting
filetype plugin on         " Load plugin file for detected filetype
let g:netrw_banner=0       " Disable annoying banner
let g:netrw_browse_split=4 " Open in prior window
let g:netrw_altv=1         " Open splits to the right
let g:netrw_liststyle=3    " Tree view
let g:netrw_list_hide=''
augroup netrw_config
  autocmd!
  autocmd FileType netrw let g:netrw_list_hide = netrw_gitignore#Hide() . ',\(^\|\s\s\)\zs\.\S\+'
augroup END

" Tag Jumping
command! MakeTags !ctags -R . " Create tags file


"----- Visual Changes ----- 

" Set sensible highlighting on braces that does not obscure text
highlight MatchParen cterm=underline ctermbg=black ctermfg=NONE
highlight MatchParen gui=underline guibg=black guifg=NONE
set title "Show filename in status line

set background=light
colorscheme torte

" Force true colors on
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

"+++++++++++++++++++"
"----- HOTKEYS -----"
"+++++++++++++++++++"

let g:mapleader=","

" Navigate through visual lines when they are wrapped at the end.
nnoremap j gj
nnoremap k gk
xnoremap j gj
xnoremap k gk

" Easier movement between split windows
nmap gh <C-w>h
nmap gj <C-w>j
nmap gk <C-w>k
nmap gl <C-w>l
