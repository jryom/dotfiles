if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'asheq/close-buffers.vim'
Plug 'cocopon/vaffle.vim'
Plug 'cormacrelf/dark-notify'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'romainl/vim-qf'
Plug 'sainnhe/edge'
Plug 'sheerun/vim-polyglot'
Plug 'simnalamburt/vim-mundo'
Plug 'szw/vim-maximizer'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'wellle/targets.vim'
call plug#end()

command! Up execute 'PlugUpgrade | PlugUpdate | silent execute "!echo " . (localtime()) . " > /tmp/lastupdatevim"'

if ! filereadable(expand('/tmp/lastupdatevim')) || readfile('/tmp/lastupdatevim')[0] < (localtime() - 60 * 60 * 24 * 7)
  execute 'Up'
endif

set gdefault
set hidden
set hlsearch
set ignorecase smartcase
set inccommand=split
set matchpairs+=<:>
set mouse=a
set number relativenumber
set rtp+=/usr/local/opt/fzf
set shiftround
set shortmess+=actFTWI
set signcolumn=yes
set splitbelow splitright
set termguicolors
set undofile
set updatetime=200

augroup autocommands
  autocmd!
  autocmd BufRead,BufNewFile .{eslint,babel,stylelint,prettier}rc set ft=json5
  autocmd SessionLoadPost,VimResized * wincmd =
  autocmd WinEnter,BufWinEnter * setlocal cursorline | autocmd WinLeave * setlocal nocursorline
  autocmd BufWritePre * %s/\s\+$//e
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
  autocmd VimEnter * nested
        \ if !argc() && empty(v:this_session) && filereadable('Session.vim') |
        \   source Session.vim |
        \ endif
augroup END

" THEME SETTINGS: {{{
let g:edge_better_performance = 1
let g:edge_diagnostic_line_highlight = 1
let g:edge_sign_column_background = 'none'
let g:edge_style = 'neon'
if len(systemlist('defaults read -g AppleInterfaceStyle'))==1 | set bg=dark | else | set bg=light | endif
colorscheme edge

lua << EOF
require'nvim-treesitter.configs'.setup({
  ensure_installed = "maintained",
  highlight = { enable = true },
  indent = { enable = true }
})
require('dark_notify').run()
EOF
" }}}

" PLUGIN SETTINGS: {{{
" misc plugin settings
let g:vaffle_show_hidden_files = 1
let g:rooter_silent_chdir = 1

" coc
let g:coc_global_extensions = [
      \ 'coc-css',
      \ 'coc-eslint',
      \ 'coc-html',
      \ 'coc-json',
      \ 'coc-prettier',
      \ 'coc-snippets',
      \ 'coc-styled-components',
      \ 'coc-stylelintplus',
      \ 'coc-tsserver',
      \ 'coc-vimlsp',
      \ ]

" fzf
let g:fzf_history_dir = '~/.local/share/fzf-history'
command! -bang -nargs=* RgOnlyLines call fzf#vim#grep('rg '.shellescape(<q-args>), 1, fzf#vim#with_preview({'options':'--delimiter : --nth 3..'}), <bang>0)

" KEYMAPS: {{{
" misc
let mapleader = ' '
nnoremap <expr> j v:count == 0 ? 'gj' : "\<Esc>".v:count.'j'
nnoremap <expr> k v:count == 0 ? 'gk' : "\<Esc>".v:count.'k'
nnoremap Y y$
nnoremap <silent> <Esc> :nohlsearch<cr>
nnoremap <silent> - :call vaffle#init(expand('%'))<cr>
nmap <silent> <leader>q <Plug>(qf_qf_toggle)
nnoremap <leader>w :write<cr>
nnoremap <C-w>m :MaximizerToggle!<cr>
nnoremap <leader>ts :Obsession<cr>
nnoremap <leader>u :MundoToggle<cr>
nnoremap <Leader>r :%s/<C-r><C-w>//c <Left><Left><Left>
xnoremap <Leader>r "sy:%s/<C-r>s//c <Left><Left><Left>
xnoremap < <gv
xnoremap > >gv
xmap ga <Plug>(EasyAlign)

" autoclose brackets
inoremap " ""<left>
inoremap ' ''<left>
inoremap ` ``<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>

" close-buffers
nnoremap Q :Bdelete menu<cr>
nnoremap Qa :Bdelete all<cr>
nnoremap Qh :Bdelete hidden<cr>
nnoremap Qo :Bdelete other<cr>
nnoremap Qt :Bdelete this<cr>
nnoremap Qs :Bdelete select<cr>

" coc
inoremap <silent><expr> <C-l> pumvisible() ? "\<C-y>" : "<Plug>(coc-snippets-expand-jump)"
inoremap <silent><expr> <C-n> pumvisible() ? "\<C-n>" : coc#refresh()
nmap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gh :call CocAction('doHover')<cr>
nnoremap <silent> <leader>c :CocCommand<cr>
nnoremap <silent> <leader>d :CocDiagnostics<cr>
nnoremap <silent> <leader>l :CocList<cr>
nmap <silent> <leader>p <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>n <Plug>(coc-diagnostic-next)
nmap <silent> <leader>f <Plug>(coc-format)
nmap <silent> <leader>a <Plug>(coc-codeaction)
nmap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-j>"
nmap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-k>"

" fzf
nnoremap <silent> <leader>I :Rg <cr>
nnoremap <silent> <leader>i :RgOnlyLines <cr>
xnoremap <silent> <leader>i "fy :Rg <C-R>f<cr>
nnoremap <silent> <leader>o :Files<cr>
nnoremap <silent> <leader>/ :BLines<cr>
nnoremap <silent> <leader>b :Buffers <cr>

" tabs
nnoremap <silent> <C-t> :tabnew %<cr>
nnoremap <silent> <C-q> :tabclose<cr>

" unimpaired on non-US layouts
nmap <Left> [
omap <Left> [
xmap <Left> [
nmap <Right> ]
omap <Right> ]
xmap <Right> ]
" }}}
