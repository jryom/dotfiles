function! ExtendHighlight(base, group, add) abort
  redir => basehi
  silent! execute 'highlight' a:base
  redir END
  let grphi = split(basehi, '\n')[0]
  let grphi = substitute(grphi, '^'.a:base.'\s\+xxx', '', '')
  silent execute 'highlight' a:group grphi a:add
endfunction

function! ReturnHighlightTerm(group, term)
   return matchstr(execute('hi ' . a:group), a:term.'=\zs\S*')
endfunction

function! FilePath() abort
  if &filetype == "help"
    return '%t'
  endif
  let len = len(expand('%'))
  return winwidth('%') > len + 50 ? '%f' : '%t'
endfunction

function! Flags() abort
  if &filetype != "help"
    return ' %m%r  '
  endif
endfunction

function! CocStatus() abort
  if &filetype == "help"
    return ''
  endif
  return winwidth('%') > len(FilePath()) + 120 ? trim(get(g:, 'coc_status', '')) : ''
endfunction

function! FileType() abort
  let resetHL = '%#StatusLine#'
  let HL = '%#StatusLineLow#'
  return ((len(CocStatus()) > 0 && b:active == 1) ? ' 🭳 ' : '') . &filetype . ' 🭳 ' . resetHL
endfunction

function! Errors() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if get(info, 'error', 0) > 0
    return '  '.get(info, 'error', 0).' '
  endif
  return ''
endfunction

function! Warnings() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if get(info, 'warning', 0) > 0
    return '  ' . info['warning'] . ' '
  endif
  return ''
endfunction

function! Hints() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if get(info, 'hint', 0) > 0
    return '  ' . info['hint'] . ' '
  endif
  return ''
endfunction

function! Info() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if get(info, 'information', 0) > 0
    return '  ' . info['information'] . ' '
  endif
  return ''
endfunction

function! RenderStatusLine() abort
  setlocal statusline=\ %{%FilePath()%}
  setlocal statusline+=%{%Flags()%}
  setlocal statusline+=%=

  if b:active == 1
    setlocal statusline+=%#StatusLineLow#%0.40{CocStatus()}
    setlocal statusline+=%{%FileType()%}
  endif

  setlocal statusline+=%l/%L:%-2.c%{'\ '}

  if b:active == 1
    setlocal statusline+=%#DiagnosticVirtualTextError#%{Errors()}
    setlocal statusline+=%#DiagnosticVirtualTextWarn#%{Warnings()}
    setlocal statusline+=%#DiagnosticVirtualTextInfo#%{Info()}
    setlocal statusline+=%#DiagnosticVirtualTextHint#%{Hints()}
  endif
endfunction

augroup StatusLine
  autocmd!
  autocmd WinEnter,BufEnter * let b:active=1 | call RenderStatusLine()
  autocmd WinLeave,BufLeave * let b:active=0 | call RenderStatusLine()
augroup END

autocmd ColorScheme * call ExtendHighlight('StatusLine', 'StatusLineItalic', 'gui=italic')
autocmd ColorScheme * call ExtendHighlight('StatusLine', 'StatusLineLow', 'guifg='.ReturnHighlightTerm('StatusLineNC', 'guifg'))
