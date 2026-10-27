--- ========================================================================== --
-- ==                         CHEATSHEET (temporary)                       == --
-- ========================================================================== --

--[==[
FINDING KEYBINDS
  pause after a prefix     which-key popup (g, gr, ], <C-w>, Space)
  :Pick keymaps            searchable list of every mapping
  :map gr                  list mappings starting with gr (:nmap, :imap per mode)
  :help lsp-defaults       full LSP default list
  :help diagnostic-defaults

CUSTOM MAPPINGS (this file)
  gy  (n, x)               copy to system clipboard
  gp  (n, x)               paste from system clipboard

LSP (active once a server attaches; check with :checkhealth vim.lsp)
  K                        hover documentation            (config)
  gd                       go to definition               (config)
  grd                      go to declaration              (config)
  gq  (n, x)               format via LSP; replaces built-in gq wrap (config)
  <C-s> (insert)           signature help                 (default)
  <C-o> / <C-i>            jump back / forward            (built-in)

DIAGNOSTICS
  ]d / [d                  next / previous diagnostic
  ]D / [D                  last / first diagnostic in buffer
  <C-w>d                   show full message in a float

  Fix loop: ]d -> <C-w>d -> gra

BRACKET MOTIONS (] forward, [ back; :help [ for the rest)
  ]d [d                    diagnostics
  ]q [q                    quickfix list
  ]l [l                    location list
  ]b [b                    buffers

NAVIGATING BY FUNCTION
  :Pick lsp scope='document_symbol'   pick symbol (needs LSP)
  :Pick treesitter                    pick syntax node (needs treesitter in buffer)
  gO                                  document symbols list
  ]m [m  ]] [[                        brace-based jumps (weak in Lua/Python)

COMPLETION (mini.completion)
  <C-n> / <C-p>            next / previous item
  <C-y>                    accept item
  <C-x><C-o>               trigger manually

SNIPPETS (mini.snippets, verify: :help MiniSnippets.config)
  <C-j>                    expand snippet
  <C-l> / <C-h>            next / previous field
  <C-c>                    stop snippet session

SURROUND (mini.surround, :help MiniSurround)
  sa{motion}{char}         add, e.g. saiw"
  sd{char}                 delete, e.g. sd"
  sr{old}{new}             replace, e.g. sr"'
  sf / sF                  find surrounding right / left
  sh                       highlight surrounding

FILE EXPLORER (mini.files via <leader>e, :help MiniFiles-navigation)
  l / h                    into / out of directory, open file
  =                        apply edits (create, rename, delete by editing text)
  q                        close

PICKER (mini.pick, :help MiniPick-actions)
  <C-n> / <C-p>            move down / up
  <CR>                     choose
  <C-s> / <C-v> / <C-t>    open in split / vsplit / tab
  <Tab>                    toggle preview
  <Esc>                    close

RUNNING PYTHON WITHOUT LEAVING NEOVIM
  <C-z>, then fg           suspend Neovim, use shell, resume
  :!python %               run current file (% = current file path)
  :!just <recipe>          run a just recipe
  :terminal                terminal in window (:split | terminal for a split)
  <C-\><C-n>               leave terminal insert mode
  :make                    run 'makeprg', errors go to quickfix
  :copen                   open quickfix; ]q / [q to step
  Help: :!  cmdline-special  :terminal  :make  :compiler  errorformat

CONFIG
  :e $MYVIMRC                       open init.lua
  :lua vim.print(vim.pack.get())    list managed plugins
  :lua vim.pack.del({'name'})       remove plugin (also edit vim.pack.add)

]==]
-- ========================================================================== --
-- ==                           EDITOR SETTINGS                            == --
-- ========================================================================== --

-- Learn more about Neovim lua api
-- https://neovim.io/doc/user/lua-guide.html
-- https://vonheikemen.github.io/devlog/tools/build-your-first-lua-config-for-neovim/

vim.o.number = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = false
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.showmode = false
vim.o.termguicolors = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.signcolumn = 'yes'
vim.o.winborder = 'rounded'
vim.wo.relativenumber = true

-- Space as leader key
vim.g.mapleader = vim.keycode('<Space>')

-- Basic clipboard interaction
vim.keymap.set({'n', 'x'}, 'gy', '"+y', {desc = 'Copy to clipboard'})
vim.keymap.set({'n', 'x'}, 'gp', '"+p', {desc = 'Paste clipboard content'})

