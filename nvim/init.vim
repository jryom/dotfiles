if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'alvan/vim-closetag'
Plug 'cohama/lexima.vim'
Plug 'cormacrelf/dark-notify'
Plug 'honza/vim-snippets'
Plug 'jeetsukumaran/vim-filebeagle'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rhysd/git-messenger.vim'
Plug 'sainnhe/edge'
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
set shortmess+=actFTWI
set signcolumn=yes
set splitbelow splitright
set termguicolors
set undofile
set updatetime=100

" theme
lua require('dark_notify').run()
let g:edge_style = 'neon'
colorscheme edge

augroup autocommands
  autocmd!
  autocmd BufRead,BufNewFile .{eslint,babel,stylelint,prettier}rc set ft=json
  autocmd BufEnter * :syntax sync fromstart
  autocmd SessionLoadPost,VimResized * wincmd =
  autocmd WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
  autocmd BufWritePre * %s/\s\+$//e
augroup END

" misc
let mapleader = ' '
nnoremap <silent> <Esc> :nohl<CR><Esc>
map <leader>w :w<CR>
map <leader>q :bd<CR>
xmap ga <Plug>(EasyAlign)
let g:closetag_filetypes = 'html,xhtml,jsx,javascript'
let g:javascript_plugin_flow = 1
let g:javascript_plugin_jsdoc = 1
let g:filebeagle_suppress_keymaps = 1
let g:filebeagle_show_hidden = 1
map <silent> - <Plug>FileBeagleOpenCurrentBufferDir
map <leader>g :GitMessenger<cr>
nnoremap <leader>l :FuzzySearch<cr>
nmap <Up> <C-y>
nmap <Down> <C-e>
nmap <Left> [
omap <Left> [
xmap <Left> [
nmap <Right> ]
omap <Right> ]
xmap <Right> ]

" airline
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
      \ 'coc-stylelintplus',
      \ 'coc-styled-components',
      \ 'coc-tsserver',
      \ 'coc-vimlsp',
      \ 'coc-yaml',
      \ ]
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
imap <silent> <C-l> <Plug>(coc-snippets-expand-jump)
nmap <silent> gp <Plug>(coc-diagnostic-prev)
nmap <silent> gn <Plug>(coc-diagnostic-next)
nmap <silent> gh :call CocAction('doHover')<cr>
nmap <silent> <leader>f <Plug>(coc-format)
nmap <silent> <leader>a <Plug>(coc-codeaction)
nmap <silent> <leader>c :CocCommand<CR>
vmap <silent> <leader>a <Plug>(coc-codeaction-selected)
nmap <silent> <leader>r <Plug>(coc-rename)
nmap <silent> <leader>R <Plug>(coc-refactor)

" fzf
let g:fzf_history_dir = '~/.local/share/fzf-history'
" let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }
command! -bang -nargs=* Rg call fzf#vim#grep('rg '.shellescape(<q-args>), 1,
      \ fzf#vim#with_preview({'options':'--delimiter : --nth 3..'}), <bang>0)
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>i :Rg<cr>
nnoremap <leader>o :Files<cr>

" vim workspace
let g:workspace_session_disable_on_args = 1
let g:workspace_autosave = 0
let g:workspace_persist_undo_history = 0
let g:workspace_session_directory = $HOME.'/.local/share/nvim/sessions/'
nnoremap <leader>s :ToggleWorkspace<CR>
map <leader>dh :CloseHiddenBuffers<CR>
