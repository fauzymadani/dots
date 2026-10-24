set number
set relativenumber
syntax on
set nowrap 
set termguicolors

set tabstop=4
set shiftwidth=4
set expandtab

call plug#begin()

" List your plugins here
Plug 'tpope/vim-sensible'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'kisom/eink.vim',
Plug 'rose-pine/vim'
Plug 'andreasvc/vim-256noir'
Plug 'nanotech/jellybeans.vim'
Plug 'TheNiteCoder/mountaineer.vim'

call plug#end()

colorscheme mountaineer
