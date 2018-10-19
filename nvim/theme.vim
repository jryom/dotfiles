let g:theme=3

 if g:theme==1
   let g:theme="dark"
   let g:onedark_terminal_italics=1
   set background=dark
   colorscheme onedark
 elseif g:theme==2
   set background=dark
   colorscheme dracula 
 elseif g:theme==3
   set background=dark
   let g:falcon_inactive = 1
   let g:falcon_airline = 1
   let g:airline_theme = 'falcon'
   colorscheme falcon 
 else
   let g:solarized_term_italics=1
   set background=light
   colorscheme solarized8
   hi! ALEErrorSign gui=bold guifg=#dc322f guibg=#EEE8D5
   hi! ALEWarningSign gui=bold guifg=#b58900 guibg=#EEE8D5
 endif
