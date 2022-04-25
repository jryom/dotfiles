:lua require('impatient')
:lua require("plugins")

set colorcolumn=999
set expandtab
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=99
set foldminlines=3
set gdefault
set grepformat=%f:%l:%c:%m,%f:%l:%m
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set hlsearch
set ignorecase smartcase
set inccommand=split
set matchpairs+=<:>
set mouse=a
set number relativenumber
set noshowmode
set shiftround
set shortmess+=actFTWI
set signcolumn=yes
set splitbelow splitright
set termguicolors
set undofile
set updatetime=200

if len(systemlist('defaults read -g AppleInterfaceStyle'))==1 | set bg=dark | else | set bg=light | endif
let g:zenbones_compat = 1
colorscheme zenbones

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
  autocmd TermOpen * setlocal nonumber norelativenumber
  autocmd WinEnter,BufWinEnter * setlocal cursorline | autocmd WinLeave * setlocal nocursorline
  autocmd VimEnter * nested
    \ if !argc() && empty(v:this_session) && filereadable('Session.vim') |
    \   source Session.vim |
    \ endif
augroup END

" Plugin settings: {{{
let g:rooter_silent_chdir = 1

command! Up execute 'PackerSync'

" Keymaps: {{{
let mapleader = ' '
nnoremap <expr> j v:count == 0 ? 'gj' : "\<Esc>".v:count.'j'
nnoremap <expr> k v:count == 0 ? 'gk' : "\<Esc>".v:count.'k'
nnoremap <c-w>m :MaximizerToggle<cr>
xnoremap < <gv
xnoremap > >gv
nnoremap gt <C-]>
nnoremap <silent> <Esc> :nohlsearch<cr>
nmap <silent> <leader>q <Plug>(qf_qf_toggle)
nnoremap <leader>u :MundoToggle<cr>
nnoremap <leader>r :%s/<C-r><C-w>//c <Left><Left><Left>
xnoremap <leader>r "sy:%s/<C-r>s//c <Left><Left><Left>
nnoremap <leader>g :silent grep<Space>
nnoremap <leader>m :MarkdownPreviewToggle<cr>
map s <cmd>HopWord<cr>
map gl <cmd>HopLineStart<cr>
nnoremap <leader><leader> :write<cr>
xmap ga <plug>(EasyAlign)
nnoremap <leader>ts :Obsession<cr>
nnoremap <silent> gx :execute 'silent! !open ' . shellescape(expand('<cWORD>'), 1)<cr>

" close-buffers
nnoremap Q  :Bdelete menu<cr>
nnoremap Qa :Bdelete all<cr>
nnoremap Qh :Bdelete hidden<cr>
nnoremap Qo :Bdelete other<cr>
nnoremap Qt :Bdelete this<cr>
nnoremap Qs :Bdelete select<cr>

" coc
function s:complete()
   if !pumvisible() || get(complete_info(), 'selected', -1) < 0
      return coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" : coc#refresh()
   else
      return "\<C-y>"
   endif
endfunction

inoremap <silent><expr> <C-l> <SID>complete()
inoremap <silent><expr> <C-n> pumvisible() ? "\<C-n>" : coc#refresh()
nmap gd <plug>(coc-definition)
nnoremap gh :call CocActionAsync('doHover')<cr>
nnoremap <leader>c :CocCommand<cr>
nnoremap <leader>l :CocList<cr>
nmap <leader>p <plug>(coc-diagnostic-prev)
nmap <leader>n <plug>(coc-diagnostic-next)
nmap <leader>f <plug>(coc-format)
xmap <leader>f <plug>(coc-format-selected)
nmap <leader>a <plug>(coc-codeaction)
nmap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-j>"
nmap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-k>"

" telescope
xnoremap <silent> <leader>i "fy :lua require("telescope.builtin").grep_string({search=vim.fn.getreg('f')})<cr>
nnoremap <silent> <leader>i <cmd>Telescope live_grep<cr>
nnoremap <silent> <leader>o <cmd>Telescope find_files<cr>
nnoremap <silent> <leader>b <cmd>Telescope buffers<cr>

" tabs
nnoremap <silent> <C-t>n :tabnew %<cr>
nnoremap <silent> <C-t><C-n> :tabnew %<cr>
nnoremap <silent> <C-t>c :tabclose<cr>
nnoremap <silent> <C-t><C-c> :tabclose<cr>
nnoremap <silent> <C-t>h :tabprevious<cr>
nnoremap <silent> <C-t><C-h> :tabprevious<cr>
nnoremap <silent> <C-t>l :tabnext<cr>
nnoremap <silent> <C-t><C-l> :tabnext<cr>
nnoremap <silent> <C-t>1 1gt
nnoremap <silent> <C-t>2 2gt
nnoremap <silent> <C-t>3 3gt
nnoremap <silent> <C-t>4 4gt
nnoremap <silent> <C-t>5 5gt
nnoremap <silent> <C-t>6 6gt
nnoremap <silent> <C-t>7 7gt
nnoremap <silent> <C-t>8 8gt
nnoremap <silent> <C-t>9 9gt

" unimpaired on non-US layouts
nmap <Left> [
omap <Left> [
xmap <Left> [
nmap <Right> ]
omap <Right> ]
xmap <Right> ]
" }}}
