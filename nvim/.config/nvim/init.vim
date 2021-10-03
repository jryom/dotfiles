:lua require("plugins")
:lua require("theme")
:lua require("treesitter")

set colorcolumn=999
set expandtab
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=99
set foldmethod=expr
set foldminlines=3
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
set scrolloff=8
set shiftround
set shortmess+=actFTWI
set signcolumn=yes
set splitbelow splitright
set pumblend=15 winblend=15
set termguicolors
set undofile
set updatetime=200

augroup autocommands
  autocmd!
  autocmd BufEnter * :syntax sync fromstart
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
  autocmd BufRead,BufNewFile .{eslint,babel,stylelint,prettier}rc set ft=json5
  autocmd BufWritePost *.lua silent! !stylua --config-path ~/.config/stylua/stylua.toml %:p
  autocmd BufWritePost *.lua silent! edit
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  autocmd BufWritePre * %s/\s\+$//e
  autocmd SessionLoadPost,VimResized * wincmd =
  autocmd WinEnter,BufWinEnter * setlocal cursorline | autocmd WinLeave * setlocal nocursorline
augroup END

" Plugin settings: {{{
let g:fzf_preview_window = []
let g:fzf_layout = { 'window': { 'width': 0.6, 'height': 0.6, 'border': 'sharp' } }
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:rooter_silent_chdir = 1

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
nnoremap <leader><leader> :update<cr>
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
nmap <leader>p <plug>(coc-diagnostic-prev)
nmap <leader>n <plug>(coc-diagnostic-next)
nmap <leader>f <plug>(coc-format)
xmap <leader>f <plug>(coc-format-selected)
nmap <leader>a <plug>(coc-codeaction)
nmap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-j>"
nmap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-k>"

" fzf
command! -bang -nargs=* RgOnlyLines call fzf#vim#grep('rg '.shellescape(<q-args>), 1, fzf#vim#with_preview({'options':'--delimiter : --nth 3..'}), <bang>0)
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
