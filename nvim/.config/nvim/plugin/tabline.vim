set tabline=%!TabLine()

function TabLine()
  let s = ''

  for t in range(tabpagenr('$'))
    if t + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    let s .= '   '
    let s .= '%' . (t + 1) . 'T'
    let s .= t + 1 . '. '

    let tabname = ''
    let bufcount = tabpagebuflist(t + 1)
    call filter(bufcount, {idx, buffer -> getbufvar( buffer, "&buftype" ) != 'nofile'})
    let bufcount = len(bufcount)

    let idx = 1

    for buffer in tabpagebuflist(t + 1)
      let modified = 0
      let buffername = ''

      if getbufvar( buffer, "&buftype" ) == 'help'
        let buffername .= '[H] ' . fnamemodify( bufname(buffer), ':t:s/.txt$//' )
      elseif getbufvar( buffer, "&buftype" ) == 'quickfix'
        let buffername .= '[Q]'
      else
        let buffername .= fnamemodify( bufname(buffer), ':t' )
      endif

      if getbufvar( buffer, "&modified" )
        let modified = 1
      endif

      if modified
        let buffername .= ' +'
      endif

      if idx < bufcount
        let buffername .=   ' | '
      endif

      let tabname .= buffername

      let idx += 1
    endfor

    if tabname == ''
      let s .= '[No Name]'
    else
      let s .= tabname
    endif

    let s .= '  ▕'

  endfor

  let s .= '%#TabLineFill#%T'

  return s
endfunction
