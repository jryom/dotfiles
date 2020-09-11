" Undercurl for term
let &t_Cs = "\e[4:3m"
let &t_Ce = "\e[4:0m"

" Cursor modes for term
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

highlight clear
syntax reset

if len(systemlist('defaults read -g AppleInterfaceStyle'))
  set background=dark
else
  set background=light
endif

highlight clear
syntax reset

let g:colors_name = "base16"

hi link                       PreCondit        PreProc
hi link                       SpecialComment   Special
hi link                       StatusLineTerm   StatusLine
hi link                       StatusLineTermNC StatusLineNC
hi link                       helpSpecial      Special
hi link                       lCursor          Cursor
hi link                       vimFunc          Function
hi link                       vimSet           Normal
hi link                       vimSetEqual      Normal
hi link                       vimUserFunc      Function
hi link                       vimVar           Identifier
hi link                       vimLet           StorageClass
hi link                       vimMap           Statement

hi Terminal                   ctermfg=07       ctermbg=0    cterm=NONE
hi ToolbarButton              ctermfg=07       ctermbg=18   cterm=bold
hi helpVim                    ctermfg=05       ctermbg=NONE cterm=NONE
hi vimCmdSep                  ctermfg=04       ctermbg=NONE cterm=bold
" hi vimCommand                 ctermfg=02   ctermbg=NONE cterm=NONE
hi vimCommentString           ctermfg=05       ctermbg=NONE cterm=NONE
" hi vimGroup                   ctermfg=04   ctermbg=NONE cterm=bold
hi vimHiGroup                 ctermfg=03       ctermbg=NONE cterm=NONE
hi vimHiLink                  ctermfg=04       ctermbg=NONE cterm=NONE
" hi vimIsCommand               ctermfg=18   ctermbg=NONE cterm=NONE
hi vimSynMtchOpt              ctermfg=03       ctermbg=NONE cterm=NONE
hi vimSynType                 ctermfg=06       ctermbg=NONE cterm=NONE
hi vimSetEqual                ctermfg=04       ctermbg=NONE cterm=NONE

