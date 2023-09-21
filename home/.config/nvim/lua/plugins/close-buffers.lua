return {
  "asheq/close-buffers.vim",
  keys = {
    { "Qa", ":Bdelete all<cr>", desc = "Delete all buffers", silent = true },
    { "Qh", ":Bdelete hidden<cr>", desc = "Delete hidden buffers", silent = true },
    { "Qo", ":Bdelete other<cr>", desc = "Delete other buffers", silent = true },
    { "Qt", ":Bdelete this<cr>", desc = "Delete this buffer", silent = true },
  },
}
