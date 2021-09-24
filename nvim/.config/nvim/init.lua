require("plugins")
require("lsp")
require("mappings")

vim.opt.colorcolumn = "999"
vim.opt.expandtab = true
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.foldminlines = 3
vim.opt.gdefault = true
vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.matchpairs:append({ "<:>" })
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.pumblend = 12
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.shiftround = true
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.syntax = "off"
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.winblend = 12

vim.cmd([[
  augroup autocommands
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    autocmd BufEnter * :syntax sync fromstart
    autocmd BufRead,BufNewFile .{eslint,babel,stylelint,prettier}rc set ft=json5
    autocmd SessionLoadPost,VimResized * wincmd =
    autocmd WinEnter,BufWinEnter * setlocal cursorline | autocmd WinLeave * setlocal nocursorline
    autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
    autocmd VimEnter * nested if !argc() && empty(v:this_session) && filereadable('Session.vim') | source Session.vim | endif
  augroup END
 ]])

vim.g.rooter_silent_chdir = 1
vim.g.indent_blankline_filetype_exclude = { "help", "markdown" }
vim.g.indent_blankline_char = "▏"
vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.vsnip_snippet_dir = "~/.config/nvim/snippets"
vim.g.gitblame_date_format = "%r"
vim.g.Hexokinase_virtualText = "▮"
vim.g.Hexokinase_optInPatterns = "full_hex,rgb,rgba,hsl,hsla"