hi Bold                       ctermfg=NONE     ctermbg=NONE cterm=bold
hi ColorColumn                ctermfg=NONE     ctermbg=18   cterm=NONE
hi Conceal                    ctermfg=04       ctermbg=00   cterm=NONE
hi Cursor                     ctermfg=00       ctermbg=07   cterm=NONE
hi CursorColumn               ctermfg=NONE     ctermbg=18   cterm=NONE
hi CursorLine                 ctermfg=NONE     ctermbg=18   cterm=NONE
hi CursorLineNr               ctermfg=20       ctermbg=NONE cterm=bold
hi Debug                      ctermfg=01       ctermbg=NONE cterm=NONE
hi Directory                  ctermfg=04       ctermbg=NONE cterm=NONE
hi EndOfBuffer                ctermfg=19       ctermbg=NONE cterm=NONE
hi Error                      ctermfg=01       ctermbg=NONE cterm=undercurl
hi ErrorMsg                   ctermfg=01       ctermbg=00   cterm=NONE
hi Exception                  ctermfg=01       ctermbg=NONE cterm=NONE
hi FoldColumn                 ctermfg=06       ctermbg=18   cterm=NONE
hi Folded                     ctermfg=08       ctermbg=18   cterm=NONE
hi IncSearch                  ctermfg=18       ctermbg=16   cterm=NONE
hi Italic                     ctermfg=NONE     ctermbg=NONE cterm=italic
hi LineNr                     ctermfg=08       ctermbg=00   cterm=NONE
hi Macro                      ctermfg=01       ctermbg=NONE cterm=NONE
hi MatchParen                 ctermfg=07       ctermbg=NONE cterm=bold
hi ModeMsg                    ctermfg=02       ctermbg=NONE cterm=NONE
hi MoreMsg                    ctermfg=02       ctermbg=NONE cterm=NONE
hi NonText                    ctermfg=08       ctermbg=NONE cterm=NONE
hi Normal                     ctermfg=07       ctermbg=NONE cterm=NONE
hi PMenu                      ctermfg=07       ctermbg=18   cterm=NONE
hi PMenuSel                   ctermfg=18       ctermbg=07   cterm=NONE
hi PmenuSbar                  ctermfg=NONE     ctermbg=18   cterm=NONE
hi PmenuThumb                 ctermfg=NONE     ctermbg=8    cterm=NONE
hi Question                   ctermfg=04       ctermbg=NONE cterm=NONE
hi QuickFixLine               ctermfg=NONE     ctermbg=18   cterm=NONE
hi Search                     ctermfg=18       ctermbg=03   cterm=NONE
hi SignColumn                 ctermfg=08       ctermbg=00   cterm=NONE
hi SpecialKey                 ctermfg=08       ctermbg=NONE cterm=NONE
hi StatusLine                 ctermfg=20       ctermbg=18   cterm=NONE
hi StatusLineRed              ctermfg=16       ctermbg=18   cterm=bold
hi StatusLineGit              ctermfg=08       ctermbg=18   cterm=NONE
hi StatusLineNC               ctermfg=08       ctermbg=18   cterm=NONE
hi Substitute                 ctermfg=18       ctermbg=03   cterm=NONE
hi TabLine                    ctermfg=08       ctermbg=18   cterm=NONE
hi TabLineFill                ctermfg=08       ctermbg=18   cterm=NONE
hi TabLineSel                 ctermfg=07       ctermbg=00   cterm=bold
hi Title                      ctermfg=04       ctermbg=NONE cterm=NONE
hi TooLong                    ctermfg=01       ctermbg=NONE cterm=NONE
hi Underlined                 ctermfg=01       ctermbg=NONE cterm=NONE
hi VertSplit                  ctermfg=18       ctermbg=18   cterm=NONE
hi Visual                     ctermfg=NONE     ctermbg=18   cterm=NONE
hi VisualNOS                  ctermfg=01       ctermbg=NONE cterm=NONE
hi WarningMsg                 ctermfg=01       ctermbg=NONE cterm=NONE
hi WildMenu                   ctermfg=07       ctermbg=NONE cterm=bold

" Standard syntax
hi Boolean                    ctermfg=16       ctermbg=NONE cterm=NONE
hi Character                  ctermfg=01       ctermbg=NONE cterm=NONE
hi Comment                    ctermfg=08       ctermbg=NONE cterm=italic
hi Conditional                ctermfg=05       ctermbg=NONE cterm=NONE
hi Constant                   ctermfg=16       ctermbg=NONE cterm=NONE
hi Define                     ctermfg=05       ctermbg=NONE cterm=NONE
hi Delimiter                  ctermfg=17       ctermbg=NONE cterm=NONE
hi Float                      ctermfg=16       ctermbg=NONE cterm=NONE
hi Function                   ctermfg=04       ctermbg=NONE cterm=NONE
hi Identifier                 ctermfg=01       ctermbg=NONE cterm=NONE
hi Include                    ctermfg=04       ctermbg=NONE cterm=NONE
hi Keyword                    ctermfg=05       ctermbg=NONE cterm=NONE
hi Label                      ctermfg=03       ctermbg=NONE cterm=NONE
hi Number                     ctermfg=16       ctermbg=NONE cterm=NONE
hi Operator                   ctermfg=16       ctermbg=NONE cterm=NONE
hi PreProc                    ctermfg=16       ctermbg=NONE cterm=NONE
hi Repeat                     ctermfg=03       ctermbg=NONE cterm=NONE
hi Special                    ctermfg=06       ctermbg=NONE cterm=NONE
hi SpecialChar                ctermfg=17       ctermbg=NONE cterm=NONE
hi Statement                  ctermfg=01       ctermbg=NONE cterm=NONE
hi StorageClass               ctermfg=03       ctermbg=NONE cterm=NONE
hi String                     ctermfg=02       ctermbg=NONE cterm=NONE
hi Structure                  ctermfg=05       ctermbg=NONE cterm=NONE
hi Tag                        ctermfg=03       ctermbg=NONE cterm=NONE
hi Todo                       ctermfg=03       ctermbg=18   cterm=NONE
hi Type                       ctermfg=03       ctermbg=NONE cterm=NONE
hi Typedef                    ctermfg=03       ctermbg=NONE cterm=NONE

