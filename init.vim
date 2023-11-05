""""""""""""""""""""""""""""""""""""""
" General configuration
"

set nocompatible            " disable compatibility to old-time vi
set hidden

set spelllang=en_us
set spell                   " spell checker

set noswapfile              " disable swapfile
set nobackup
set nowritebackup

set nohlsearch
set incsearch

set mouse=                  " disable mouse click

set ignorecase              " case insensitive 
set autoindent              " indent a new line the same amount as the line just typed
set smartindent

set nowrap                  " disable line wraps

" disable auto comments on next line
autocmd FileType * set formatoptions-=cro

" Highlight whitespace
set list
set lcs+=space:·

set number                  " add line numbers
set relativenumber          " add relative line numbers
set cursorline              " highlight current cursorline
syntax on
set colorcolumn=80          " set an 80 column border for good coding style
set signcolumn=yes

set updatetime=100          " set the time between changes made and plugin trigger

filetype plugin on
filetype plugin indent on   "allow auto-indenting depending on file type

set expandtab               " converts tabs to white space
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set shiftwidth=4            " width for autoindents

set scrolloff=8

set termguicolors

let g:loaded_netrw       = 1 " Disable neovim file browser
let g:loaded_netrwPlugin = 1


""""""""""""""""""""""""""""""""""""""
" Remaps
"

let mapleader = " "
let maplocalleader = ","

map <C-l> 20zl
map <C-h> 20zh

" Telescope
"
nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>g <cmd>Telescope live_grep<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>h <cmd>Telescope help_tags<cr>
nnoremap <leader>j <cmd>Oil<cr>


" Barbar
"
" Move to previous/next
nnoremap <silent>    <A-h> <Cmd>BufferPrevious<CR>
nnoremap <silent>    <A-l> <Cmd>BufferNext<CR>
" Re-order to previous/next
nnoremap <silent>    <A-H> <Cmd>BufferMovePrevious<CR>
nnoremap <silent>    <A-L> <Cmd>BufferMoveNext<CR>
" Pin/unpin buffer
nnoremap <silent>    <A-p> <Cmd>BufferPin<CR>
" Close buffer
nnoremap <silent>    <C-c> <Cmd>BufferClose<CR>
" Restore buffer
nnoremap <silent>    <A-s-c> <Cmd>BufferRestore<CR>
" Magic buffer-picking mode
nnoremap <silent> <C-p>    <Cmd>BufferPick<CR>
nnoremap <silent> <C-P>    <Cmd>BufferPickDelete<CR>
" Sort automatically by...
nnoremap <silent> <Space>bb <Cmd>BufferOrderByBufferNumber<CR>
nnoremap <silent> <Space>bd <Cmd>BufferOrderByDirectory<CR>
nnoremap <silent> <Space>bl <Cmd>BufferOrderByLanguage<CR>
nnoremap <silent> <Space>bw <Cmd>BufferOrderByWindowNumber<CR>


""""""""""""""""""""""""""""""""""""""
" Plugins
"

call plug#begin()

" Appearance changes
Plug 'Mofiqul/adwaita.nvim'     " nvim color theme
Plug 'nvim-tree/nvim-web-devicons' " nvim icons theme
Plug 'nvim-lualine/lualine.nvim' " nvim statusline
Plug 'lukas-reineke/indent-blankline.nvim' " add indentation lines to make reading functions easier

" Additional features
Plug 'nvim-telescope/telescope.nvim' " fuzzy finder
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' } " sorter for telescope
Plug 'nvim-lua/plenary.nvim' " dependency for telescope.nvim
Plug 'windwp/nvim-autopairs' " auto pair brackets
Plug 'windwp/nvim-ts-autotag' " auto close tags for html, xml etc.
Plug 'numToStr/Comment.nvim' " enable easy commenting
Plug 'nmac427/guess-indent.nvim' " auto indentation detection
Plug 'romgrk/barbar.nvim' " tab and buffer management
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'} " toggle-able terminal
Plug 'lewis6991/gitsigns.nvim' " git diffs
Plug 'NvChad/nvim-colorizer.lua' " color highlighter
Plug 'nvimdev/guard.nvim' " formatting and linting
Plug 'nvimdev/guard-collection' " Collection of configs for guard.nvim
Plug 'stevearc/oil.nvim' " file explorer for managing files like buffers

