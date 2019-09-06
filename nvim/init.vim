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
  call minpac#add('tpope/vim-commentary')
  call minpac#add('tpope/vim-surround')
  " ui
  call minpac#add('machakann/vim-highlightedyank')
  call minpac#add('vim-airline/vim-airline')
  call minpac#add('vim-airline/vim-airline-themes')
  call minpac#add('lifepillar/vim-solarized8')
  " misc
  call minpac#add('airblade/vim-rooter')
  call minpac#add('jeetsukumaran/vim-filebeagle')
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('thaerkh/vim-workspace')
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('tpope/vim-rhubarb')
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
set shortmess+=actFTWI
set smartindent
set softtabstop=2
set splitbelow splitright
set title titlestring=%t%m\ -\ nvim
set tabstop=2
set termguicolors
set undofile

augroup autocommands
  autocmd BufRead,BufNewFile .{eslint,babel,stylelint,prettier}rc set ft=json
  autocmd VimEnter,SessionLoadPost,VimResized * wincmd =
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
  autocmd TermOpen term://*FZF tnoremap <silent> <buffer><nowait> <esc> <c-c>
  autocmd BufWritePre * %s/\s\+$//e
  autocmd FileType elm setlocal shiftwidth=4 softtabstop=4
augroup END

" update plugins weekly on launch
if ! filereadable(expand("~/.local/share/nvim/lastupdate"))
  \ || readfile(glob("~/.local/share/nvim/lastupdate"))[0] < (localtime() - 604800)
  execute 'PackUpdate'
  silent execute '!echo ' . (localtime()) . ' > ~/.local/share/nvim/lastupdate'
endif

" theme
if len(systemlist('defaults read -g AppleInterfaceStyle 2>/dev/null')) | set bg=dark | else | set bg=light | endif
colorscheme solarized8_flat
let g:solarized_diffmode="low"
let g:solarized_extra_hi_groups=1

" misc
let mapleader=' '
map <leader>s :sort<CR>
nnoremap <silent> <Esc> :nohl<CR><Esc>
nnoremap † :tabnew<CR>  | " ALT-t
nnoremap ∑ :tabclose<CR>| " ALT-w
nnoremap <leader>u :UndotreeToggle<cr>
let g:filebeagle_show_hidden=1
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
let g:highlightedyank_highlight_duration = 80
hi link HighlightedyankRegion Search

" airline
let g:airline#extensions#coc#enabled = 1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_section_z = '%3l/%L:%3v'
let g:airline_symbols = {'dirty':'✱', 'branch': ''}
let g:airline_theme='solarized'

" coc
let g:coc_global_extensions = [
  \ 'coc-eslint',
  \ 'coc-git',
  \ 'coc-html',
  \ 'coc-json',
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
autocmd VimEnter * hi CocErrorHighlight gui=bold guifg=#dc322f guisp=#dc322f gui=undercurl
autocmd VimEnter * hi CocWarningHighlight gui=bold guifg=#b58900 guisp=#b58900 gui=undercurl
autocmd VimEnter * hi CocErrorSign guifg=#dc322f
autocmd VimEnter * hi CocWarningSign guifg=#b58900

" fzf
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_layout = { 'window': 'enew' }
command! -bang -nargs=* Rg call fzf#vim#grep('rg '.shellescape(<q-args>),
  \ 1, {'options':'--delimiter : --nth 2..'}, <bang>0)
nnoremap <leader>i :Rg<cr>
nnoremap <leader>o :Files<cr>
let g:fzf_colors =  {'fg':['fg','Normal'],'bg':['bg','Normal'],
  \ 'hl':['fg','IncSearch'],'fg+':['fg','CursorLineNr'],
  \ 'bg+':['bg', 'CursorLine'],
  \ 'hl+':['fg','IncSearch'],'info':['fg','PreProc'],
  \ 'border':['fg','Ignore'],'prompt':['fg','Conditional'],
  \ 'pointer':['fg','Exception'],'marker':['fg','Title'],
  \ 'spinner': ['fg', 'Label'],'header':['fg', 'Comment'] }

" vim-workspace
let g:workspace_autosave = 0
let g:workspace_persist_undo_history = 0
let g:workspace_session_directory = $HOME . '/.local/share/nvim/sessions/'
let g:workspace_session_disable_on_args = 1
