" Name:        seaweed
" Description: Muted green-and-cream colorscheme on a black background,
"              with three added accents for syntax contrast.
" Palette:     seaweed-tea #5C7B5B · mermaids-cove #8EA586 · pine-whisper #B2C7B8
"              nano-white #F2EFEA · almond-cream #FCF7EF
" Accents:     dune-sand #D8C3A0 · tide-clay #C58B6F · harbour-mist #8FB0B3
" Install:     save as ~/.vim/colors/seaweed.vim (Vim)
"              or ~/.config/nvim/colors/seaweed.vim (Neovim), then
"              set termguicolors | colorscheme seaweed

set background=dark
hi clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name = 'seaweed'

" ── Palette ──────────────────────────────────────────────────────────────
"   name            gui        cterm (256-colour approximation)
let s:black     = ['#000000', 16]
let s:seaweed   = ['#5C7B5B', 65]     " seaweed-tea
let s:cove      = ['#8EA586', 108]    " mermaids-cove
let s:pine      = ['#B2C7B8', 151]    " pine-whisper
let s:white     = ['#F2EFEA', 255]    " nano-white
let s:cream     = ['#FCF7EF', 230]    " almond-cream

" Accents added for syntax contrast (same muted chroma as the palette)
let s:sand      = ['#D8C3A0', 180]    " dune-sand     strings, search, warnings
let s:clay      = ['#C58B6F', 173]    " tide-clay     numbers, constants, errors
let s:mist      = ['#8FB0B3', 109]    " harbour-mist  types, builtins, info

" Derived UI shades (seaweed-tea mixed toward black) for surfaces only
let s:shade1    = ['#0E130E', 233]    " cursor line, float bg
let s:shade2    = ['#1A231A', 234]    " status line, popup menu
let s:shade3    = ['#243024', 235]    " visual selection, diff change
let s:shade4    = ['#2E3D2E', 237]    " line numbers, borders, whitespace
let s:none      = ['NONE', 'NONE']

" hi group, fg, bg, attr (bold/italic/underline/undercurl/reverse or NONE)
function! s:hi(group, fg, bg, ...) abort
  let l:attr = a:0 ? a:1 : 'NONE'
  execute 'hi ' . a:group
        \ . ' guifg=' . a:fg[0] . ' guibg=' . a:bg[0]
        \ . ' ctermfg=' . a:fg[1] . ' ctermbg=' . a:bg[1]
        \ . ' gui=' . l:attr . ' cterm=' . l:attr
        \ . ' guisp=' . a:fg[0]
endfunction

" ── Editor UI ────────────────────────────────────────────────────────────
call s:hi('Normal',        s:white,   s:black)
call s:hi('NormalFloat',   s:white,   s:shade1)
call s:hi('FloatBorder',   s:shade4,  s:shade1)
call s:hi('Cursor',        s:black,   s:cove)
call s:hi('CursorLine',    s:none,    s:shade1)
call s:hi('CursorColumn',  s:none,    s:shade1)
call s:hi('ColorColumn',   s:none,    s:shade1)
call s:hi('LineNr',        s:shade4,  s:black)
call s:hi('CursorLineNr',  s:cove,    s:shade1, 'bold')
call s:hi('SignColumn',    s:shade4,  s:black)
call s:hi('FoldColumn',    s:shade4,  s:black)
call s:hi('Folded',        s:seaweed, s:shade1, 'italic')
call s:hi('VertSplit',     s:shade4,  s:black)
call s:hi('WinSeparator',  s:shade4,  s:black)
call s:hi('StatusLine',    s:white,   s:shade2)
call s:hi('StatusLineNC',  s:seaweed, s:shade1)
call s:hi('TabLine',       s:seaweed, s:shade1)
call s:hi('TabLineFill',   s:none,    s:shade1)
call s:hi('TabLineSel',    s:black,   s:cove,   'bold')
call s:hi('Visual',        s:none,    s:shade3)
call s:hi('VisualNOS',     s:none,    s:shade3)
call s:hi('Search',        s:black,   s:sand)
call s:hi('IncSearch',     s:black,   s:cream,  'bold')
call s:hi('CurSearch',     s:black,   s:cream,  'bold')
call s:hi('MatchParen',    s:cream,   s:shade4, 'bold')
call s:hi('Pmenu',         s:white,   s:shade2)
call s:hi('PmenuSel',      s:black,   s:cove,   'bold')
call s:hi('PmenuSbar',     s:none,    s:shade2)
call s:hi('PmenuThumb',    s:none,    s:shade4)
call s:hi('WildMenu',      s:black,   s:cove,   'bold')
call s:hi('NonText',       s:shade4,  s:none)
call s:hi('EndOfBuffer',   s:shade4,  s:none)
call s:hi('Whitespace',    s:shade4,  s:none)
call s:hi('SpecialKey',    s:shade4,  s:none)
call s:hi('Conceal',       s:seaweed, s:none)
call s:hi('Directory',     s:mist,    s:none,   'bold')
call s:hi('Title',         s:cream,   s:none,   'bold')
call s:hi('Question',      s:cove,    s:none)
call s:hi('MoreMsg',       s:cove,    s:none,   'bold')
call s:hi('ModeMsg',       s:pine,    s:none,   'bold')
call s:hi('WarningMsg',    s:sand,    s:none,   'bold')
call s:hi('ErrorMsg',      s:black,   s:clay,   'bold')
call s:hi('QuickFixLine',  s:none,    s:shade3)
call s:hi('SpellBad',      s:clay,    s:none,   'undercurl')
call s:hi('SpellCap',      s:sand,    s:none,   'undercurl')
call s:hi('SpellRare',     s:mist,    s:none,   'undercurl')
call s:hi('SpellLocal',    s:mist,    s:none,   'undercurl')

