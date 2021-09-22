:lua require('plugins')
:lua require('lsp')

set colorcolumn=999
set encoding=utf-8 | scriptencoding utf-8
set expandtab
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=99
set foldmethod=expr
set foldminlines=3
set gdefault
set grepformat=%f:%l:%c:%m,%f:%l:%m
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set hlsearch
set ignorecase smartcase
set inccommand=split
set matchpairs+=<:>
set mouse=a
set noshowmode
set number relativenumber
set pumblend=12 winblend=12
set scrolloff=8
set shiftround
set signcolumn=yes
set splitbelow splitright
set termguicolors
set undofile

augroup autocommands
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  autocmd BufEnter * :syntax sync fromstart
  autocmd BufRead,BufNewFile .{eslint,babel,stylelint,prettier}rc set ft=json5
  autocmd SessionLoadPost,VimResized * wincmd =
  autocmd WinEnter,BufWinEnter * setlocal cursorline | autocmd WinLeave * setlocal nocursorline
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
  autocmd VimEnter * nested
    \ if !argc() && empty(v:this_session) && filereadable('Session.vim') |
    \   source Session.vim |
    \ endif
augroup END

" Plugin settings: {{{
let g:rooter_silent_chdir = 1
let g:indent_blankline_filetype_exclude = ['help','markdown']
let g:indent_blankline_char = '▏'
let g:indent_blankline_use_treesitter = v:true
let g:indent_blankline_show_trailing_blankline_indent = v:false
let g:vsnip_snippet_dir = '~/.config/nvim/snippets'
let g:gitblame_date_format = '%r'
let g:Hexokinase_virtualText = '▮'
let g:Hexokinase_optInPatterns = 'full_hex,rgb,rgba,hsl,hsla'

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
nnoremap <leader>u :MundoToggle<cr>
nnoremap <leader>r :%s/<C-r><C-w>//c <Left><Left><Left>
xnoremap <leader>r "sy:%s/<C-r>s//c <Left><Left><Left>
nnoremap <leader>g :silent grep<Space>
nnoremap <leader>m :MarkdownPreviewToggle<cr>
map <leader>w <cmd>HopWord<cr>
map <leader>s <cmd>HopLineStart<cr>
nnoremap <leader><leader> :write<cr>
xmap ga <plug>(EasyAlign)
nnoremap <leader>ts :Obsession<cr>

" close-buffers
nnoremap Q  :Bdelete menu<cr>
nnoremap Qa :Bdelete all<cr>
nnoremap Qh :Bdelete hidden<cr>
nnoremap Qo :Bdelete other<cr>
nnoremap Qt :Bdelete this<cr>
nnoremap Qs :Bdelete select<cr>

" tabs
nnoremap <silent> <C-t> :tabnew %<cr>
nnoremap <silent> <C-q> :tabclose<cr>

" telescope
nnoremap <silent> <leader>i :Telescope live_grep<cr>
nnoremap <silent> <leader>o :Telescope find_files<cr>
nnoremap <silent> <leader>b :Telescope buffers <cr>

" unimpaired on non-US layouts
nmap <Left> [
omap <Left> [
xmap <Left> [
nmap <Right> ]
omap <Right> ]
xmap <Right> ]
" }}}
"
