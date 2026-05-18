vim.loader.enable()

function FoldText()
  local line = vim.fn.getline(vim.v.foldstart)
  return line .. " "
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

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
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars = "tab:·┈,trail:.,multispace:.,lead: ,extends:▶,precedes:◀,nbsp:˽"
vim.opt.matchpairs:append("<:>")
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.sessionoptions = { "buffers", "tabpages" }
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.shortmess:append("actFTIW")
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

vim.cmd.inoreabbrev({ "<expr>", "DATE", "strftime('%Y-%m-%d')" })
vim.cmd.inoreabbrev({ "<expr>", "DATETIME", "strftime('%Y-%m-%d | %A | %H:%M')" })

vim.keymap.set("n", "n", "nzz", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzz", { desc = "Prev search result (centered)" })

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "nvim-treesitter" and kind == "update" then
      if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
      vim.cmd("TSUpdate")
    end
  end,
})

require("config.autocommands")
