" CSS3 syntax
augroup VimCSS3Syntax
  autocmd!
  autocmd FileType css setlocal iskeyword+=-
augroup END

" nerdtree
let g:NERDTreeWinSize = 45
let g:NERDTreeRespectWildIgnore=1
let g:NERDTreeShowHidden=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeQuitOnOpen = 1
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''

" language client
let g:LanguageClient_serverCommands = {
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'typescript': ['javascript-typescript-stdio'],
    \ }
let g:LanguageClient_diagnosticsEnable=0
let g:LanguageClient_changeThrottle=0.5

" ncm2
let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
let g:UltiSnipsRemoveSelectModeMappings = 0
au BufEnter * call ncm2#enable_for_buffer()

" fzf / ag
let $FZF_DEFAULT_COMMAND='fd --type f'
let g:fzf_action = { 'ctrl-t': 'tab split', 'ctrl-s': 'split', 'ctrl-v': 'vsplit' }
" fzf colors (why is this not set by default...)
let g:fzf_colors = {'fg':['fg','Normal'],'bg':['bg','Normal'],'hl':['fg','Comment'],'fg+':['fg','CursorLine','CursorColumn','Normal'],'bg+':['bg','CursorLine','CursorColumn'],'hl+':['fg','Statement'],'info':['fg','PreProc'],'border':['fg','Ignore'],'prompt':['fg','Conditional'],'pointer':['fg','Exception'],'marker':['fg','Keyword'],'spinner':['fg','Label'],'header':['fg','Comment']}

" airline
let g:airline_powerline_fonts = 1
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_symbols = {}
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_right_alt_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_inactive_collapse=1
let g:airline_section_x = airline#section#create(['filetype'])
let g:airline_section_z = airline#section#create([' %l/%L  ', ':%3c '])

" autoclose-tag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js,*.jsx'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.js'
let g:closetag_filetypes = 'html,xhtml,phtml,jsx,js'
let g:closetag_xhtml_filetypes = 'xhtml,jsx'
let g:closetag_close_shortcut = '<leader>>'

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
let g:ale_sign_error = '■'
let g:ale_sign_warning = '■'
let g:ale_echo_msg_format='%severity%: %s (%linter%: %code%)'
let g:ale_linters_explicit = 1
