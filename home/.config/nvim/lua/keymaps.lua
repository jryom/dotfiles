local map = vim.keymap.set
local termcodes = function(string)
  return vim.api.nvim_replace_termcodes(string, true, true, true)
end

map("n", "j", "v:count == 0 ? 'gj' : '<Esc>'.v:count.'j'", { expr = true })
map("n", "k", "v:count == 0 ? 'gk' : '<Esc>'.v:count.'k'", { expr = true })
map("x", "<", "<gv")
map("x", ">", ">gv")
map("n", "gt", "<C-]>")
map("n", "<esc>", ":nohlsearch<cr>")
map("n", "<space>r", ":%s/<C-r><C-w>//c <Left><Left><Left>")
map("x", "<space>r", '"sy:%s/<C-r>s//c <Left><Left><Left>')
map("n", "<space>g", "grep<Space>")
map("n", "<space><space>", ":write<cr>")
map("x", "*", 'y/<C-R>=escape(@","/")<cr><cr>')

-- various plugin mappings
map("x", "ga", "<plug>(EasyAlign)")
map("n", "<space>m", ":MarkdownPreviewToggle<cr>")
map("n", "<space>u", ":MundoToggle<cr>")
map("n", "<space>q", "<plug>(qf_qf_toggle)")

-- close-buffers
map("n", "Q", ":Bdelete menu<cr>")
map("n", "Qa", ":Bdelete all<cr>")
map("n", "Qh", ":Bdelete hidden<cr>")
map("n", "Qo", ":Bdelete other<cr>")
map("n", "Qt", ":Bdelete this<cr>")
map("n", "Qs", ":Bdelete select<cr>")

function expand_snippet()
  return termcodes("<C-r>") .. [[=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])]] .. termcodes("<cr>")
end

-- coc.nvim
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

map("n", "J", "coc#float#has_scroll() ? coc#float#scroll(1) : 'J'", { silent = true, expr = true })
map("n", "K", "coc#float#has_scroll() ? coc#float#scroll(0) : 'K'", { silent = true, expr = true })
map("n", "<space>a", "<Plug>(coc-codeaction)", { silent = true })
map("x", "<space>f", "<plug>(coc-format-selected)", { silent = true })
map("n", "<space>f", "<plug>(coc-format)", { silent = true })
map("n", "<space>n", "<plug>(coc-diagnostic-next)", { silent = true })
map("n", "<space>p", "<plug>(coc-diagnostic-prev)", { silent = true })
map("n", "<space>l", ":CocList<cr>", { silent = true })
map("n", "<space>c", ":CocCommand<cr>", { silent = true })
map("n", "gh", ":call CocActionAsync('doHover')<cr>", { silent = true })
map("n", "gd", "<plug>(coc-definition)", { silent = true })
map("i", "<C-l>", "v:lua.complete()", { expr = true, silent = true })
map("i", "<C-n>", 'pumvisible() ? "\\<C-n>" : coc#refresh()', { silent = true, expr = true })

-- fzf
map("x", "<space>i", '"fy :FzfLua grep_visual <C-R>f<cr>')
map("n", "<space>i", ":FzfLua grep_project<cr>")
map("n", "<space>o", ":FzfLua files<cr>")
map("n", "<space>b", ":FzfLua buffers<cr>")

-- tabs
map("n", "<C-t>n", ":tabnew %<cr>")
map("n", "<C-t><C-n>", ":tabnew %<cr>")
map("n", "<C-t>c", ":tabclose<cr>")
map("n", "<C-t><C-c>", ":tabclose<cr>")
map("n", "<C-t>h", ":tabprevious<cr>")
map("n", "<C-t><C-h>", ":tabprevious<cr>")
map("n", "<C-t>l", ":tabnext<cr>")
map("n", "<C-t><C-l>", ":tabnext<cr>")
map("n", "<C-t>1", "1gt")
map("n", "<C-t>2", "2gt")
map("n", "<C-t>3", "3gt")
map("n", "<C-t>4", "4gt")
map("n", "<C-t>5", "5gt")
map("n", "<C-t>6", "6gt")
map("n", "<C-t>7", "7gt")
map("n", "<C-t>8", "8gt")
map("n", "<C-t>9", "9gt")

-- unimpaired on non-US layouts
map("n", "<left>", "[")
map("o", "<left>", "[")
map("x", "<left>", "[")
map("n", "<right>", "]")
map("o", "<right>", "]")
map("x", "<right>", "]")
