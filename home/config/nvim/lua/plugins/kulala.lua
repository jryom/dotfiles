return {
  "mistweaverco/kulala.nvim",
  keys = {
    { "<space>Rs", desc = "Send request" },
    { "<space>Ra", desc = "Send all requests" },
    { "<space>Rb", desc = "Open scratchpad" },
  },
  ft = { "http", "rest" },
  opts = {
    global_keymaps = true,
    global_keymaps_prefix = "<space>R",
    kulala_keymaps_prefix = "",
  },
}
