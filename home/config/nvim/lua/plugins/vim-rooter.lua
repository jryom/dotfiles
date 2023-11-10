return {
  "airblade/vim-rooter",
  command = "Rooter",
  init = function()
    vim.g.rooter_silent_chdir = 1
    vim.g.rooter_manual_only = 1
  end,
}
