if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'airblade/vim-rooter'
Plug 'asheq/close-buffers.vim'
Plug 'cocopon/vaffle.vim'
Plug 'cohama/lexima.vim'
Plug 'cormacrelf/dark-notify'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'romainl/vim-qf'
Plug 'sainnhe/edge'
Plug 'sainnhe/gruvbox-material'
Plug 'sheerun/vim-polyglot'
Plug 'simnalamburt/vim-mundo'
Plug 'styled-components/vim-styled-components', {'branch':'main'}
Plug 'thaerkh/vim-workspace'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-test/vim-test'
Plug 'wellle/targets.vim'
call plug#end()

if ! filereadable(expand("~/.config/nvim/lastupdate"))
      \ || readfile(glob("~/.config/nvim/lastupdate"))[0] < (localtime() - 604800)
  execute 'PlugUpdate'
  silent execute '!echo ' . (localtime()) . ' > ~/.config/nvim/lastupdate'
endif

set diffopt+=algorithm:patience,indent-heuristic
set gdefault
set hidden
set hlsearch
set lazyredraw
set ignorecase smartcase
set inccommand=split
set matchpairs+=<:>
set mouse=a
set noshowmode
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set number relativenumber
set noshowcmd
set pumblend=10
set rtp+=/usr/local/opt/fzf
set sessionoptions-=help
set shiftround
set shortmess+=acWI
set signcolumn=yes
set splitbelow splitright
set termguicolors
set undofile
set updatetime=200

" theme
let g:gruvbox_material_sign_column_background = 'none'
let g:edge_sign_column_background = 'none'
if len(systemlist('defaults read -g AppleInterfaceStyle'))==1
  set background=dark
  colorscheme gruvbox-material
else
  set background=light
  colorscheme edge
endif
lua << EOF
  require('dark_notify').run({
    schemes = {
      dark  = "gruvbox-material",
      light = "edge"
    },
  })
EOF

augroup autocommands
  autocmd!
  autocmd BufRead,BufNewFile .{eslint,babel,stylelint,prettier}rc set ft=json5
  autocmd BufEnter *.js :syntax sync fromstart
  autocmd SessionLoadPost,VimResized * wincmd =
  autocmd WinEnter,BufWinEnter * setlocal cursorline | autocmd WinLeave * setlocal nocursorline
  autocmd BufWritePre * %s/\s\+$//e
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
augroup END

" airline
call airline#parts#define_minwidth('branch', 180)
call airline#parts#define_minwidth('coc_status', 180)
call airline#parts#define_minwidth('filetype', 100)
let g:airline#extensions#whitespace#enabled = 0
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_left_alt_sep = '┊'
let g:airline_left_sep=''
let g:airline_powerline_fonts = 1
let g:airline_right_alt_sep = '┊'
let g:airline_right_sep=''
let g:airline_section_z = '%3l/%L:%2v'
if !exists('g:airline_symbols')
  let g:airline_symbols = {'dirty':'!'}
endif

" coc
let g:coc_global_extensions = [
      \ 'coc-css',
      \ 'coc-eslint',
      \ 'coc-flow',
      \ 'coc-git',
      \ 'coc-highlight',
      \ 'coc-html',
      \ 'coc-json',
      \ 'coc-prettier',
      \ 'coc-snippets',
      \ 'coc-styled-components',
      \ 'coc-stylelintplus',
      \ 'coc-tsserver',
      \ 'coc-yaml',
      \ ]

" fzf
let g:fzf_history_dir = '~/.local/share/fzf-history'
command! -bang -nargs=* RgOnlyLines call fzf#vim#grep('rg '.shellescape(<q-args>), 1,
      \ fzf#vim#with_preview({'options':'--delimiter : --nth 3..'}), <bang>0)

" vim workspace
let g:workspace_session_disable_on_args = 1
let g:workspace_autosave = 0
let g:workspace_persist_undo_history = 0
let g:workspace_session_directory = $HOME.'/.local/share/nvim/sessions/'

" misc
let g:qf_shorten_path = 3
let g:javascript_plugin_flow = 1
let g:javascript_plugin_jsdoc = 1
let g:mundo_preview_bottom = 1
let g:vaffle_show_hidden_files = 1
let test#strategy = "kitty"

" keymaps
" misc
let mapleader = ' '
nnoremap <leader>w :update<cr>
nnoremap <silent> dm :execute 'delmarks '.nr2char(getchar())<cr>
nnoremap <silent> <Esc> :nohl<cr><Esc>
nnoremap <silent> <C-t> :tabnew %<cr>
nnoremap <silent> - :call vaffle#init(expand('%'))<cr>
nnoremap <silent> Q :Bdelete menu<cr>
nnoremap <leader>tw :ToggleWorkspace<cr>
nnoremap <leader>u :MundoToggle<cr>
nnoremap <Leader>s :%s/<C-r><C-w>//c <Left><Left><Left>
xnoremap <Leader>s "sy:%s/<C-r>s//c <Left><Left><Left>
xnoremap ga <Plug>(EasyAlign)

nnoremap <leader>c <Plug>(qf_qf_toggle)
nnoremap ç <Plug>(qf_qf_switch)

" tabs
nnoremap <silent> <leader>1 1gt
nnoremap <silent> <leader>2 2gt
nnoremap <silent> <leader>3 3gt
nnoremap <silent> <leader>4 4gt
nnoremap <silent> <leader>5 5gt
nnoremap <silent> <C-Q> :tabclose<cr>

" coc
imap <silent> <C-l> <Plug>(coc-snippets-expand-jump)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gh :call CocAction('doHover')<cr>
nmap <silent> <leader>g <Plug>(coc-git-commit)
nmap <silent> <leader>p <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>n <Plug>(coc-diagnostic-next)
nmap <silent> <leader>f <Plug>(coc-format)
nmap <silent> <leader>cm :CocCommand<cr>
nmap <silent> <leader>l :CocList<cr>
nmap <silent> <leader>d :CocList diagnostics<cr>
nmap <silent> <leader>a <Plug>(coc-codeaction)
vmap <silent> <leader>a <Plug>(coc-codeaction-selected)

" fzf
nnoremap <silent> <leader>b :Buffers<cr>
nnoremap <silent> <leader>I :Rg <cr>
nnoremap <silent> <leader>i :RgOnlyLines <cr>
xnoremap <silent> <leader>i "fy :Rg <C-R>f<cr>
nnoremap <silent> <leader>o :Files<cr>
nnoremap <silent> <leader>q :History:<cr>

" unimpaired on non-US layouts
nmap <Left> [
omap <Left> [
xmap <Left> [
nmap <Right> ]
omap <Right> ]
xmap <Right> ]

" vim-test
nnoremap <silent> <leader>tf :TestFile<cr>
nnoremap <silent> <leader>tn :TestNearest<cr>
nnoremap <silent> <leader>ts :TestSuite<cr>
