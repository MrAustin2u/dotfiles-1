" Init vim-plug
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Utilities
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'dylanaraps/root.vim'

" Git
Plug 'TimUntersberger/neogit'
Plug 'sindrets/diffview.nvim'

" Statusline
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
Plug 'kyazdani42/nvim-web-devicons'
Plug 'Avimitin/nerd-galaxyline'

" File explorer
Plug 'glepnir/dashboard-nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'akinsho/bufferline.nvim' "tab layout

" Fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Language support
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'SirVer/ultisnips'

" React/Typescript
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'

" Test
Plug 'vim-test/vim-test'
Plug 'preservim/vimux'

call plug#end()


" Default autogroup
augroup default
au!
augroup END

" nvim-treesitter
lua <<EOF
require("nvim-treesitter.configs").setup {
  ensure_installed = "maintained",
  highlight = { enable = true },
}
EOF

" nvim-telescope
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-f> <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" lsp
set hidden
let g:LanguageClient_serverCommands = {
    \ 'elixir': ['language_server.sh'],
    \ 'javascript': ['typescript-language-server', '--stdio'],
    \ 'typescript': ['typescript-language-server', '--stdio'],
    \ 'javascript.jsx': ['typescript-language-server', '--stdio'],
    \ 'typescript.tsx': ['typescript-language-server', '--stdio'],
    \ }
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
" Format on save
autocmd default BufWritePre *.ex call FormatOnSave()
autocmd default BufWritePre *.exs call FormatOnSave()

function FormatOnSave()
  noautocmd call LanguageClient#textDocument_formatting({}, funcref('AfterFormat'))
endfunction

function AfterFormat(...)
  noautocmd w
endfunction

" deoplate
let g:deoplete#enable_at_startup = 1

" ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "my_snippets"]
let g:python_host_prog="~/.asdf/shims/python"


" nvim-tree
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <C-y> :NvimTreeFindFile<CR>
let g:nvim_tree_side = 'right'
let g:nvim_tree_width = 50

" bufferline
lua << EOF
require("bufferline").setup{}
EOF
nnoremap <silent><leader>1 <Cmd>BufferLineGoToBuffer 1<CR>
nnoremap <silent><leader>2 <Cmd>BufferLineGoToBuffer 2<CR>
nnoremap <silent><leader>3 <Cmd>BufferLineGoToBuffer 3<CR>
nnoremap <silent><leader>4 <Cmd>BufferLineGoToBuffer 4<CR>
nnoremap <silent><leader>5 <Cmd>BufferLineGoToBuffer 5<CR>
nnoremap <silent><leader>6 <Cmd>BufferLineGoToBuffer 6<CR>
nnoremap <silent><leader>7 <Cmd>BufferLineGoToBuffer 7<CR>
nnoremap <silent><leader>8 <Cmd>BufferLineGoToBuffer 8<CR>
nnoremap <silent><leader>9 <Cmd>BufferLineGoToBuffer 9<CR>

" root.nvim
let g:root#patterns = ['.git', 'mix.exs', '_build', 'deps', 'node_modules', 'README.md']

" neogit
lua << EOF
require("neogit").setup{
  integrations = {
    diffview = true
  }
}
EOF
nnoremap <C-g> :Neogit<CR>

" dashboard-nvim
let g:mapleader='\'
let g:dashboard_default_executive = 'telescope'
let g:dashboard_custom_shortcut={
\ 'last_session'       : '\ s l',
\ 'find_history'       : '\ f h',
\ 'find_file'          : '\ f f',
\ 'new_file'           : '\ c n',
\ 'change_colorscheme' : '\ t c',
\ 'find_word'          : '\ f a',
\ 'book_marks'         : '\ f b',
\ }
let g:dashboard_custom_header = [
\ ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
\ ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
\ ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
\ ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
\ ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
\ ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
\]
nmap <Leader>ss :<C-u>SessionSave<CR>
nmap <Leader>sl :<C-u>SessionLoad<CR>
nnoremap <silent> <Leader>fh :DashboardFindHistory<CR>
nnoremap <silent> <Leader>ff :DashboardFindFile<CR>
nnoremap <silent> <Leader>tc :DashboardChangeColorscheme<CR>
nnoremap <silent> <Leader>fa :DashboardFindWord<CR>
nnoremap <silent> <Leader>fb :DashboardJumpMark<CR>
nnoremap <silent> <Leader>cn :DashboardNewFile<CR>

" vim-test
nmap <silent> tn :TestNearest<CR>
nmap <silent> tf :TestFile<CR>
nmap <silent> ts :TestSuite<CR>
nmap <silent> tl :TestLast<CR>
nmap <silent> tg :TestVisit<CR>
let test#strategy = 'vimux'
let g:test#preserve_screen = 0

" Appearence
set number cursorline
set showcmd cmdheight=1
set termguicolors background=dark t_Co=256
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set clipboard=unnamed
set splitright
" Dracula PRO
packadd! dracula_pro
syntax enable
let g:dracula_colorterm = 0
colorscheme dracula_pro_van_helsing

" Terminal mode remap
tnoremap <Esc> <C-\><C-n>:q!<CR>

" Clear all things
nmap <silent><space> :nohlsearch<CR>

" Close buffer
nnoremap <leader>q :bdelete<CR>

" Persistent undo
set undofile
set undodir=~/.vimundo/

" Back to normal mode with Ctrl-c
inoremap <C-c> <esc>

" Open config
nnoremap <Leader>nv :e ~/.config/nvim/init.vim <CR>
nnoremap <Leader>tm :e ~/.config/tmux/tmux.conf <CR>
nnoremap <Leader>fs :e ~/.config/fish/config.fish <CR>
nnoremap <Leader>al :e ~/.config/alacritty/alacritty.yml <CR>

" Operators
onoremap ic i{
onoremap ib i[
onoremap ip i(

