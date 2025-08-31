set number
set relativenumber
syntax on
set nowrap 
set termguicolors

call plug#begin()

" List your plugins here
Plug 'tpope/vim-sensible'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }

call plug#end()

colorscheme catppuccin_mocha
