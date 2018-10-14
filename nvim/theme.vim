let g:dark=1

if g:dark
  let g:theme="dark"
  let g:onedark_terminal_italics=1
  set background=dark
  colorscheme onedark
else
  let g:solarized_term_italics=1
  set background=light
  colorscheme solarized8
  hi! ALEErrorSign gui=bold guifg=#dc322f guibg=#EEE8D5
  hi! ALEWarningSign gui=bold guifg=#b58900 guibg=#EEE8D5
endif