hi VarId                      ctermfg=32       ctermbg=NONE cterm=NONE
hi ConId                      ctermfg=136      ctermbg=NONE cterm=NONE

" CSS
" hi cssAttrComma
" hi cssAttributeSelector
hi cssBraces                  ctermfg=07       ctermbg=NONE cterm=NONE
hi cssClassName               ctermfg=05       ctermbg=NONE cterm=NONE
" hi cssClassNameDot
hi cssColor                   ctermfg=06       ctermbg=NONE cterm=NONE
" hi cssDefinition
" hi cssFontAttr
" hi cssFontDescriptor
" hi cssFunctionName
" hi cssIdentifier
" hi cssImportant
" hi cssInclude
" hi cssIncludeKeyword
" hi cssMediaType
" hi cssProp
" hi cssPseudoClassId
" hi cssSelectorOp
" hi cssSelectorOp2
" hi cssTagName

" Diff
hi DiffAdd                    ctermfg=02       ctermbg=NONE cterm=NONE
hi DiffAdded                  ctermfg=02       ctermbg=00   cterm=NONE
hi DiffChange                 ctermfg=04       ctermbg=NONE cterm=NONE
hi DiffChangeDelete           ctermfg=05       ctermbg=NONE cterm=NONE
hi DiffDelete                 ctermfg=01       ctermbg=NONE cterm=NONE
hi DiffFile                   ctermfg=01       ctermbg=00   cterm=NONE
hi DiffLine                   ctermfg=04       ctermbg=00   cterm=NONE
hi DiffNewFile                ctermfg=02       ctermbg=00   cterm=NONE
hi DiffRemoved                ctermfg=01       ctermbg=00   cterm=NONE
hi DiffText                   ctermfg=04       ctermbg=18   cterm=NONE

" Git
hi gitcommitOverflow          ctermfg=01       ctermbg=NONE cterm=NONE
hi gitcommitSummary           ctermfg=02       ctermbg=NONE cterm=NONE
hi gitcommitComment           ctermfg=08       ctermbg=NONE cterm=NONE
hi gitcommitUntracked         ctermfg=08       ctermbg=NONE cterm=NONE
hi gitcommitDiscarded         ctermfg=08       ctermbg=NONE cterm=NONE
hi gitcommitSelected          ctermfg=08       ctermbg=NONE cterm=NONE
hi gitcommitHeader            ctermfg=05       ctermbg=NONE cterm=NONE
hi gitcommitSelectedType      ctermfg=04       ctermbg=NONE cterm=NONE
hi gitcommitUnmergedType      ctermfg=04       ctermbg=NONE cterm=NONE
hi gitcommitDiscardedType     ctermfg=04       ctermbg=NONE cterm=NONE
hi gitcommitBranch            ctermfg=16       ctermbg=NONE cterm=bold
hi gitcommitUntrackedFile     ctermfg=03       ctermbg=NONE cterm=NONE
hi gitcommitUnmergedFile      ctermfg=01       ctermbg=NONE cterm=bold
hi gitcommitDiscardedFile     ctermfg=01       ctermbg=NONE cterm=bold
hi gitcommitSelectedFile      ctermfg=02       ctermbg=NONE cterm=bold

" GitGutter
hi GitGutterAdd               ctermfg=02       ctermbg=NONE cterm=NONE
hi GitGutterChange            ctermfg=04       ctermbg=NONE cterm=NONE
hi GitGutterDelete            ctermfg=01       ctermbg=NONE cterm=NONE
hi GitGutterChangeDelete      ctermfg=05       ctermbg=NONE cterm=NONE

