local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

function FoldText()
  local line = vim.fn.getline(vim.v.foldstart)
  return line .. " "
end

vim.o.foldtext = "v:lua.FoldText()"
vim.opt.cmdheight = 0
vim.opt.confirm = true
vim.opt.expandtab = true
vim.opt.fillchars = { eob = " ", fold = " " }
vim.opt.foldcolumn = "0"
vim.opt.foldenable = true
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 4
vim.opt.foldmethod = "expr"
vim.opt.foldnestmax = 4
vim.opt.gdefault = true
vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.laststatus = 3
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars = "tab:·┈,trail:.,multispace:.,lead: ,extends:▶,precedes:◀,nbsp:˽"
vim.opt.matchpairs:append("<:>")
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.sessionoptions = { "buffers", "tabpages" }
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.shortmess:append("ctFTI")
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.undofile = true
vim.opt.wrap = true

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.cmd.inoreabbrev({
  "<expr>",
  "DATE",
  "strftime('%Y.%m.%d | %A | %H:%M')",
})

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  checker = { enabled = true },
})
