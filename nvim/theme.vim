let g:dark=2

if g:dark==1
  set background=dark
  let g:material_terminal_italics = 1
  let g:material_theme_style = 'palenight'
  let g:airline_theme = 'material'
  colorscheme material
elseif g:dark==2
  let g:airline_theme = 'challenger_deep'
  colorscheme challenger_deep
  " jsx <3
  hi Tag        ctermfg=01    guifg=#ff869a
  hi xmlTag     ctermfg=01    guifg=#ff869a
  hi xmlTagName ctermfg=01    guifg=#ff869a
  hi xmlEndTag  ctermfg=01    guifg=#ff869a
  hi! ALEErrorSign gui=bold guifg=#ff5458 guibg=#100e23
  hi! ALEWarningSign gui=bold guifg=#ffe9aa guibg=#100e23
  hi link xmlEndTag xmlTag
else
  let g:solarized_term_italics=1
  set background=light
  colorscheme solarized8
  hi! ALEErrorSign gui=bold guifg=#dc322f guibg=#EEE8D5
  hi! ALEWarningSign gui=bold guifg=#b58900 guibg=#EEE8D5
endif