" HTML
hi htmlArg                    ctermfg=66       ctermbg=NONE cterm=NONE
hi htmlBold                   ctermfg=03       ctermbg=NONE cterm=NONE
hi htmlEndTag                 ctermfg=07       ctermbg=NONE cterm=NONE
" hi htmlH1
" hi htmlH2
" hi htmlH3
" hi htmlH4
" hi htmlH5
" hi htmlH6
hi htmlItalic                 ctermfg=05       ctermbg=NONE cterm=NONE
" hi htmlLink
" hi htmlSpecialChar
hi htmlSpecialTagName         ctermfg=32       ctermbg=NONE cterm=italic
hi htmlTag                    ctermfg=07       ctermbg=NONE cterm=NONE
hi htmlTagN                   ctermfg=247      ctermbg=NONE cterm=bold
hi htmlTagName                ctermfg=32       ctermbg=NONE cterm=bold
" hi htmlTitle

" JavaScript
hi javaScript                 ctermfg=07       ctermbg=NONE cterm=NONE
hi javaScriptBraces           ctermfg=07       ctermbg=NONE cterm=NONE
hi javaScriptNumber           ctermfg=16       ctermbg=NONE cterm=NONE
" hi javaScriptBraces
" hi javaScriptFunction
" hi javaScriptIdentifier
" hi javaScriptNull
" hi javaScriptNumber
" hi javaScriptRequire
" hi javaScriptReserved
" pangloss/vim-javascript
" hi jsArrowFunction
hi jsBuiltins                 ctermfg=03       ctermbg=NONE cterm=NONE
hi jsClassDefinition          ctermfg=03       ctermbg=NONE cterm=NONE
hi jsClassFuncName            ctermfg=04       ctermbg=NONE cterm=NONE
" hi jsClassKeyword
hi jsClassMethodType          ctermfg=05       ctermbg=NONE cterm=NONE
" hi jsDocParam
" hi jsDocTags
hi jsExceptions               ctermfg=03       ctermbg=NONE cterm=NONE
" hi jsExport
hi link                       jsExportDefault  Include
" hi jsExtendsKeyword
" hi jsFrom
hi jsFuncCall                 ctermfg=04       ctermbg=NONE cterm=NONE
hi jsFuncName                 ctermfg=04       ctermbg=NONE cterm=NONE
hi jsFunction                 ctermfg=05       ctermbg=NONE cterm=NONE
hi jsGlobalNodeObjects        ctermfg=03       ctermbg=NONE cterm=NONE
hi jsGlobalObjects            ctermfg=03       ctermbg=NONE cterm=NONE
" hi jsImport
" hi jsModuleAs
" hi jsModuleWords
" hi jsModules
" hi jsNull
" hi jsObjectProp               ctermfg=04
hi jsOperator                 ctermfg=04       ctermbg=NONE cterm=NONE
hi jsRegexpString             ctermfg=06       ctermbg=NONE cterm=NONE
hi jsReturn                   ctermfg=05       ctermbg=NONE cterm=NONE
hi jsStatement                ctermfg=05       ctermbg=NONE cterm=NONE
hi Noise                      ctermfg=20       ctermbg=NONE cterm=NONE
" hi link jsVariableDef Identifier
" hi jsStorageClass
" hi jsSuper
hi link                       jsFuncArgCommas  Noise
hi link                       jsTemplateBraces PreProc
" hi jsTemplateVar
hi jsThis                     ctermfg=01       ctermbg=NONE cterm=NONE
" hi jsUndefined

" JSON
" hi jsonBoolean
" hi jsonCommentError
" hi jsonKeyword
" hi jsonMissingCommaError
" hi jsonNoQuotesError
" hi jsonNumError
" hi jsonNumber
" hi jsonQuote
" hi jsonSemicolonError
" hi jsonString
" hi jsonStringSQError

