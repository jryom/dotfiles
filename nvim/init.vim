if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'asheq/close-buffers.vim'
Plug 'cocopon/vaffle.vim'
Plug 'cohama/lexima.vim'
Plug 'cormacrelf/dark-notify'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'mhinz/vim-grepper'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sainnhe/edge'
Plug 'sainnhe/gruvbox-material'
Plug 'sheerun/vim-polyglot'
Plug 'simnalamburt/vim-mundo'
Plug 'styled-components/vim-styled-components', {'branch':'main'}
Plug 'thaerkh/vim-workspace'
Plug 'tomtom/tcomment_vim'
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

set gdefault
set hlsearch
set ignorecase smartcase
set inccommand=split
set matchpairs+=<:>
set mouse=a
set noshowmode
set number relativenumber
set pumblend=10
set rtp+=/usr/local/opt/fzf
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
let g:airline#extensions#branch#displayed_head_limit = 20
let g:airline#extensions#branch#format = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_count = 0
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_inactive_collapse = 1
let g:airline_powerline_fonts = 1
let g:airline_section_z = '%3l/%L:%2v'
let g:airline_skip_empty_sections = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {'dirty':'!'}
endif

" coc
let g:coc_global_extensions = [
      \ 'coc-css',
      \ 'coc-eslint',
      \ 'coc-flow',
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
let g:fzf_layout = { 'window': { 'width': 0.7, 'height': 0.8 } }
command! -bang -nargs=* Rg call fzf#vim#grep('rg '.shellescape(<q-args>), 1,
      \ fzf#vim#with_preview({'options':'--delimiter : --nth 3..'}), <bang>0)

" vim workspace
let g:workspace_session_disable_on_args = 1
let g:workspace_autosave = 0
let g:workspace_persist_undo_history = 0
let g:workspace_session_directory = $HOME.'/.local/share/nvim/sessions/'

" misc
let g:grepper = { "tools": ['rg'] }
let g:javascript_plugin_flow = 1
let g:javascript_plugin_jsdoc = 1
let g:mundo_preview_bottom = 1
let g:mundo_verbose_graph = 0
let g:vaffle_show_hidden_files = 1
let test#strategy = "kitty"

" keymaps
" misc
let mapleader = ' '
nnoremap <silent> <leader> w :w<cr>
nnoremap <silent> dm :execute 'delmarks '.nr2char(getchar())<cr>
nnoremap <silent> <Esc> :nohl<CR><Esc>
nnoremap <silent> <C-t> :tabnew %<CR>
nnoremap <leader>g :G<cr>
xnoremap <leader>g :Gclog<cr>
nnoremap <silent> - :call vaffle#init(expand('%'))<CR>
nnoremap <silent> <c-Q> :Bdelete menu<CR>
xnoremap ga <Plug>(EasyAlign)
nnoremap <leader>tw :ToggleWorkspace<CR>
nnoremap <leader>u :MundoToggle<CR>

" airline
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" coc
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gtd <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
imap <silent> <C-l> <Plug>(coc-snippets-expand-jump)
nmap <silent> gh :call CocAction('doHover')<cr>
nmap <silent> <leader>p <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>n <Plug>(coc-diagnostic-next)
nmap <silent> <leader>f <Plug>(coc-format)
nmap <silent> <leader>c :CocCommand<CR>
nmap <silent> <leader>a <Plug>(coc-codeaction)
vmap <silent> <leader>a <Plug>(coc-codeaction-selected)

" fzf
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>i :Rg <cr>
xnoremap <leader>i "fy :Rg <C-R>f<cr>
nnoremap <leader>m :Marks<cr>
nnoremap <leader>o :Files<cr>
nnoremap <leader>q :History:<cr>
nnoremap <leader>/ :BLines<cr>
nnoremap <leader>G :BCommits<cr>

" unimpaired
nmap <Left> [
omap <Left> [
xmap <Left> [
nmap <Right> ]
omap <Right> ]
xmap <Right> ]

" vim-grepper
" substitute current/selected word in file
nnoremap <Leader>s :%s/<C-r><C-w>//c <Left><Left><Left>
xnoremap <Leader>s "sy:%s/<C-r>s//c <Left><Left><Left>
" substitute current/selected d in cwd
nnoremap <Leader>S
  \ :Grepper -cword -noprompt<CR>
  \ :cfdo %s/<C-r><C-w>//c \| update
  \ <C-Left><C-Left><Left><Left><Left>
xmap <Leader>S
  \ "sy \|
  \ :Grepper <C-r>s<CR>
  \ :cfdo %s/<C-r>s//c \| update
  \ <C-Left><C-Left><Left><Left><Left>
