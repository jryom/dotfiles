if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')
" Language, autocompletion & linting
Plug 'honza/vim-snippets'
Plug 'ludovicchabant/vim-gutentags'
Plug 'sbdchd/neoformat'
Plug 'sheerun/vim-polyglot'
Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'sirver/ultisnips'
Plug 'w0rp/ale'

" UI
Plug 'airblade/vim-gitgutter'
Plug 'jesperryom/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Editing and additional stuff
Plug 'airblade/vim-rooter'
Plug 'alvan/vim-closetag'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'raimondi/delimitmate'
Plug 'thaerkh/vim-workspace'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
call plug#end()

set completeopt=noinsert,menuone,noselect
set confirm
set cursorline
set expandtab
set inccommand=split
set ignorecase smartcase
set matchpairs+=<:>
set mouse=a
set noshowmode
set nostartofline
set noswapfile
set number
set shiftround
set shiftwidth=2
set shortmess+=c
set smartindent
set softtabstop=2
set splitbelow splitright
set tabstop=2
set termguicolors
set wildignore+=*/.git/*,*/coverage/*,*/node_modules/*,*/.Trash/*,*/.next/*,*/.cache/*,*/public/*,*/vendor/*,*/.undodir/*,package-lock.json,yarn.lock,.DS_Store

if ! filereadable(expand("~/.vim_updatecheck")) || readfile(glob("~/.vim_updatecheck"))[0] < (strftime('%y%m%d'))
  :PlugUpdate
  silent! execute '!echo ' . (strftime('%y%m%d')) . ' > ~/.vim_updatecheck'
endif

augroup json
  au!
  au BufRead,BufNewFile .eslintrc,.jscsrc,.jshintrc,.babelrc,.stylelintrc set ft=json
augroup END

augroup windowresize
  au!
  au VimEnter,SessionLoadPost,VimResized * wincmd =
augroup END

augroup syntaxfix
  au!
  au BufEnter * :syntax sync fromstart
augroup END

" general mappings
let mapleader=' '
map <leader>b :Explore<CR>
map <leader>s :sort<CR>
nnoremap j gj
nnoremap k gk
nnoremap <silent> <Esc> :nohl<CR><Esc>

let g:gutentags_cache_dir='~/.tags/'
let g:closetag_filenames = '*.html,*.js,*.jsx'

" airline
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_skip_empty_sections = 1
let g:airline_powerline_fonts = 1
let g:airline_section_z = '%3l/%L:%3v'

" ale
let g:ale_linter_aliases = {'javascript': [ 'javascript', 'css' ]}
let g:ale_fixers = {
    \ '*': ['remove_trailing_lines', 'trim_whitespace'],
    \ 'css': ['stylelint'],
    \ 'javascript': ['stylelint', 'eslint'],
    \ 'scss': ['stylelint'],
    \ 'typescript': ['tslint'] }
let g:ale_javascript_eslint_use_global = 1
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_sign_error =    '█'
let g:ale_sign_warning =  '█'
let g:ale_fix_on_save = 1
let g:ale_echo_msg_format='%severity%: %s (%linter%: %code%)'
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" base16
if filereadable(expand("~/.vimrc_background")) | source ~/.vimrc_background | endif

" deoplete / ultisnips
let g:deoplete#enable_at_startup = 1
let g:UltiSnipsExpandTrigger='<C-k>'
let g:UltiSnipsJumpForwardTrigger='<C-l>'
let g:UltiSnipsJumpBackwardTrigger='<C-h>'

" fzf
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_layout = { 'window': 'enew' }
nnoremap <leader>/ :BLines<cr>
nnoremap <leader>i :Rg<cr>
nnoremap <leader>o :Files<cr>
nnoremap <leader>t :Tags<cr>

" gitgutter
let g:gitgutter_sign_added = '▍'
let g:gitgutter_sign_modified = '▍'
let g:gitgutter_sign_removed = '▍'

" neoformat
nnoremap <leader>p :Neoformat prettier <bar> :Neoformat eslint_d<cr><cr>
xnoremap <leader>p :Neoformat prettier <bar> :Neoformat eslint_d<cr><cr>

" vim-workspace
let g:workspace_autosave = 0
let g:workspace_autocreate = 1
let g:workspace_session_disable_on_args = 1
let g:workspace_session_directory = $HOME . '/.config/nvim/sessions/'
