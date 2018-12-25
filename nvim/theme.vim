if systemlist("defaults read -g AppleInterfaceStyle")[0]=='Dark'
  set background=dark
  let g:material_terminal_italics = 1
  let g:material_theme_style = 'palenight'
  colorscheme material
  silent !kitty @ --to unix:/tmp/mykitty set-colors -a -c ~/.config/kitty/palenight.conf
  " let g:lightline.colorscheme = 'challenger_deep'
  " colorscheme challenger_deep
else
  let g:solarized_term_italics=1
  let g:lightline.colorscheme  = 'solarized'
  set background=light
  colorscheme solarized8
  silent !kitty @ --to unix:/tmp/mykitty set-colors -a -c ~/.config/kitty/solarized_light.conf
  hi! ALEErrorSign gui=bold guifg=#dc322f guibg=#EEE8D5
  hi! ALEWarningSign gui=bold guifg=#b58900 guibg=#EEE8D5
endif
