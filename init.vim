" Install Vim Plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.local/share/nvim/plugged')

" Language & autocompletion
Plug 'majutsushi/tagbar'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'sheerun/vim-polyglot'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" UI
Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'Valloric/MatchTagAlways'

" Themes
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'morhetz/gruvbox'
Plug 'lifepillar/vim-solarized8'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'sodapopcan/vim-twiggy'
Plug 'tpope/vim-fugitive'

" Linting
Plug 'w0rp/ale'

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

call plug#end()

" Basic config
set confirm
set cursorline
set expandtab
set gdefault
set ignorecase
set iskeyword+=-
set laststatus=0
set lazyredraw
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
set shiftround
set shiftwidth=2
set showmatch
set smartcase
set smartindent
set softtabstop=2
set splitbelow
set tabstop=2
set termguicolors
set wildcharm=<TAB>
set wildignore+=*/.cache,*/.git,*/.svn/*,*/.DS_Store,*/node_modules,*/.vscode,*/.Trash

" Mappings

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" leader is comma
let mapleader=","

" nerdtree
map <leader>b :NERDTreeToggle<CR>
let g:NERDTreeWinSize = 40
let g:NERDTreeRespectWildIgnore=1
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeShowHidden=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeChDirMode=2
let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 0

" toggle twiggy
map <leader>g :Twiggy<cr>
let g:twiggy_group_locals_by_slash = 0
let g:twiggy_remote_branch_sort = 'date'
let g:twiggy_num_columns = 40

" toggle tagbar
nmap <leader>v :TagbarToggle<CR>
let g:tagbar_width = 40
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1

" Deoplete settings
let g:deoplete#enable_at_startup = 1
let g:neosnippet#enable_completed_snippet = 1
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" move lines around
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" escape terminal mode with ESC
tnoremap <Esc> <C-\><C-n>

" remove search highlighting with ESC
nnoremap <silent> <Esc> :nohl<CR><Esc>

" Map fzf to CTRL-p
let $FZF_DEFAULT_COMMAND='fd --type f'
map <C-p> :Files<cr>
" Map silver searcher to CTRL-o
map <C-o> :Ag<cr>

" Pass ag to fzf for search in files
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

command! Gru execute 'Git remote update origin'
command! PU silent! execute 'PlugUpdate | PlugUpgrade | q'

" move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" managing tabs
map <leader>t :tabnew<cr>
map <leader>w :tabclose<cr>
map <leader>Tab :tabnext<cr>

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" save session
nnoremap <leader>s :mksession<CR>
map <leader>w :w<CR>
map <leader>q :q<CR>

" Theme config

if strftime('%H') > 6 && strftime('%H') < 19
  set background=light
  let g:airline_solarized_bg='light'
else
  set background=dark
  let g:lightline = { 'colorscheme': 'stellarized_dark' }
endif

colorscheme solarized8
let g:solarized_term_italics=1
let g:solarized_extra_hi_groups=1

" Plugin config
let g:airline_theme='solarized'
let g:airline_section_c = '%F'
let g:airline_section_c = '%f'
let g:airline#extensions#ale#enabled = 1
let airline#extensions#tabline#tabs_label = ''
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamecollapse = 0
let g:airline#extensions#tabline#fnamemod = ':.'
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline_powerline_fonts = 1

let g:ale_sign_error = '█'
let g:ale_sign_warning = '█'
let g:ale_fix_on_save = 1

let g:indentLine_char = '▏'
let g:jsx_ext_required = 0
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" Customize fzf colors to match your color scheme
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

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Autoclose tag settings
" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js,*.jsx'
" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.js'
" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
let g:closetag_filetypes = 'html,xhtml,phtml,jsx,js'
" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
let g:closetag_xhtml_filetypes = 'xhtml,jsx'
" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
let g:closetag_emptyTags_caseSensitive = 1
" Shortcut for closing tags, default is '>'
let g:closetag_shortcut = '>'
" Add > at current position without closing the current tag, default is ''
let g:closetag_close_shortcut = '<leader>>'

" match tag always settings
let g:mta_filetypes = {
\ 'javascript.jsx' : 1,
\ }

" Ale settings
let g:ale_fixers = {
\ 'javascript': ['eslint'],
\ 'typescript': ['tslint'],
\ }
let b:ale_set_balloons = 1

 " Auto commands
if has("autocmd")
  autocmd StdinReadPre * let s:std_in=1
  autocmd! bufwritepost init.vim source %

  autocmd BufReadPost * " {{{2
    " Return to last edit position when opening files (You want this!)
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

  autocmd BufRead,BufNewFile COMMIT_EDITMSG call pencil#init({'wrap': 'soft'})
                                        \ | set textwidth=0

  autocmd BufRead,BufNewFile *.md set filetype=markdown

  autocmd BufRead,BufNewFile .eslintrc,.jscsrc,.jshintrc,.babelrc set ft=json

  au BufRead,BufNewFile *.scss set filetype=scss.css

  autocmd BufRead,BufNewFile gitconfig set ft=.gitconfig

  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

endif
