" ale
let g:ale_linters = {
    \ 'css': ['stylelint'],
    \ 'javascript': ['eslint'],
    \ 'json': ['jsonlint'],
    \ 'jsx': ['stylelint', 'eslint' ],
    \ 'scss': ['stylelint'],
    \ 'typescript': ['tslint'],
    \ }
let g:ale_linter_aliases = {'jsx': 'css'}
let g:ale_fixers = {
    \ 'css': ['prettier', 'stylelint'],
    \ 'javascript': ['prettier', 'eslint'],
    \ 'json': ['prettier'],
    \ 'jsx': ['prettier', 'eslint'],
    \ 'scss': ['prettier', 'stylelint'],
    \ 'typescript': ['tslint'],
    \ }
let g:ale_echo_delay = 200
let g:ale_echo_msg_format='%severity%: %s (%linter%: %code%)'
let g:ale_fix_on_save = 1
let g:ale_lint_delay = 400
let g:ale_linters_explicit = 1
let g:ale_sign_error = '■'
let g:ale_sign_warning = '■'

" autoclose-tag
let g:closetag_close_shortcut = '<leader>>'
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js,*.jsx'
let g:closetag_filetypes = 'html,xhtml,phtml,jsx,js'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.js'
let g:closetag_xhtml_filetypes = 'xhtml,jsx'

" fzf
let g:fzf_action = { 'ctrl-t': 'tab split', 'ctrl-s': 'split', 'ctrl-v': 'vsplit' }
" fzf colors (why is this not set as default...)
let g:fzf_colors = {'fg':['fg','Normal'],'bg':['bg','Normal'],'hl':['fg','Comment'],'fg+':['fg','CursorLine','CursorColumn','Normal'],'bg+':['bg','CursorLine','CursorColumn'],'hl+':['fg','Statement'],'info':['fg','PreProc'],'border':['fg','Ignore'],'prompt':['fg','Conditional'],'pointer':['fg','Exception'],'marker':['fg','Keyword'],'spinner':['fg','Label'],'header':['fg','Comment']}

" language client
let g:LanguageClient_serverCommands = {
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'typescript': ['javascript-typescript-stdio'],
    \ }
let g:LanguageClient_diagnosticsEnable=0
let g:LanguageClient_changeThrottle=1

" lightline
let g:lightline = {
      \ 'colorscheme': 0,
      \ 'component_expand': {
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \ },
      \ 'component_type': {
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error'
      \ },
      \ 'component': {
      \     'lineinfo': "%{line('.') . '/' . line('$')}",
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'filename'] ],
      \   'right': [ [ 'linter_errors', 'linter_warnings' ],
      \              [ 'lineinfo' ],
      \              [ 'filetype' ] ]
      \ },
      \ 'inactive': {
      \   'left': [ [ 'filename'] ],
      \   'right': [ [ 'lineinfo' ]]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'LightlineGit',
      \   'filename': 'LightlineFilename',
      \   'filetype': 'LightlineFiletype'
      \ },
      \ }

function! LightlineFilename()
  if expand('%:t') ==? 'NERD_tree_1' || expand('%:t') ==# ''
    return ''
  endif
  let filename = winwidth(0) > 90 ? expand('%:p') : expand('%:t')
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction

function! LightlineFiletype()
  return expand('%:t') !=? 'NERD_tree_1' ? &filetype : ''
endfunction

function! LightlineGit()
  return winwidth(0) > 70 ? fugitive#head() : ''
endfunction

" ncm2
au BufEnter * call ncm2#enable_for_buffer()
let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
let g:UltiSnipsRemoveSelectModeMappings = 0

" nerdtree & git plugin
let g:NERDTreeMinimalUI=1
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeRespectWildIgnore=1
let g:NERDTreeShowHidden=1
let g:NERDTreeWinSize = 35
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "~",
    \ "Staged"    : "+",
    \ "Untracked" : "*",
    \ "Renamed"   : "→",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "-",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✓",
    \ 'Ignored'   : '÷',
    \ "Unknown"   : "?"
    \ }
" auto open nerdtree when opening vim with no file specified
au StdinReadPre * let s:std_in=1
au VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" vim-workspace
let g:workspace_autosave = 0
