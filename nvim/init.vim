if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'alvan/vim-closetag'
Plug 'asheq/close-buffers.vim'
Plug 'bronson/vim-visual-star-search'
Plug 'cohama/lexima.vim'
Plug 'cormacrelf/dark-notify'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'lambdalisue/fern.vim'
Plug 'mhinz/vim-grepper'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rhysd/git-messenger.vim'
Plug 'sainnhe/edge'
Plug 'sainnhe/gruvbox-material'
Plug 'sheerun/vim-polyglot'
Plug 'styled-components/vim-styled-components', {'branch':'main'}
Plug 'thaerkh/vim-workspace'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
call plug#end()

if ! filereadable(expand("~/.config/nvim/lastupdate"))
      \ || readfile(glob("~/.config/nvim/lastupdate"))[0] < (localtime() - 604800)
  execute 'PlugUpdate'
  silent execute '!echo ' . (localtime()) . ' > ~/.config/nvim/lastupdate'
endif

set gdefault
set hidden
set hlsearch
set ignorecase smartcase
set inccommand=split
set matchpairs+=<:>
set mouse=a
set noshowmode
set pumblend=10
set rtp+=/usr/local/opt/fzf
set scrolloff=5
set shiftround
set shortmess+=acWI
set signcolumn=yes
set splitbelow splitright
set termguicolors
set undofile
set updatetime=100

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
:lua <<EOF
  require('dark_notify').run({
    schemes = {
      dark  = "gruvbox-material",
      light = "edge"
    },
  })
EOF

augroup autocommands
  autocmd!
  autocmd BufRead,BufNewFile .{eslint,babel,stylelint,prettier}rc set ft=json
  autocmd BufEnter * :syntax sync fromstart
  autocmd SessionLoadPost,VimResized * wincmd =
  autocmd WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
  autocmd BufWritePre * %s/\s\+$//e
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
augroup END

" misc
let mapleader = ' '
nnoremap <silent> <Esc> :nohl<CR><Esc>
nnoremap <silent> <C-q> :Bdelete menu<CR>
xnoremap ga <Plug>(EasyAlign)
let g:closetag_filetypes = 'html,xhtml,jsx,javascript'
let g:javascript_plugin_flow = 1
let g:javascript_plugin_jsdoc = 1
nnoremap <silent> - :Fern . -reveal=%<CR>
nnoremap <leader>g :GitMessenger<cr>
nmap <Up> <C-y>
nmap <Down> <C-e>
nmap <Left> [
omap <Left> [
xmap <Left> [
nmap <Right> ]
omap <Right> ]
xmap <Right> ]
let g:fern#default_hidden = 1

let g:grepper = {}
let g:grepper.tools = ['rg']
" substitute current/selected word in file
nnoremap <Leader>s :%s/<C-r><C-w>//c<Left><Left>
xnoremap <Leader>s "sy:%s/<C-r>s//c<Left><Left>
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

" airline
let g:airline#extensions#whitespace#enabled = 0
let g:airline_section_z = '%3l/%L:%2v'
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_inactive_collapse = 1
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
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
imap <silent> <C-l> <Plug>(coc-snippets-expand-jump)
nmap <silent> gh :call CocAction('doHover')<cr>
nmap <silent> <leader>N <Plug>(coc-diagnostic-next)
nmap <silent> <leader>n <Plug>(coc-diagnostic-next)
nmap <silent> <leader>f <Plug>(coc-format)
nmap <silent> <leader>a <Plug>(coc-codeaction)
nmap <silent> <leader>c :CocCommand<CR>
vmap <silent> <leader>a <Plug>(coc-codeaction-selected)
nmap <silent> <leader>r <Plug>(coc-rename)
nmap <silent> <leader>R <Plug>(coc-refactor)

" fzf
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_layout = { 'window': { 'width': 0.7, 'height': 0.8 } }
command! -bang -nargs=* Rg call fzf#vim#grep('rg '.shellescape(<q-args>), 1,
      \ fzf#vim#with_preview({'options':'--delimiter : --nth 3..'}), <bang>0)
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>i :Rg <cr>
xnoremap <leader>i "fy :Rg <C-R>f<cr>
nnoremap <leader>o :Files<cr>

" vim workspace
let g:workspace_session_disable_on_args = 1
let g:workspace_autosave = 0
let g:workspace_persist_undo_history = 0
let g:workspace_session_directory = $HOME.'/.local/share/nvim/sessions/'
nnoremap <leader>w :ToggleWorkspace<CR>