" Markdown
" hi markdownBlockquote
" hi markdownBold
hi markdownCode               ctermfg=02       ctermbg=NONE cterm=NONE
hi markdownCodeBlock          ctermfg=02       ctermbg=NONE cterm=NONE
" hi markdownCodeDelimiter
hi markdownError              ctermfg=07       ctermbg=00   cterm=NONE
" hi markdownH1
" hi markdownH2
" hi markdownH3
" hi markdownH4
" hi markdownH5
" hi markdownH6
hi markdownHeadingDelimiter   ctermfg=04       ctermbg=NONE cterm=NONE
" hi markdownHeadingRule
" hi markdownId
" hi markdownIdDeclaration
" hi markdownIdDelimiter
" hi markdownItalic
" hi markdownLinkDelimiter
" hi markdownLinkText
" hi markdownListMarker
" hi markdownOrderedListMarker
" hi markdownRule
" hi markdownUrl

" Python
hi pythonOperator             ctermfg=05       ctermbg=NONE cterm=NONE
hi pythonRepeat               ctermfg=05       ctermbg=NONE cterm=NONE
hi pythonInclude              ctermfg=05       ctermbg=NONE cterm=NONE
hi pythonStatement            ctermfg=05       ctermbg=NONE cterm=NONE

" SASS
hi sassidChar                 ctermfg=01       ctermbg=NONE cterm=NONE
hi sassClassChar              ctermfg=16       ctermbg=NONE cterm=NONE
hi sassInclude                ctermfg=05       ctermbg=NONE cterm=NONE
hi sassMixing                 ctermfg=05       ctermbg=NONE cterm=NONE
hi sassMixinName              ctermfg=04       ctermbg=NONE cterm=NONE
" cakebaker/scss-syntax.vim
" hi scssExtend
" hi scssImport
" hi scssInclude
" hi scssMixin
" hi scssSelectorName
" hi scssVariable
" tpope/vim-haml
" hi sassAmpersand
" hi sassClass
" hi sassControl
" hi sassExtend
" hi sassFor
" hi sassFunction
" hi sassId
" hi sassInclude
" hi sassMedia
" hi sassMediaOperators
" hi sassMixin
" hi sassMixinName
" hi sassMixing
" hi sassVariable

" Spelling
hi SpellBad                   ctermfg=01       ctermbg=NONE cterm=undercurl
hi SpellLocal                 ctermfg=NONE     ctermbg=NONE cterm=undercurl
hi SpellCap                   ctermfg=NONE     ctermbg=NONE cterm=undercurl
hi SpellRare                  ctermfg=NONE     ctermbg=NONE cterm=undercurl

" Ale
hi ALEErrorSign               ctermfg=01       ctermbg=NONE cterm=NONE
hi ALEWarningSign             ctermfg=03       ctermbg=NONE cterm=NONE
hi ALEVirtualTextError        ctermfg=01       ctermbg=NONE cterm=italic
hi ALEVirtualTextStyleError   ctermfg=01       ctermbg=NONE cterm=italic
hi ALEVirtualTextWarning      ctermfg=03       ctermbg=NONE cterm=italic
hi ALEVirtualTextStyleWarning ctermfg=03       ctermbg=NONE cterm=italic
hi ALEVirtualTextInfo         ctermfg=04       ctermbg=NONE cterm=italic

" Coc
hi CocErrorHighlight          ctermfg=01       ctermbg=NONE cterm=undercurl
hi CocWarningHighlight        ctermfg=03       ctermbg=NONE cterm=undercurl
hi CocInfoHighlight           ctermfg=04       ctermbg=NONE cterm=undercurl
hi CocHintHighlight           ctermfg=04       ctermbg=NONE cterm=undercurl
hi CocErrorSign               ctermfg=01       ctermbg=NONE cterm=NONE
hi CocWarningSign             ctermfg=03       ctermbg=NONE cterm=NONE
hi CocInfoSign                ctermfg=04       ctermbg=NONE cterm=NONE
hi CocHintSign                ctermfg=04       ctermbg=NONE cterm=NONE
hi CocHighlightText           ctermfg=NONE     ctermbg=NONE cterm=underline

hi HighlightedyankRegion      ctermfg=00       ctermbg=03   cterm=NONE

hi fzf1                       ctermfg=07       ctermbg=18
hi fzf2                       ctermfg=07       ctermbg=18
hi fzf3                       ctermfg=07       ctermbg=18
