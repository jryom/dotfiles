require("plugins")
require("autocommands")
require("keymaps")

vim.opt.expandtab = true
vim.opt.fillchars = "eob: "
vim.opt.gdefault = true
vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.matchpairs:append("<:>")
vim.opt.number = true
vim.opt.sessionoptions:remove("blank")
vim.opt.shiftround = true
vim.opt.shortmess:append("actFTWI")
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.undofile = true
