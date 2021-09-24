require("impatient")
require("plugins")
require("lsp")
require("mappings")
require("packer_compiled")

vim.opt.colorcolumn = "999"
vim.opt.expandtab = true
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.foldminlines = 3
vim.opt.gdefault = true
vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.matchpairs:append({ "<:>" })
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.sessionoptions = "buffers,curdir,folds,help,tabpages"
vim.opt.scrolloff = 8
vim.opt.shiftround = true
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.updatetime = 200

vim.cmd([[
  augroup autocommands
    autocmd!
    autocmd BufWritePost nvim/**/*.lua source <afile> | PackerSync
    autocmd BufEnter * :syntax sync fromstart
    autocmd BufRead,BufNewFile .{eslint,babel,stylelint,prettier}rc set ft=json5
    autocmd SessionLoadPost,VimResized * wincmd =
    autocmd WinEnter,BufWinEnter * setlocal cursorline | autocmd WinLeave * setlocal nocursorline
    autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
  augroup END
 ]])
