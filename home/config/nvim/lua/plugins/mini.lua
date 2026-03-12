return {
  {
    "nvim-mini/mini.basics",
    event = "VeryLazy",
    key = { { "yo" } },
    opts = {},
  },
  {
    "nvim-mini/mini.bracketed",
    keys = {
      { "<left>", "[", mode = { "n", "x", "o" }, remap = true },
      { "<right>", "]", mode = { "n", "x", "o" }, remap = true },
    },
    opts = {},
  },
  {
    "nvim-mini/mini.surround",
    keys = {
      { "sa", mode = { "n", "x" }, desc = "Add surrounding" },
      { "sd", desc = "Delete surrounding" },
      { "sr", desc = "Replace surrounding" },
      { "sf", desc = "Find surrounding (right)" },
      { "sF", desc = "Find surrounding (left)" },
      { "sh", desc = "Highlight surrounding" },
      { "sn", desc = "Update neighbor lines" },
    },
    opts = {},
  },
  {
    "nvim-mini/mini.ai",
    keys = {
      { "a", mode = { "x", "o" } },
      { "i", mode = { "x", "o" } },
    },
    opts = {},
  },
  {
    "nvim-mini/mini.bufremove",
    keys = {
      { "Qt", function() MiniBufremove.wipeout(0) end, desc = "Delete this buffer" },
      { "Qa", function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_loaded(buf) then MiniBufremove.wipeout(buf) end
        end
      end, desc = "Delete all buffers" },
      { "Qh", function()
        local cur = vim.api.nvim_get_current_buf()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_loaded(buf) and buf ~= cur and vim.fn.bufwinid(buf) == -1 then
            MiniBufremove.wipeout(buf)
          end
        end
      end, desc = "Delete hidden buffers" },
      { "Qo", function()
        local cur = vim.api.nvim_get_current_buf()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_loaded(buf) and buf ~= cur then MiniBufremove.wipeout(buf) end
        end
      end, desc = "Delete other buffers" },
    },
    opts = {},
  },
}
