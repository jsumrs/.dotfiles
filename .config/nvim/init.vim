"=============================================================================
" 1. NEOVIM PLUGINS (Uses vim-plug)
"=============================================================================
call plug#begin()

Plug 'junegunn/vim-easy-align'
Plug 'NoahTheDuke/vim-just'        " `just` tool syntax support
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" EasyAlign Binding
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"=============================================================================
" 2. CLIPBOARD & WAYLAND CONFIG (Fixes Sway issue natively)
"=============================================================================
set clipboard=unnamedplus          " Native Sway/Wayland clipboard synchronization

"=============================================================================
" 3. MECHANICAL & TEXT SETTINGS
"=============================================================================
set number relativenumber          " Relative line numbers
set tabstop=4                      " 1 tab = 4 spaces
set shiftwidth=4                   " Number of spaces to use for each step of (auto)indent
set expandtab                      " Convert tabs to spaces
set smartindent                    " Enable smart autoindenting when starting a new line
set scrolloff=10                   " Keep at least 10 lines above and below cursor while scrolling
set sidescrolloff=10               " Keep at least 10 lines above and below the cursor in
set ignorecase                     " Ignore case when searching
set smartcase                      " Searching is case-sensitive only if the pattern contains uppercase chars
set textwidth=100                  " Set auto word wrap
set wrap                           " Wrap text automatically
set linebreak                      " Prevent wrap from cutting word in half
set modelines=0                    " Security fallback

" Don't write backup file if vim is being called by admin tools
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
au BufWrite /private/etc/pw.* set nowritebackup nobackup

"=============================================================================
" 4. NETRW FILE EXPLORER
"=============================================================================
let g:netrw_banner=0               " Disable annoying banner
let g:netrw_browse_split=4         " Open in prior window
let g:netrw_altv=1                 " Open splits to the right
let g:netrw_liststyle=3            " Tree view
let g:netrw_list_hide=''

augroup netrw_config
  autocmd!
  autocmd FileType netrw let g:netrw_list_hide = netrw_gitignore#Hide() . ',\(^\|\s\s\)\zs\.\S\+'
augroup END

"=============================================================================
" 5. LSP & COC KEYMAPS
"=============================================================================
" cross-file rename
nmap <leader>rn <Plug>(coc-rename)

" go to definition / declaration
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-declaration)

" hover docs (function header + documentation popup)
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

"=============================================================================
" 6. UTILITY COMMANDS & CUSTOM HOTKEYS
"=============================================================================
" Tag Jumping
command! MakeTags !ctags -R . 

" Insert a C# code block for Asciidoc
nnoremap <leader>cs O[source,cs]<CR>----<CR><CR>----<Esc>kA

" Navigate through visual lines when they are wrapped at the end
nnoremap j gj
nnoremap k gk
xnoremap j gj
xnoremap k gk

" Easier movement between split windows
nmap gh <C-w>h
nmap gj <C-w>j
nmap gk <C-w>k
nmap gl <C-w>l

"=============================================================================
" 7. VISUALS & STYLING
"=============================================================================
set title                          " Show filename in status line
set termguicolors                  " True colors on natively

highlight MatchParen cterm=underline ctermbg=black ctermfg=NONE
highlight MatchParen gui=underline guibg=black guifg=NONE

colorscheme torte 
