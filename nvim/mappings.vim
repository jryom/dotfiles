" leader
let mapleader=","

" virtual old school
nnoremap ; :
vnoremap ; :

" move vertically by visual line
nnoremap j gj
nnoremap k gk

map <leader>b :NERDTreeToggle<CR>

" language client
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> rs :call LanguageClient#textDocument_rename()<CR><Paste>

" ncm2
imap <expr> <c-u> ncm2_ultisnips#expand_or("\<Plug>(ultisnips_expand)", 'm')
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
smap <c-u> <Plug>(ultisnips_expand)

" move lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" remove search highlighting with ESC
nnoremap <silent> <Esc> :nohl<CR><Esc>

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

" fzf
command! ProjectFiles execute 'Files' systemlist('git rev-parse --show-toplevel')[0]
nnoremap <leader>o :ProjectFiles<cr>
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..', 'dir': systemlist('git rev-parse --show-toplevel')[0]}, <bang>0)
nnoremap <leader>f :Ag<cr>

" ale
nnoremap <silent> <leader>a :ALEFix<CR>
