vim.opt.cmdheight = 0
vim.opt.confirm = true
vim.opt.expandtab = true
vim.opt.fillchars = "eob: "
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.gdefault = true
vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.linebreak = true
vim.opt.matchpairs:append("<:>")
vim.opt.scrolloff = 5
vim.opt.sessionoptions = { "buffers", "tabpages", "folds", "localoptions" }
vim.opt.shiftround = true
vim.opt.shortmess:append("ctFTI")
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.wrap = true

vim.g.mapleader = " "

vim.cmd.inoreabbrev({
  "<expr>",
  "DATE",
  "strftime('%Y.%m.%d | %A | %H:%M')",
})

require("plugin")
require("autocommands")
