return function()
  local actions = require("fzf-lua.actions")
  local history_dir = vim.fn.expand("~/.local/share/nvim")

  require("fzf-lua").setup({
    fzf_opts = {
      ["--history"] = history_dir .. "/" .. "fzf_history",
    },
    winopts = {
      height = 0.8,
      width = 0.8,
      row = 0.4,
      col = 0.5,
      preview = {
        wrap = "wrap",
        vertical = "down:0%",
        horizontal = "right:50%",
        flip_columns = 180,
        scrollchars = { "▌" },
        winopts = {
          number = false,
          cursorline = false,
        },
      },
    },
    keymap = {
      builtin = {
        ["K"] = "preview-page-up",
        ["J"] = "preview-page-down",
      },
    },
    files = {
      prompt = "Files ",
    },
    grep = {
      no_header = true,
      prompt = "Grep ",
    },
    buffers = {
      prompt = "Buffers ",
      actions = {
        ["ctrl-d"] = { actions.buf_del, actions.resume },
      },
    },
  })
end
