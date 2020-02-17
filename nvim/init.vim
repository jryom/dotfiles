command! PackClean call PackInit() | call minpac#clean()
command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})

function! PackInit() abort
  packadd minpac
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})
  call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
  call minpac#add('sheerun/vim-polyglot')
  " editing
  call minpac#add('honza/vim-snippets')
  call minpac#add('junegunn/vim-easy-align')
  call minpac#add('tomtom/tcomment_vim')
  call minpac#add('tpope/vim-sleuth')
  call minpac#add('tpope/vim-surround')
  " ui
  call minpac#add('gcmt/taboo.vim')
  call minpac#add('jesperryom/base16-vim')
  call minpac#add('vim-airline/vim-airline')
  " misc
  call minpac#add('airblade/vim-rooter')
  call minpac#add('jeetsukumaran/vim-filebeagle')
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('thaerkh/vim-workspace')
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('tpope/vim-rhubarb')
  call minpac#add('tpope/vim-unimpaired')
endfunction

set confirm
set cursorline
set foldmethod=indent foldlevel=20 foldnestmax=1
set hidden
set ignorecase smartcase
set inccommand=split
set matchpairs+=<:>
set mouse=a
set noshowmode
set noshowcmd
set nostartofline
set rtp+=/usr/local/opt/fzf
set signcolumn=yes
set shiftround
set shortmess+=actFTWI
set splitbelow splitright
set title titlestring=%t%m\ -\ nvim
set termguicolors
set undofile
set updatetime=500

augroup autocommands
  autocmd BufEnter * :syntax sync fromstart
  autocmd BufRead,BufNewFile .{eslint,babel,stylelint,prettier}rc set ft=json
  autocmd VimEnter,SessionLoadPost,VimResized * wincmd =
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
  autocmd TermOpen term://*FZF tnoremap <silent> <buffer><nowait> <esc> <c-c>
  autocmd BufWritePre * %s/\s\+$//e
  autocmd CursorHold * :echo get(b:, 'coc_git_blame', '')
augroup END

" update plugins weekly on launch
if ! filereadable(expand("~/.local/share/nvim/lastupdate"))
  \ || readfile(glob("~/.local/share/nvim/lastupdate"))[0] < (localtime() - 604800)
  execute 'PackUpdate'
  silent execute '!echo ' . (localtime()) . ' > ~/.local/share/nvim/lastupdate'
endif

" theme
if len(systemlist('defaults read -g AppleInterfaceStyle 2>/dev/null')) | set bg=dark | else | set bg=light | endif
if filereadable(expand("~/.vimrc_background")) | source ~/.vimrc_background | endif

" misc
map j gj
map k gk
let mapleader=' '
map <leader>s :sort<CR>
map <leader>w :bwipeout<CR>
map <leader>q :call DeleteHiddenBuffers()<CR>
nnoremap <silent> <Esc> :nohl<CR><Esc>
nnoremap † :tabnew<CR>  | " ALT-t
nnoremap ∑ :tabclose<CR>| " ALT-w
nnoremap <leader>w :bdelete<CR>
nnoremap <expr> <leader>af &foldlevel ? 'zM' : 'zR'
map <leader>f za
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
let g:taboo_tab_format = "  %N. %f%m  "
let g:filebeagle_show_hidden=1
let g:filebeagle_suppress_keymaps=1
map <silent> - <Plug>FileBeagleOpenCurrentBufferDir

" airline
let g:airline#extensions#coc#enabled = 1
let g:airline_theme = "base16_vim"
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_section_z = '%3l/%L:%3v'
let g:airline_symbols = {'dirty':'✱ ', 'branch': ''}

" coc
let g:coc_global_extensions = [
  \ 'coc-eslint',
  \ 'coc-git',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-pairs',
  \ 'coc-prettier',
  \ 'coc-sh',
  \ 'coc-snippets',
  \ 'coc-stylelint',
  \ 'coc-tsserver',
  \ ]
nmap <silent> gd <Plug>(coc-definition)
imap <silent> <C-l> <Plug>(coc-snippets-expand-jump)
nmap <silent> <C-p> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-n> <Plug>(coc-diagnostic-next)
nmap <silent> <leader>p <Plug>(coc-format)
vmap <silent> <leader>p <Plug>(coc-format-selected)
nmap <silent> <leader>a <Plug>(coc-codeaction)
vmap <silent> <leader>a <Plug>(coc-codeaction-selected)
nmap <silent> <leader>c :CocCommand<cr>

" fzf
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_layout = { 'window': 'enew' }
command! -bang -nargs=* Rg call fzf#vim#grep('rg '.shellescape(<q-args>),
  \ 0, {'options':'--delimiter : --nth 3..'}, <bang>0)
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>i :Rg<cr>
nnoremap <leader>o :Files<cr>

" vim-workspace
let g:workspace_autosave = 0
let g:workspace_persist_undo_history = 0
let g:workspace_session_directory = $HOME . '/.local/share/nvim/sessions/'
let g:workspace_session_disable_on_args = 1

" delete hidden buffers
function DeleteHiddenBuffers()
  let tpbl=[]
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
    silent execute 'bwipeout' buf
  endfor
endfunction
