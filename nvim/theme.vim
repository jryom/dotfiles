let g:dark=2

if g:dark==1
  set background=dark
  let g:material_terminal_italics = 1
  let g:material_theme_style = 'palenight'
  colorscheme material
elseif g:dark==2
  let g:lightline.colorscheme = 'challenger_deep'
  colorscheme challenger_deep
else
  let g:solarized_term_italics=1
  let g:lightline.colorscheme  = 'solarized'
  set background=light
  colorscheme solarized8
  hi! ALEErrorSign gui=bold guifg=#dc322f guibg=#EEE8D5
  hi! ALEWarningSign gui=bold guifg=#b58900 guibg=#EEE8D5
endif
