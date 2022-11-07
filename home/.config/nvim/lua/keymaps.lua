local map = vim.keymap.set
local termcodes = function(string) return vim.api.nvim_replace_termcodes(string, true, true, true) end
local hydra = require("hydra")

map("n", "j", "v:count == 0 ? 'gj' : '<Esc>'.v:count.'j'", { expr = true })
map("n", "k", "v:count == 0 ? 'gk' : '<Esc>'.v:count.'k'", { expr = true })
map("x", "<", "<gv")
map("x", ">", ">gv")
map("n", "gt", "<C-]>")
map("n", "<esc>", ":nohlsearch<cr>")
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
map("n", "<space>s", "<cmd>lua require('spectre').open()<CR>", { silent = true })
map("n", "-", "<cmd>execute 'e ' .. expand('%:p:h')<CR>", { noremap = true })
map(
  "x",
  "<space>s",
  '"vy :lua require("spectre").open({ is_insert_mode=false,search_text=vim.fn.getreg("v") })<CR>',
  { silent = true }
)

-- close-buffers
map("n", "Q", ":Bdelete menu<cr>")
map("n", "Qa", ":Bdelete all<cr>")
map("n", "Qh", ":Bdelete hidden<cr>")
map("n", "Qo", ":Bdelete other<cr>")
map("n", "Qt", ":Bdelete this<cr>")
map("n", "Qs", ":Bdelete select<cr>")

-- coc.nvim
function showDocumentation()
  vim.cmd([[
    if CocAction('hasProvider', 'hover')
      call CocActionAsync('doHover')
    else
      call feedkeys('K', 'in')
    endif
  ]])
end
map(
  "n",
  "K",
  "coc#float#has_scroll() ? coc#float#scroll(0) : ':lua showDocumentation()<cr>'",
  { silent = true, expr = true }
)

function renameWord()
  vim.cmd([[
    if CocAction('hasProvider', 'rename')
      exec "norm \<plug>(coc-rename)"
    else
      call feedkeys(":%s/\<C-r>\<C-w>//c \<Left>\<Left>\<Left>")
    endif
  ]])
end
map("n", "<space>r", ":lua renameWord()<cr>")
map("x", "<space>r", '"sy:%s/<C-r>s//c <Left><Left><Left>')

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
map("x", "<space>f", "<plug>(coc-format-selected)", silent)
map("n", "<space>f", "<plug>(coc-format)", silent)
map("n", "<space>n", "<plug>(coc-diagnostic-next)", silent)
map("n", "<space>p", "<plug>(coc-diagnostic-prev)", silent)
map("n", "J", "coc#float#has_scroll() ? coc#float#scroll(1) : 'J'", { silent = true, expr = true })

local opts = { expr = true, silent = true, replace_keycodes = false }
map("i", "<C-l>", "coc#pum#visible() ? coc#pum#confirm() : v:lua.complete()", opts)
map("i", "<C-n>", "coc#pum#visible() ? coc#pum#next(1) : coc#refresh()", opts)
map("i", "<C-p>", "coc#pum#visible() ? coc#pum#prev(1) : coc#refresh()", opts)
map("i", "<C-j>", "coc#pum#visible() ? coc#pum#next(1) : coc#refresh()", opts)
map("i", "<C-k>", "coc#pum#visible() ? coc#pum#prev(1) : coc#refresh()", opts)

hydra({
  name = "COC",
  mode = "n",
  config = {
    exit = true,
    invoke_on_body = true,
    on_enter = function() require("lualine").refresh() end,
  },
  body = "<space>c",
  heads = {
    { "d", "<plug>(coc-definition)", { desc = "Goto definition" } },
    { "t", "<plug>(coc-type-definition)", { desc = "Goto type definition" } },
    { "D", "<plug>(coc-declaration)", { desc = "Goto declaration" } },
    { "r", "<plug>(coc-references)", { desc = "References" } },
    { "a", "<plug>(coc-codeaction)", { desc = "Code action" } },
    { "c", "<cmd>CocCommand<cr>", { desc = "Commands" } },
    { "R", "<plug>(coc-refactor)", { desc = "Refactor" } },
    { "l", ":CocList<cr>", { desc = "List" } },
  },
})

-- fzf
map("x", "<space>i", '"vy :FzfLua grep_visual <C-R>v<cr>')
map("n", "<space>i", ":FzfLua grep_project<cr>")
map("n", "<space>o", ":FzfLua files<cr>")
map("n", "<space>b", ":FzfLua buffers<cr>")
map("n", "<space>h", ":FzfLua help_tags<cr>")

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

-- Vimspector
hydra({
  name = "VIMSPECTOR",
  mode = "n",
  config = {
    invoke_on_body = true,
    foreign_keys = "run",
    on_enter = function() require("lualine").refresh() end,
  },
  body = "<space>d",
  heads = {
    { "c", "<Plug>VimspectorContinue", { desc = " " } },
    { "s", "<Plug>VimspectorStop", { desc = " ", exit = true } },
    { "r", "<Plug>VimspectorRestart", { desc = " ", exit = true } },
    { "h", "<Plug>VimspectorPause", { desc = " " } },
    { "b", "<Plug>VimspectorToggleBreakpoint", { desc = " " } },
    { "p", "<Plug>VimspectorJumpToPreviousBreakpoint", { desc = " " } },
    { "n", "<Plug>VimspectorJumpToNextBreakpoint", { desc = " " } },
    { "B", ":VimspectorBreakpoints<cr>", { desc = " " } },
    { "f", "<Plug>VimspectorAddFunctionBreakpoint", { desc = " " } },
    { "i", "<Plug>VimspectorStepInto", { desc = " " } },
    { "o", "<Plug>VimspectorStepOver", { desc = " " } },
    { "O", "<Plug>VimspectorStepOut", { desc = " " } },
    { "j", "j^", { desc = false } },
    { "k", "k^", { desc = false } },
    { "<esc>", nil, { desc = false, exit = true } },
  },
})