" ── Syntax ───────────────────────────────────────────────────────────────
call s:hi('Comment',       s:seaweed, s:none,   'italic')
call s:hi('Constant',      s:clay,    s:none)
call s:hi('String',        s:sand,    s:none)
call s:hi('Character',     s:sand,    s:none)
call s:hi('Number',        s:clay,    s:none)
call s:hi('Boolean',       s:clay,    s:none,   'bold')
call s:hi('Float',         s:clay,    s:none)
call s:hi('Identifier',    s:white,   s:none)
call s:hi('Function',      s:cream,   s:none,   'bold')
call s:hi('Statement',     s:cove,    s:none,   'bold')
call s:hi('Operator',      s:pine,    s:none)
call s:hi('PreProc',       s:pine,    s:none,   'bold')
call s:hi('Type',          s:mist,    s:none)
call s:hi('Special',       s:mist,    s:none,   'italic')
call s:hi('SpecialChar',   s:clay,    s:none)
call s:hi('Delimiter',     s:white,   s:none)
call s:hi('SpecialComment',s:seaweed, s:none,   'bold,italic')
call s:hi('Underlined',    s:mist,    s:none,   'underline')
call s:hi('Ignore',        s:shade4,  s:none)
call s:hi('Error',         s:black,   s:clay,   'bold')
call s:hi('Todo',          s:black,   s:cove,   'bold')

" ── Diff ─────────────────────────────────────────────────────────────────
call s:hi('DiffAdd',       s:none,    s:shade2)
call s:hi('DiffChange',    s:none,    s:shade1)
call s:hi('DiffText',      s:cream,   s:shade3, 'bold')
call s:hi('DiffDelete',    s:shade4,  s:black)
call s:hi('diffAdded',     s:cove,    s:none)
call s:hi('diffRemoved',   s:clay,    s:none)
call s:hi('diffChanged',   s:sand,    s:none)

" ── Diagnostics (Vim LSP plugins and Neovim) ─────────────────────────────
call s:hi('DiagnosticError', s:clay,    s:none, 'bold')
call s:hi('DiagnosticWarn',  s:sand,    s:none, 'bold')
call s:hi('DiagnosticInfo',  s:mist,    s:none)
call s:hi('DiagnosticHint',  s:seaweed, s:none)
call s:hi('DiagnosticOk',    s:cove,    s:none)
call s:hi('DiagnosticUnderlineError', s:clay,    s:none, 'undercurl')
call s:hi('DiagnosticUnderlineWarn',  s:sand,    s:none, 'undercurl')
call s:hi('DiagnosticUnderlineInfo',  s:mist,    s:none, 'undercurl')
call s:hi('DiagnosticUnderlineHint',  s:seaweed, s:none, 'undercurl')

" ── Neovim tree-sitter captures ──────────────────────────────────────────
if has('nvim')
  hi! link @variable            Identifier
  hi! link @variable.builtin    Special
  hi! link @variable.parameter  Identifier
  hi! link @variable.member     Identifier
  hi! link @function            Function
  hi! link @function.call       Function
  hi! link @function.builtin    Special
  hi! link @function.method     Function
  hi! link @constructor         Type
  hi! link @keyword             Statement
  hi! link @keyword.import      PreProc
  hi! link @attribute           PreProc
  hi! link @type                Type
  hi! link @type.builtin        Type
  hi! link @string              String
  hi! link @string.escape       SpecialChar
  hi! link @number              Number
  hi! link @boolean             Boolean
  hi! link @constant            Constant
  hi! link @constant.builtin    Constant
  hi! link @punctuation         Delimiter
  hi! link @comment             Comment
  hi! link @markup.heading      Title
  hi! link @markup.link.url     Underlined
endif

" ── Terminal colours (:terminal) ─────────────────────────────────────────
"   black, red, green, yellow, blue, magenta, cyan, white, then bright versions
let s:term = ['#000000', '#C58B6F', '#8EA586', '#D8C3A0', '#8FB0B3', '#B2C7B8', '#8FB0B3', '#F2EFEA',
            \ '#2E3D2E', '#C58B6F', '#B2C7B8', '#D8C3A0', '#8FB0B3', '#B2C7B8', '#8FB0B3', '#FCF7EF']
if has('nvim')
  for s:i in range(16)
    let g:terminal_color_{s:i} = s:term[s:i]
  endfor
elseif has('terminal')
  let g:terminal_ansi_colors = s:term
endif

delfunction s:hi
