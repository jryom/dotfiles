" Install Vim Plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.local/share/nvim/plugged')

" Language, autocompletion & linting
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'sheerun/vim-polyglot'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'w0rp/ale'

" UI
Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'majutsushi/tagbar'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'Valloric/MatchTagAlways'
Plug 'ap/vim-css-color'

" Themes
Plug 'lifepillar/vim-solarized8'
Plug 'joshdick/onedark.vim'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'sodapopcan/vim-twiggy'
Plug 'tpope/vim-fugitive'

" Editing and additional stuff
Plug 'alvan/vim-closetag'
Plug 'editorconfig/editorconfig-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'

call plug#end()

" Basic config
set confirm
set cursorline
set foldlevelstart=20
set foldmethod=syntax
set exrc
set expandtab
set gdefault
set ignorecase
set iskeyword+=-
set laststatus=2
set list
set matchpairs+=<:>
set mouse=a
set nobackup
set noshowcmd
set noshowmode
set nostartofline
set noswapfile
set novisualbell
set nowritebackup
set number
set secure
set shiftround
set shiftwidth=2
set showmatch
set smartcase
set smartindent
set softtabstop=2
set splitbelow
set splitright
set tabstop=2
set termguicolors
set wildcharm=<TAB>
set wildignore+=*/.cache,*/.git,*/.svn/*,*/.DS_Store,*/node_modules,*/.vscode,*/.Trash

" Mappings

" leader
let mapleader=","

" virtual old school
nnoremap ; :
vnoremap ; :

" move vertically by visual line
nnoremap j gj
nnoremap k gk


" nerdtree
map <leader>b :NERDTreeToggle<CR>
let g:NERDTreeWinSize = 45
let g:NERDTreeRespectWildIgnore=1
let g:NERDTreeShowHidden=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeQuitOnOpen = 1
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''

" twiggy
map <silent> <leader>g :set nosplitright<cr> :Twiggy<cr> :set splitright<cr>
let g:twiggy_group_locals_by_slash = 0
let g:twiggy_remote_branch_sort = 'date'
let g:twiggy_num_columns = 45

" toggle tagbar
nmap <leader>v :TagbarToggle<CR>
let g:tagbar_width = 45
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#file#enable_buffer_path = 1
let g:neosnippet#enable_completed_snippet = 1
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
inoremap <expr><Tab> pumvisible() ? "\<c-n>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" move lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" remove search highlighting with ESC
nnoremap <silent> <Esc> :nohl<CR><Esc>

" fzf / ag
let $FZF_DEFAULT_COMMAND='fd --type f'
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit' }

command! ProjectFiles execute 'Files' systemlist('git rev-parse --show-toplevel')[0]
nnoremap <leader>o :ProjectFiles<cr>
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..', 'dir': systemlist('git rev-parse --show-toplevel')[0]}, <bang>0)
nnoremap <leader>f :Ag<cr>

" custom commands
command! PU silent! execute 'PlugUpdate | PlugUpgrade | UpdateRemotePlugins'

" move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" managing tabs
map <leader>t :tabnew<cr>
map <leader>Tab :tabnext<cr>
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>0 :tablast<cr>

" Plugin config

let g:airline_powerline_fonts = 1
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_symbols = {}
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_right_alt_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_inactive_collapse=1
let g:airline_section_x = airline#section#create(['filetype'])
let g:airline_section_z = airline#section#create([' %l/%L  ', ':%3c '])

let g:indentLine_char = '▏'
let g:jsx_ext_required = 0

" Autoclose-tag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js,*.jsx'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.js'
let g:closetag_filetypes = 'html,xhtml,phtml,jsx,js'
let g:closetag_xhtml_filetypes = 'xhtml,jsx'
let g:closetag_close_shortcut = '<leader>>'

let g:theme="dark"
let g:onedark_terminal_italics=1
set background=dark
colorscheme onedark

" let g:solarized_extra_hi_groups=1
" let g:solarized_term_italics=1
" set background=light
" colorscheme solarized8
" hi! ALEErrorSign gui=bold guifg=#dc322f guibg=#EEE8D5
" hi! ALEWarningSign gui=bold guifg=#b58900 guibg=#EEE8D5

" nvim-typescript
let g:nvim_typescript#javascript_support = 1
let g:nvim_typescript#diagnosticsEnable = 0

" match-tag-always
let g:mta_filetypes = { 'javascript.jsx' : 1 }

" ale
let g:ale_fixers = {
\ 'javascript': ['eslint'],
\ 'typescript': ['tslint'],
\ 'css': ['stylelint'],
\ 'scss': ['stylelint'] }
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_fix_on_save = 1

" Auto commands
" set filetypes
au BufRead,BufNewFile .eslintrc,.jscsrc,.jshintrc,.babelrc,.stylelintrc set ft=json
au BufRead,BufNewFile gitconfig set ft=.gitconfig
" auto open nerdtree when opening vim with no file specified
au StdinReadPre * let s:std_in=1
au VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
