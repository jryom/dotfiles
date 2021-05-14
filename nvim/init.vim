if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'airblade/vim-rooter'
Plug 'asheq/close-buffers.vim'
Plug 'cocopon/vaffle.vim'
Plug 'cormacrelf/dark-notify'
Plug 'honza/vim-snippets'
Plug 'jlanzarotta/bufexplorer'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'raimondi/delimitmate'
Plug 'romainl/vim-qf'
Plug 'sainnhe/edge'
Plug 'sainnhe/gruvbox-material'
Plug 'sheerun/vim-polyglot'
Plug 'simnalamburt/vim-mundo'
Plug 'szw/vim-maximizer'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'wellle/targets.vim'
call plug#end()

command! Up execute 'PlugUpgrade | PlugUpdate | silent execute "!echo " . (localtime()) . " > /tmp/lastupdatevim"'

if ! filereadable(expand('/tmp/lastupdatevim')) || readfile('/tmp/lastupdatevim')[0] < (localtime() - 60 * 60 * 24 * 7)
  execute 'Up'
endif

set foldlevel=4
set foldmethod=indent
set foldnestmax=1
set gdefault
set hidden
set hlsearch
set ignorecase smartcase
set inccommand=split
set iskeyword+=-
set matchpairs+=<:>
set mouse=a
set noshowmode
set number relativenumber
set rtp+=/usr/local/opt/fzf
set shiftround
set shortmess+=acWI
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
  autocmd TermEnter * setlocal nonumber norelativenumber
  autocmd VimEnter * nested
        \ if !argc() && empty(v:this_session) && filereadable('Session.vim') |
        \   source Session.vim |
        \ endif
augroup END

" THEME SETTINGS: {{{
let g:edge_better_performance = 1
let g:edge_diagnostic_line_highlight = 1
let g:edge_sign_column_background = 'none'
let g:gruvbox_material_better_performance = 1
let g:gruvbox_material_diagnostic_line_highlight = 1
let g:gruvbox_material_sign_column_background = 'none'
if len(systemlist('defaults read -g AppleInterfaceStyle'))==1
  set background=dark
  colorscheme gruvbox-material
else
  set background=light
  colorscheme edge
endif

lua << EOF
require'nvim-treesitter.configs'.setup({
  ensure_installed = "maintained",
  highlight = { enable = false },
})
require('dark_notify').run({
  schemes = {
    dark  = "gruvbox-material",
    light = "edge"
  },
})
EOF
" }}}

" PLUGIN SETTINGS: {{{
" misc plugin settings
let g:vaffle_show_hidden_files = 1
let g:vimsyn_embed = 'l'
let g:rooter_silent_chdir = 1

" airline
call airline#parts#define_minwidth('branch', 120)
call airline#parts#define_minwidth('coc_status', 100)
call airline#parts#define_minwidth('filetype', 90)
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#scrollbar#enabled = 0
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_left_alt_sep = '┊'
let g:airline_left_sep=''
let g:airline_powerline_fonts = 1
let g:airline_right_alt_sep = '┊'
let g:airline_right_sep=''
let g:airline_section_z = '%3l/%L:%2v'
let g:airline_mode_map = {'__':'-','c':'C','i':'I','ic':'I','ix':'I','n':'N','multi':'M','ni':'N','no':'N','R':'R','Rv':'R','s':'S','S':'S','':'S','t':'T','v':'V','V':'V','':'V',}
if !exists('g:airline_symbols')
  let g:airline_symbols = {'dirty':'*'}
endif

" bufexplorer
let g:bufExplorerDefaultHelp=0
let g:bufExplorerDisableDefaultKeyMapping=1
let g:bufExplorerShowRelativePath=1

" coc
let g:coc_global_extensions = [
      \ 'coc-css',
      \ 'coc-eslint',
      \ 'coc-git',
      \ 'coc-html',
      \ 'coc-json',
      \ 'coc-prettier',
      \ 'coc-snippets',
      \ 'coc-styled-components',
      \ 'coc-stylelintplus',
      \ 'coc-tsserver',
      \ 'coc-vimlsp',
      \ 'coc-yaml',
      \ ]

" fzf
let g:fzf_layout = { 'window': 'enew' }
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
nnoremap <leader>w :write<cr>
nnoremap <C-w>m :MaximizerToggle!<cr>
nnoremap <leader>z zA
nnoremap <expr> <leader>x &foldlevel ? 'zM' :'zR'
nnoremap <leader>ts :Obsession<cr>
nnoremap <leader>u :MundoToggle<cr>
nnoremap <Leader>r :%s/<C-r><C-w>//c <Left><Left><Left>
xnoremap <Leader>r "sy:%s/<C-r>s//c <Left><Left><Left>
xnoremap < <gv
xnoremap > >gv
xmap ga <Plug>(EasyAlign)
nnoremap <leader>b :ToggleBufExplorer <cr>
nmap <silent> <leader>q <Plug>(qf_qf_toggle)

" tabs
nnoremap <silent> <C-t> :tabnew %<cr>
nnoremap <silent> <C-q> :tabclose<cr>
nnoremap <silent> <leader>1 1gt
nnoremap <silent> <leader>2 2gt
nnoremap <silent> <leader>3 3gt
nnoremap <silent> <leader>4 4gt
nnoremap <silent> <leader>5 5gt

" close-buffers
nnoremap Q :Bdelete menu<cr>
nnoremap Qa :Bdelete all<cr>
nnoremap Qh :Bdelete hidden<cr>
nnoremap Qo :Bdelete other<cr>
nnoremap Qt :Bdelete this<cr>
nnoremap Qs :Bdelete select<cr>

" coc
imap <silent> <C-l> <Plug>(coc-snippets-expand-jump)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gh :call CocAction('doHover')<cr>
nmap <silent> <leader>g <Plug>(coc-git-commit)
nmap <silent> <leader>c :CocCommand<cr>
nmap <silent> <leader>d :CocDiagnostics<cr>
nmap <silent> <leader>l :CocList<cr>
nmap <silent> <leader>p <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>n <Plug>(coc-diagnostic-next)
nmap <silent> <leader>f <Plug>(coc-format)
vmap <silent> <leader>f <Plug>(coc-format-selected)
nmap <silent> <leader>a <Plug>(coc-codeaction)
vmap <silent> <leader>a <Plug>(coc-codeaction-selected)
nnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-j>"
nnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-k>"

" fzf
nnoremap <silent> <leader>I :Rg <cr>
nnoremap <silent> <leader>i :RgOnlyLines <cr>
xnoremap <silent> <leader>i "fy :Rg <C-R>f<cr>
nnoremap <silent> <leader>o :Files<cr>
nnoremap <silent> <leader>/ :BLines<cr>

" unimpaired on non-US layouts
nmap <Left> [
omap <Left> [
xmap <Left> [
nmap <Right> ]
omap <Right> ]
xmap <Right> ]
" }}}
"
let g:neovide_cursor_animation_length=0.1
