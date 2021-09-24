local merge = function(t1, t2)
  for k, v in pairs(t2) do
    t1[k] = v
  end
  return t1
end

local map = function(modes, key, result, options)
  options = merge({
    noremap = true,
    silent = false,
    expr = false,
    nowait = false,
  }, options or {})

  if type(modes) ~= "table" then
    modes = { modes }
  end

  for i = 1, #modes do
    vim.api.nvim_set_keymap(modes[i], key, result, options)
  end
end

vim.g.mapleader = " "
map("n", "<Space>", "", { noremap = false })
map("n", "j", "v:count == 0 ? 'gj' : '<Esc>'.v:count.'j'", { expr = true })
map("n", "k", "v:count == 0 ? 'gk' : '<Esc>'.v:count.'k'", { expr = true })
map("n", "<c-w>m", ":MaximizerToggle<cr>", { silent = true })
map("n", "Y", "y$")
map("n", "<", "<gv")
map("n", ">", ">gv")
map("n", "<Esc>", ":nohlsearch<cr>", { silent = true })
map("n", "<leader>q", "<Plug>(qf_qf_toggle", { silent = true, noremap = false })
map("n", "<leader>u", ":MundoToggle<cr>", { silent = true })
map({ "n", "x" }, "<leader>r", '"sy:%s/<C-r>s//c <Left><Left><Left>', {})
map("n", "<leader>g", ":silent grep<Space>")
map("n", "<leader>m", ":MarkdownPreviewToggle<cr>")
map("n", "<leader>w", "<cmd>HopWord<cr>", {})
map("n", "<leader>s", "<cmd>HopLineStart<cr>", {})
map("n", "<leader><leader>", ":write<cr>", {})
map({ "n", "x" }, "ga", "<Plug>(EasyAlign)", { noremap = false })
map("n", "<leader>ts", ":Obsession<cr>", {})

-- close-buffers
map("n", "Q", ":Bdelete menu<cr>", {})
map("n", "Qa", ":Bdelete all<cr>", {})
map("n", "Qh", ":Bdelete hidden<cr>", {})
map("n", "Qo", ":Bdelete other<cr>", {})
map("n", "Qt", ":Bdelete this<cr>", {})
map("n", "Qs", ":Bdelete select<cr>", {})

-- tabs
map("n", "<C-t>", ":tabnew %<cr>", { silent = true, noremap = false })
map("n", "<C-q>", ":tabclose<cr>", { silent = true, noremap = false })

-- telescope
map("n", "<leader>i", ":Telescope live_grep<cr>", { silent = true, noremap = false })
map("n", "<leader>o", ":Telescope find_files<cr>", { silent = true, noremap = false })
map("n", "<leader>b", ":Telescope buffers <cr>", { silent = true, noremap = false })

-- unimpaired on non-US layouts
map({ "n", "o", "x" }, "<Left>", "[")
map({ "n", "o", "x" }, "<Right>", "]")
