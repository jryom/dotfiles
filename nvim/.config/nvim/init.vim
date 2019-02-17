command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  call PackInit() | call minpac#clean()

function! PackInit() abort
  packadd minpac
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " Language, autocompletion & linting
  call minpac#add('Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' })
  call minpac#add('SirVer/ultisnips')
  call minpac#add('hail2u/vim-css3-syntax')
  call minpac#add('honza/vim-snippets')
  call minpac#add('ludovicchabant/vim-gutentags')
  call minpac#add('sheerun/vim-polyglot')
  call minpac#add('styled-components/vim-styled-components', { 'branch': 'main' })
  call minpac#add('w0rp/ale')

  " UI
  call minpac#add('airblade/vim-gitgutter')
  call minpac#add('jesperryom/base16-vim')
  call minpac#add('itchyny/lightline.vim')
  call minpac#add('maximbaz/lightline-ale')
  call minpac#add('mike-hearn/base16-vim-lightline')

  " Editing and additional stuff
  call minpac#add('alvan/vim-closetag')
  call minpac#add('editorconfig/editorconfig-vim')
  call minpac#add('jiangmiao/auto-pairs')
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('thaerkh/vim-workspace')
  call minpac#add('tpope/vim-commentary')
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('tpope/vim-surround')
  call minpac#add('tpope/vim-vinegar')
endfunction

set completeopt=noinsert,menuone,noselect
set confirm
set expandtab
set gdefault
set inccommand=split
set ignorecase smartcase
set linebreak
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
set wildignore+=*/.git/*,*/coverage/*,*/node_modules/*,*/.Trash/*,*/.next/*,*/.cache/*,*/public/*,*/vendor/*,*/.undodir/*,Session.vim,package-lock.json,.DS_Store

au BufRead,BufNewFile .eslintrc,.jscsrc,.jshintrc,.babelrc,.stylelintrc set ft=json

" cursorline in active window
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" MAPPINGS

let mapleader=","
nnoremap <silent> <Esc> :nohl<CR><Esc>
map <leader>b :Explore<CR>

" move vertically by visual line
nnoremap j gj
nnoremap k gk

nnoremap <leader>p mF:%!prettier_d --single-quote --trailing-comma es5 --stdin --fix-to-stdout<CR>`F
vnoremap <leader>p :!prettier_d --single-quote --trailing-comma es5 --stdin --fix-to-stdout<CR>gv
let g:gutentags_cache_dir='~/.tags/'
let g:closetag_filenames = '*.html,*.js,*.jsx'

" ale
let g:ale_linter_aliases = {'jsx': 'css'}
let g:ale_fixers = {
    \ 'css': ['stylelint'],
    \ 'javascript': ['eslint'],
    \ 'jsx': ['eslint'],
    \ 'scss': ['stylelint'],
    \ 'typescript': ['tslint'] }
let g:ale_javascript_eslint_use_global = 1
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_sign_error = '▊'
let g:ale_sign_warning = '▊'
let g:ale_fix_on_save = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" deoplete / ultisnips
let g:deoplete#enable_at_startup = 1
let g:UltiSnipsExpandTrigger="<C-k>"
let g:UltiSnipsJumpForwardTrigger="<C-l>"
let g:UltiSnipsJumpBackwardTrigger="<C-h>"

" fzf
set rtp+=/usr/local/opt/fzf
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_layout = { 'window': 'enew' }
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..', 'dir': systemlist('git rev-parse --show-toplevel')[0]}, <bang>0)
command! ProjectFiles execute 'Files' systemlist('git rev-parse --show-toplevel')[0]
nnoremap <leader>o :ProjectFiles<cr>
nnoremap <leader>f :Ag<cr>

" lightline
let g:lightline = {
      \ 'component_expand': {
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors' },
      \ 'component_type': {
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error' },
      \ 'component': {
      \     'lineinfo': "%{line('.') . '/' . line('$')}" },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'filename'] ],
      \   'right': [ [ 'linter_errors', 'linter_warnings' ],
      \              [ 'lineinfo' ],
      \              [ 'filetype' ] ] },
      \ 'inactive': {
      \   'left': [ [ 'filename'] ],
      \   'right': [ [ 'lineinfo' ]] },
      \ 'component_function': {
      \   'gitbranch': 'LightlineGit',
      \   'filename': 'LightlineFilename' } }

function! LightlineFilename()
  let filename = winwidth(0) > 90 ? expand('%') : expand('%:t')
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction

function! LightlineGit()
  return winwidth(0) > 70 ? fugitive#head() : ''
endfunction

" vim-workspace
let g:workspace_autosave = 0
nnoremap <leader>w :ToggleWorkspace<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" THEME

if systemlist("defaults read -g AppleInterfaceStyle")[0]=='Dark'
  set background=dark
  colorscheme base16-ocean
else
  set background=light
  colorscheme base16-solarized-light
endif

let g:lightline.colorscheme=substitute(g:colors_name,'-','_','g')
silent execute "!kitty @ --to unix:/tmp/mykitty set-colors -a -c ~/.config/kitty-base16-themes/".g:colors_name.".conf"
