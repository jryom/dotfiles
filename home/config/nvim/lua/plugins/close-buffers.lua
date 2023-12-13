return {
  "asheq/close-buffers.vim",
  keys = {
    { "Qa", ":Bwipeout all<cr>", desc = "Delete all buffers", silent = true },
    { "Qh", ":Bwipeout hidden<cr>", desc = "Delete hidden buffers", silent = true },
    { "Qo", ":Bwipeout other<cr>", desc = "Delete other buffers", silent = true },
    { "Qt", ":Bwipeout this<cr>", desc = "Delete this buffer", silent = true },
  },
}
