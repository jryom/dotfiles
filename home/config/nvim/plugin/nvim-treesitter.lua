vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
})

local languages = { "lua", "bash", "markdown", "markdown_inline", "regex" }

require("nvim-treesitter").setup({})
require("nvim-treesitter").install(languages)

local function start_treesitter(buf, lang)
  if vim.treesitter.language.add(lang) then
    vim.treesitter.start(buf, lang)
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    return true
  end
  return false
end

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter.start", {}),
  callback = function(args)
    local buf = args.buf
    local lang = vim.treesitter.language.get_lang(args.match) or args.match
    if not start_treesitter(buf, lang) then
      pcall(require("nvim-treesitter").install, lang)
    end
  end,
})

local ts_select = require("nvim-treesitter-textobjects.select")
require("nvim-treesitter-textobjects").setup({
  select = {
    lookahead = true,
    selection_modes = {
      ["@parameter.outer"] = "v",
      ["@function.outer"] = "V",
      ["@class.outer"] = "<c-v>",
    },
    include_surrounding_whitespace = true,
  },
})

vim.keymap.set({ "x", "o" }, "af", function() ts_select.select_textobject("@function.outer", "textobjects") end)
vim.keymap.set({ "x", "o" }, "if", function() ts_select.select_textobject("@function.inner", "textobjects") end)
vim.keymap.set({ "x", "o" }, "ac", function() ts_select.select_textobject("@class.outer", "textobjects") end)
vim.keymap.set({ "x", "o" }, "ic", function() ts_select.select_textobject("@class.inner", "textobjects") end)
