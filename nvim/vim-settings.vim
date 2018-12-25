set completeopt=noinsert,menuone,noselect
set confirm
set cursorline
set expandtab
set exrc
set gdefault
set ignorecase
set matchpairs+=<:>
set mouse=a
set nobackup
set noshowcmd
set noshowmode
set nostartofline
set noswapfile
set nowritebackup
set number
set secure
set shiftround
set shiftwidth=2
set shortmess+=c
set showmatch
set smartcase
set smartindent
set softtabstop=2
set splitbelow
set splitright
set tabstop=2
set termguicolors
set wildignore+=*/.git,*/.DS_Store,*/node_modules/*,node_modules/*,*/.vscode,*/.Trash,.next/*,.cache/*,public/*,package-lock.json,vendor/*


let g:python_host_prog  = systemlist('which python')[0]
let g:python3_host_prog = systemlist('which python3')[0]

au BufRead,BufNewFile gitconfig set ft=.gitconfig
au BufRead,BufNewFile .eslintrc,.jscsrc,.jshintrc,.babelrc,.stylelintrc set ft=json

augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END