" Language enablement
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " better syntax highlighting and other cool features
Plug 'nvim-treesitter/nvim-treesitter-context' " sticky function signatures when you scroll
Plug 'neovim/nvim-lspconfig' " sensible defaults for LSP + Launch LSP automatically for corresponding filetypes
Plug 'williamboman/mason.nvim' " package manger for LSP servers, DAP servers, linters, and formatters
Plug 'williamboman/mason-lspconfig.nvim' " bridge mason and lspconfig
Plug 'j-hui/fidget.nvim', { 'tag': 'legacy' } " nvim-lsp progress
Plug 'hrsh7th/nvim-cmp' " provides completions
Plug 'L3MON4D3/LuaSnip' " provides snippets
Plug 'rafamadriz/friendly-snippets' " collection of snippets for LuaSnip
Plug 'hrsh7th/cmp-nvim-lsp' " lets nvim-cmp use lsp for completions
Plug 'hrsh7th/cmp-path' " lets nvim-cmp use filesytesm paths for completions
Plug 'saadparwaiz1/cmp_luasnip' " lusnip as a source for nvim-cmp
Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v3.x'} " makes LSP setup easy


" Language specific stuff
Plug 'Olical/conjure' " repl for lisp like languages
Plug 'wlangstroth/vim-racket' " racket support
Plug 'eraserhd/parinfer-rust', {'do':
        \  'cargo build --release'} " make working with lisp like languages easier

" Misc
Plug 'ThePrimeagen/vim-be-good' " Learning plugin

call plug#end()


""""""""""""""""""""""""""""""""""""""
" Plugin setup & configuration
"

let g:adwaita_darker = v:true
colorscheme adwaita

lua << EOF

require('lualine').setup({
    options = {
        theme = "adwaita",
        section_separators = { left = '', right = '' },
        component_separators = { left = '|', right = '|' }
    }
})

require'nvim-treesitter.configs'.setup{
    highlight = {
        enable=true
    },

    autotag = {
        enable = true,
        enable_rename = true,
        enable_close = true,
        enable_close_on_slash = true,
    },

    indent = {
        enable = true
    },

    ensure_installed = {
        'bash', 'c', 'cpp', 'css', 'go', 'html',
        'java', 'javascript', 'json', 'lua',
        'make', 'markdown', 'markdown_inline',
        'meson', 'php', 'python', 'racket',
        'regex', 'rust', 'scheme', 'sql', 'vim'
    }
}

require("nvim-autopairs").setup()

require('Comment').setup()

local highlight = {
    "Purple2",
}

local hooks = require "ibl.hooks"
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "Purple2", { fg = "#c061cb" })
end)

require("ibl").setup({
    whitespace = {
        remove_blankline_trail = true,
    },

    scope = {
        highlight = highlight,
        enabled = true,
    }
})

require'nvim-web-devicons'.setup {
    color_icons = false,
}

require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
}

require('telescope').load_extension('fzf')

require('treesitter-context').setup()

require("toggleterm").setup{
    size = 20,
    open_mapping = [[<c-t>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    autochdir = true,
    insert_mappings = true,
    persist_size = true,
    direction = "float",
    close_on_exit = true,
    float_opts = {
        border = "curved",
        }
}

require('gitsigns').setup()

require("fidget").setup()

local lsp = require('lsp-zero')

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

require('lspconfig').lua_ls.setup({})

lsp.setup()

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        -- 'clangd'
        'cssls', 'emmet_language_server',
        'html', 'lua_ls', 'tsserver', 'vimls'
    },
    handlers = {
        lsp.default_setup,
    }
})

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
    {name = 'luasnip'},
    {name = 'path'},
  },
  mapping = {
    ['<CR>']    = cmp.mapping.confirm({select = true}),
        ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
    ['<C-u>']   = cmp.mapping.scroll_docs(-4),
    ['<C-d>']   = cmp.mapping.scroll_docs(4),
  }
})

require 'colorizer'.setup({
    user_default_options = {
        css = true,
        css_fn = true,
        mode = "virtualtext",
    }
})

local ft = require('guard.filetype')

ft('html'):fmt('prettier')

ft('css'):fmt('prettier')

ft('typescript,javascript,typescriptreact'):fmt('prettier')

require('guard').setup()

require("oil").setup({
    keymaps = {
        ["."] = "actions.cd",
        [".."] = "actions.parent",
    }
})

require('guess-indent').setup()

EOF

" Misc stuff
"

function! ClearRegisters()
    let regs='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-="*+'
    let i=0
    while (i<strlen(regs))
        exec 'let @'.regs[i].'=""'
        let i=i+1
    endwhile
endfunction

command! ClearRegisters call ClearRegisters()
