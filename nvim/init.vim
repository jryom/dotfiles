if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')
  " language support, linting
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'sheerun/vim-polyglot'
  Plug 'w0rp/ale'
  " editing
  Plug 'alvan/vim-closetag'
  Plug 'honza/vim-snippets'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  " ui
  Plug 'airblade/vim-gitgutter'
  Plug 'jesperryom/base16-vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  " misc
  Plug 'airblade/vim-rooter'
  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'thaerkh/vim-workspace'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
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

" autocommands
au BufRead,BufNewFile .eslintrc,.babelrc,.stylelintrc set ft=json
au VimEnter,SessionLoadPost,VimResized * wincmd =
au BufEnter * :syntax sync fromstart

" misc
let mapleader=' '
map <leader>b :Explore<CR>
map <leader>s :sort<CR>
nnoremap <silent> <Esc> :nohl<CR><Esc>
if filereadable(expand("~/.vimrc_background")) | source ~/.vimrc_background | endif
let g:closetag_filenames = '*.html,*.js'
let g:javascript_plugin_jsdoc = 1

" tabs
nnoremap <tab>   :tabnext<CR>
nnoremap <S-tab> :tabprevious<CR>
nnoremap † :tabnew<CR>  | " ALT-t
nnoremap ∑ :tabclose<CR>| " ALT-w

" airline
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_skip_empty_sections = 1
let g:airline_powerline_fonts = 1
let g:airline_section_z = '%3l/%L:%3v'
let g:airline_symbols = {'dirty':''}

" ale
let g:ale_linter_aliases = {'javascript': [ 'javascript', 'css' ]}
let g:ale_fixers = {
    \ '*': ['remove_trailing_lines', 'trim_whitespace'],
    \ 'css': ['stylelint'],
    \ 'javascript': ['eslint'],
    \ 'scss': ['stylelint'],
    \ }
let g:ale_sign_error =    '█'
let g:ale_sign_warning =  '█'
let g:ale_fix_on_save = 1
let g:ale_virtualtext_cursor = 1
let g:ale_echo_msg_format='%severity%: %s [%linter% - %code%]'
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" coc
let g:coc_global_extensions = [
      \ 'coc-json',
      \ 'coc-pairs',
      \ 'coc-prettier',
      \ 'coc-snippets',
      \ 'coc-tsserver',
      \ 'coc-yaml',
      \ ]
nmap <silent> gd <Plug>(coc-definition)
nmap co :CocList outline<cr>
vmap <leader>p <Plug>(coc-format-selected)
nmap <leader>p <Plug>(coc-format)
imap <C-l> <Plug>(coc-snippets-expand-jump)

" fzf
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_layout = { 'window': 'enew' }
command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --color=always '.shellescape(<q-args>),
  \ 1, {'options':'--delimiter : --nth 2..'}, <bang>0)
nnoremap <leader>i :Rg<cr>
nnoremap <leader>o :Files<cr>

" gitgutter
let g:gitgutter_sign_added = '▍'
let g:gitgutter_sign_modified = '▍'
let g:gitgutter_sign_removed = '▍'

" vim-workspace
let g:workspace_autosave = 0
let g:workspace_autocreate = 1
let g:workspace_session_disable_on_args = 1
let g:workspace_session_directory = $HOME . '/.config/nvim/sessions/'