-- ========================================================================== --
-- ==                               PLUGINS                                == --
-- ========================================================================== --

-- NOTE: To install a plugin you just need to add the URL to the repository.
-- But as soon as you need to add more information, like the git branch or 
-- commit, use the "plugin spec" form. See :help vim.pack

vim.pack.add({
  'https://github.com/folke/which-key.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  {src = 'https://github.com/nvim-mini/mini.nvim', version = 'main'},
  {src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main'},
	{src = "https://github.com/rose-pine/neovim",
		name = "rose-pine",},
})


-- ========================================================================== --
-- ==                         PLUGIN CONFIGURATION                         == --
-- ========================================================================== --

vim.cmd.colorscheme('zaibatsu')

-- See :help MiniAlign.config
require('mini.align').setup()

-- See :help MiniIcons.config
-- Change style to 'glyph' if you have a font with fancy icons
require('mini.icons').setup({style = 'ascii'})

-- See :help MiniSurround.config
require('mini.surround').setup({})

-- See :help MiniNotify.config
require('mini.notify').setup({
  lsp_progress = {enable = false},
})

-- See :help MiniBufremove.config
require('mini.bufremove').setup({})

-- Close buffer and preserve window layout
vim.keymap.set('n', '<leader>bc', '<cmd>lua pcall(MiniBufremove.delete)<cr>', {desc = 'Close buffer'})

-- See :help MiniFiles.config
local mini_files = require('mini.files')
mini_files.setup({})

-- Toggle file explorer
-- See :help MiniFiles-navigation
vim.keymap.set('n', '<leader>e', function()
  if mini_files.close() then
    return
  end

  mini_files.open()
end, {desc = 'File explorer'})

-- See :help MiniPick.config
require('mini.pick').setup({})

-- See available pickers
-- :help MiniPick.builtin
-- :help MiniExtra.pickers
vim.keymap.set('n', '<leader>?', '<cmd>Pick oldfiles<cr>', {desc = 'Search file history'})
vim.keymap.set('n', '<leader><space>', '<cmd>Pick buffers<cr>', {desc = 'Search open files'})
vim.keymap.set('n', '<leader>ff', '<cmd>Pick files<cr>', {desc = 'Search all files'})
vim.keymap.set('n', '<leader>fg', '<cmd>Pick grep_live<cr>', {desc = 'Search in project'})
vim.keymap.set('n', '<leader>fd', '<cmd>Pick diagnostic<cr>', {desc = 'Search diagnostics'})
vim.keymap.set('n', '<leader>fs', '<cmd>Pick buf_lines<cr>', {desc = 'Buffer local search'})

-- See :help MiniStatusline.config
require('mini.statusline').setup({})

-- See :help MiniExtra
require('mini.extra').setup({})

-- See :help MiniSnippets.config
require('mini.snippets').setup({})

-- See :help MiniCompletion.config
require('mini.completion').setup({
  lsp_completion = {
    source_func = 'omnifunc',
    auto_setup = false,
  },
})

-- See :help which-key.nvim-which-key-setup
require('which-key').setup({
  preset = 'helix',
  icons = {
    mappings = false,
    keys = {
      Space = 'Space',
      Esc = 'Esc',
      BS = 'Backspace',
      C = 'Ctrl-',
    },
  },
})

require('which-key').add({
  {'<leader>f', group = 'Fuzzy Find'},
  {'<leader>b', group = 'Buffer'},
})

-- Treesitter setup
-- Try to update all parsers after a plugin update
vim.api.nvim_create_autocmd('PackChanged', {
  pattern = 'nvim-treesitter',
  desc = 'Update treesitter parsers',
  command = 'TSUpdate'
})

-- NOTE: treesitter features **must** be enabled manually
-- https://github.com/nvim-treesitter/nvim-treesitter#supported-features
vim.api.nvim_create_autocmd('FileType', {
  pattern = {'lua', 'vim', 'help'},
  callback = function()
    -- Enable treesitter based syntax highlight
    pcall(vim.treesitter.start)
  end
})

-- LSP setup

vim.lsp.enable('pyright')
vim.lsp.enable('ruff')

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'grd', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set({'n', 'x'}, 'gq', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)

    local id = vim.tbl_get(event, 'data', 'client_id')
    local client = id and vim.lsp.get_client_by_id(id)

    if client and client:supports_method('textDocument/completion') then
      vim.bo[event.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
    end
  end,
})
