vim.pack.add({ "https://github.com/mcchrish/zenbones.nvim" })

vim.g.zenbones_compat = 1
vim.cmd("colorscheme zenbones")

vim.cmd([[
  highlight LspReferenceText gui=underline
  highlight LspReferenceRead gui=underline
  highlight LspReferenceWrite gui=underline
  highlight! TabLineSel guibg=bg
]])
