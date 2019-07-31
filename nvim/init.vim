command! PackClean call PackInit() | call minpac#clean()
command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})

function! PackInit() abort
  packadd minpac
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})
  " language support, linting
  call minpac#add('neoclide/coc.nvim', {'branch': 'release', 'do': 'call coc#util#install()'})
  call minpac#add('sheerun/vim-polyglot')
  call minpac#add('w0rp/ale')
  " editing
  call minpac#add('honza/vim-snippets')
  call minpac#add('raimondi/delimitmate')
  call minpac#add('sbdchd/neoformat')
  call minpac#add('tpope/vim-commentary')
  call minpac#add('tpope/vim-surround')
  " ui
  call minpac#add('airblade/vim-gitgutter')
  call minpac#add('jesperryom/base16-vim')
  call minpac#add('vim-airline/vim-airline')
  call minpac#add('vim-airline/vim-airline-themes')
  " misc
  call minpac#add('airblade/vim-rooter')
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('mbbill/undotree')
  call minpac#add('thaerkh/vim-workspace')
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('tpope/vim-rhubarb')
  call minpac#add('tpope/vim-vinegar')
endfunction

set confirm
set cursorline
set expandtab
set ignorecase smartcase
set inccommand=split
set matchpairs+=<:>
set mouse=a
set noshowmode
set nostartofline
set number
set rtp+=/usr/local/opt/fzf
set shiftround
set shiftwidth=2
set shortmess+=c
set smartindent
set softtabstop=2
set splitbelow splitright
set tabstop=2
set termguicolors
set undofile

if ! filereadable(expand("~/.local/share/nvim/lastupdate"))
  \ || readfile(glob("~/.local/share/nvim/lastupdate"))[0] < (localtime() - 604800)
  execute 'PackUpdate'
  silent! execute 'UpdateRemotePlugins'
  silent! execute '!echo ' . (localtime()) . ' > ~/.local/share/nvim/lastupdate'
endif

" autocommands
au BufRead,BufNewFile .eslintrc,.babelrc,.stylelintrc set ft=json
au VimEnter,SessionLoadPost,VimResized * wincmd =
au BufEnter * :syntax sync fromstart

" misc
if filereadable(expand("~/.vimrc_background")) | source ~/.vimrc_background | endif
let g:javascript_plugin_jsdoc = 1
let g:delimitMate_nesting_quotes = ['"', "'", '`']
let mapleader=' '
map <leader>b :Explore<CR>
map <leader>s :sort<CR>
nnoremap <silent> <Esc> :nohl<CR><Esc>
nnoremap † :tabnew<CR>  | " ALT-t
nnoremap ∑ :tabclose<CR>| " ALT-w
nnoremap <leader>u :UndotreeToggle<cr>
nnoremap <leader>p :Neoformat prettier <bar> :Neoformat eslint_d<cr><cr>
xnoremap <leader>p :Neoformat prettier <bar> :Neoformat eslint_d<cr><cr>

" airline
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_skip_empty_sections = 1
let g:airline_powerline_fonts = 1
let g:airline_section_z = '%3l/%L:%3v'
let g:airline_symbols = {'dirty':''}

" ale
let g:ale_linter_aliases = {'javascript': [ 'javascript', 'css' ]}
let g:ale_fixers = {
    \ '*': ['remove_trailing_lines', 'trim_whitespace', 'prettier', 'stylelint'],
    \ 'javascript': ['eslint'],
    \ }
let g:ale_fix_on_save = 1
let g:ale_sign_error = '█'
let g:ale_sign_warning = '█'
let g:ale_virtualtext_cursor = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" coc
let g:coc_global_extensions = [ 'coc-json', 'coc-snippets', 'coc-tsserver' ]
nmap <silent> gd <Plug>(coc-definition)
imap <C-l> <Plug>(coc-snippets-expand-jump)

" fzf
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_layout = { 'window': 'enew' }
command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --color=always '.shellescape(<q-args>),
  \ 1, {'options':'--delimiter : --nth 2..'}, <bang>0)
nnoremap <leader>i :Rg<cr>
nnoremap <leader>o :Files<cr>

" vim-workspace
let g:workspace_autocreate = 1
let g:workspace_autosave = 0
let g:workspace_persist_undo_history = 0
let g:workspace_session_directory = $HOME . '/.local/share/nvim/sessions/'
let g:workspace_session_disable_on_args = 1
