au BufRead,BufNewFile .eslintrc,.jscsrc,.jshintrc,.babelrc,.stylelintrc set ft=json
au BufRead,BufNewFile gitconfig set ft=.gitconfig
au BufEnter * call ncm2#enable_for_buffer()