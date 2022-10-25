local map = vim.keymap.set
local termcodes = function(string) return vim.api.nvim_replace_termcodes(string, true, true, true) end

map("n", "j", "v:count == 0 ? 'gj' : '<Esc>'.v:count.'j'", { expr = true })
map("n", "k", "v:count == 0 ? 'gk' : '<Esc>'.v:count.'k'", { expr = true })
map("x", "<", "<gv")
map("x", ">", ">gv")
map("n", "gt", "<C-]>")
map("n", "<esc>", ":nohlsearch<cr>")
map("n", "<space>r", ":%s/<C-r><C-w>//c <Left><Left><Left>")
map("x", "<space>r", '"sy:%s/<C-r>s//c <Left><Left><Left>')
map("n", "<space>g", ":silent grep<Space>")
map("n", "<space><space>", ":write<cr>")
map("x", "p", "pgvy")
map("n", "c", '"_c')
map("v", "c", '"_c')
map("n", "C", '"_C')
map("v", "C", '"_C')

-- various plugin mappings
map("x", "ga", "<plug>(EasyAlign)")
map("n", "<space>u", ":UndotreeToggle<cr>")
map("n", "<space>q", "<plug>(qf_qf_toggle)")

-- close-buffers
map("n", "Q", ":Bdelete menu<cr>")
map("n", "Qa", ":Bdelete all<cr>")
map("n", "Qh", ":Bdelete hidden<cr>")
map("n", "Qo", ":Bdelete other<cr>")
map("n", "Qt", ":Bdelete this<cr>")
map("n", "Qs", ":Bdelete select<cr>")

-- coc.nvim
function expand_snippet()
  return termcodes("<C-r>") .. [[=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])]] .. termcodes("<cr>")
end

function complete()
  if vim.fn.pumvisible() == 0 or vim.fn.complete_info({ "selected" }).selected < 0 then
    if vim.fn["coc#expandableOrJumpable"]() then
      return expand_snippet()
    else
      return vim.fn["coc#refresh"]()
    end
  else
    if vim.fn["coc#expandableOrJumpable"]() then
      return expand_snippet()
    else
      return termcodes("<C-y>")
    end
  end
end

local silent = { silent = true }
map("n", "<space>a", "<plug>(coc-codeaction)", silent)
map("x", "<space>f", "<plug>(coc-format-selected)", silent)
map("n", "<space>f", "<plug>(coc-format)", silent)
map("n", "<space>n", "<plug>(coc-diagnostic-next)", silent)
map("n", "<space>p", "<plug>(coc-diagnostic-prev)", silent)
map("n", "<space>l", ":CocList<cr>", silent)
map("n", "<space>c", ":CocCommand<cr>", silent)
map("n", "<space>h", ":call CocActionAsync('doHover')<cr>", silent)
map("n", "<space>d", "<plug>(coc-definition)", silent)
map("n", "<space>t", "<plug>(coc-type-definition)", silent)

map("n", "J", "coc#float#has_scroll() ? coc#float#scroll(1) : 'J'", { silent = true, expr = true })
map("n", "K", "coc#float#has_scroll() ? coc#float#scroll(0) : 'K'", { silent = true, expr = true })

local opts = { expr = true, silent = true, replace_keycodes = false }
map("i", "<C-l>", "coc#pum#visible() ? coc#pum#confirm() : v:lua.complete()", opts)
map("i", "<C-n>", "coc#pum#visible() ? coc#pum#next(1) : coc#refresh()", opts)
map("i", "<C-p>", "coc#pum#visible() ? coc#pum#prev(1) : coc#refresh()", opts)
map("i", "<C-j>", "coc#pum#visible() ? coc#pum#next(1) : coc#refresh()", opts)
map("i", "<C-k>", "coc#pum#visible() ? coc#pum#prev(1) : coc#refresh()", opts)

-- fzf
map("x", "<space>i", '"fy :FzfLua grep_visual <C-R>f<cr>')
map("n", "<space>i", ":FzfLua grep_project<cr>")
map("n", "<space>o", ":FzfLua files<cr>")
map("n", "<space>b", ":FzfLua buffers<cr>")
map(
  "n",
  "<space>s",
  ":lua require('fzf-lua').grep_curbuf({prompt='Buffer ',winopts={height=0.1,split='belowright new | resize 10',preview={hidden='hidden'}}})<cr>"
)

-- tabs
map("n", "<C-t>n", ":tabnew %<cr>")
map("n", "<C-t><C-n>", ":tabnew %<cr>")
map("n", "<C-t>c", ":tabclose<cr>")
map("n", "<C-t><C-c>", ":tabclose<cr>")
map("n", "<C-t>h", ":tabprevious<cr>")
map("n", "<C-t><C-h>", ":tabprevious<cr>")
map("n", "<C-t>l", ":tabnext<cr>")
map("n", "<C-t><C-l>", ":tabnext<cr>")

-- unimpaired on non-US layouts
map("n", "<left>", "[")
map("o", "<left>", "[")
map("x", "<left>", "[")
map("n", "<right>", "]")
map("o", "<right>", "]")
map("x", "<right>", "]")