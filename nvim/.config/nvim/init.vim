call plug#begin('~/.config/nvim/plugged')
Plug 'airblade/vim-rooter'
Plug 'asheq/close-buffers.vim'
Plug 'bronson/vim-visual-star-search'
Plug 'cormacrelf/dark-notify'
Plug 'honza/vim-snippets'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'phaazon/hop.nvim'
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
Plug 'tpope/vim-vinegar'
Plug 'windwp/nvim-autopairs'
call plug#end()

command! Up execute 'PlugUpgrade | PlugUpdate'
command! -bang -nargs=* RgOnlyLines call fzf#vim#grep('rg '.shellescape(<q-args>), 1, fzf#vim#with_preview({'options':'--delimiter : --nth 3..'}), <bang>0)

set colorcolumn=999
set foldminlines=3
set foldlevelstart=99
set foldexpr=nvim_treesitter#foldexpr()
set foldmethod=expr
set gdefault
set grepformat=%f:%l:%c:%m,%f:%l:%m
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set hidden
set hlsearch
set ignorecase smartcase
set inccommand=split
set matchpairs+=<:>
set mouse=a
set number relativenumber
set rtp+=/usr/local/opt/fzf
set expandtab
set scrolloff=8
set shiftround
set shortmess+=actFTWI
set signcolumn=yes
set splitbelow splitright
set termguicolors
set undofile
set updatetime=200

augroup autocommands
  autocmd!
  autocmd BufEnter * :syntax sync fromstart
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

" Theme settings: {{{
let g:edge_better_performance = 1
let g:edge_diagnostic_line_highlight = 1
let g:edge_style = 'neon'
if len(systemlist('defaults read -g AppleInterfaceStyle'))==1 | set bg=dark | else | set bg=light | endif
colorscheme edge
" }}}

" Lua: {{{
lua << EOF
require('nvim-autopairs').setup()
require('nvim-treesitter.configs').setup({
  autopairs = { enable = true },
  ensure_installed = "maintained",
  highlight = { enable = true },
  indent = { enable = true }
})
require('dark_notify').run()
EOF
" }}}

" Plugin settings: {{{
let g:rooter_silent_chdir = 1
let g:indent_blankline_filetype_exclude = ['help','vaffle','markdown']
let g:indent_blankline_use_treesitter = v:true
let g:indent_blankline_show_trailing_blankline_indent = v:false
let g:coc_global_extensions = [
      \ 'coc-css',
      \ 'coc-diagnostic',
      \ 'coc-eslint',
      \ 'coc-html',
      \ 'coc-git',
      \ 'coc-json',
      \ 'coc-prettier',
      \ 'coc-snippets',
      \ 'coc-styled-components',
      \ 'coc-stylelintplus',
      \ 'coc-tsserver',
      \ ]
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Keymaps: {{{
let mapleader = ' '
nnoremap <expr> j v:count == 0 ? 'gj' : "\<Esc>".v:count.'j'
nnoremap <expr> k v:count == 0 ? 'gk' : "\<Esc>".v:count.'k'
nnoremap <c-w>m :MaximizerToggle<cr>
nnoremap Y y$
xnoremap < <gv
xnoremap > >gv
nnoremap <silent> <Esc> :nohlsearch<cr>
nmap <silent> <leader>q <Plug>(qf_qf_toggle)
nnoremap <leader>ts :Obsession<cr>
nnoremap <leader>u :MundoToggle<cr>
nnoremap <leader>r :%s/<C-r><C-w>//c <Left><Left><Left>
xnoremap <leader>r "sy:%s/<C-r>s//c <Left><Left><Left>
nnoremap <leader>g :silent grep<Space>
nnoremap <leader>m :MarkdownPreviewToggle<cr>
map <leader>w <cmd>HopWord<cr>
map <leader>s <cmd>HopLineStart<cr>
xmap ga <plug>(EasyAlign)

" close-buffers
nnoremap Q  :Bdelete menu<cr>
nnoremap Qa :Bdelete all<cr>
nnoremap Qh :Bdelete hidden<cr>
nnoremap Qo :Bdelete other<cr>
nnoremap Qt :Bdelete this<cr>
nnoremap Qs :Bdelete select<cr>

" coc
inoremap <silent><expr> <C-l> pumvisible() ? "\<C-y>" : coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" : coc#refresh()
inoremap <silent><expr> <C-n> pumvisible() ? "\<C-n>" : coc#refresh()
nmap gd <plug>(coc-definition)
nnoremap gh :call CocAction('doHover')<cr>
nnoremap <leader>c :CocCommand<cr>
nnoremap <leader>l :CocList<cr>
nmap [d <plug>(coc-diagnostic-prev)
nmap ]d <plug>(coc-diagnostic-next)
nmap <leader>f <plug>(coc-format)
xmap <leader>f <plug>(coc-format-selected)
nmap <leader>a <plug>(coc-codeaction)
nmap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-j>"
nmap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-k>"

" fzf
nnoremap <silent> <leader>I :Rg <cr>
nnoremap <silent> <leader>i :RgOnlyLines <cr>
xnoremap <silent> <leader>i "fy :Rg <C-R>f<cr>
nnoremap <silent> <leader>o :Files<cr>
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
