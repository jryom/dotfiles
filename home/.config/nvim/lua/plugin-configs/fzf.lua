return function()
  local actions = require("fzf-lua.actions")
  local history_dir = vim.fn.expand("~/.local/share/nvim")

  require("fzf-lua").setup({
    winopts = {
      hl = {
        border = "FloatBorder",
        scrollborder_f = "NonText",
      },
    },
    keymap = {
      builtin = {
        ["K"] = "preview-page-up",
        ["J"] = "preview-page-down",
      },
    },
    files = {
      fzf_opts = {
        ["--history"] = history_dir .. "/" .. "fzf_files_history",
        ["--scheme"] = "path",
      },
      file_icons = false,
      prompt = "Files ",
    },
    grep = {
      fzf_opts = {
        ["--history"] = history_dir .. "/" .. "fzf_grep_history",
      },
      file_icons = false,
      no_header = true,
      prompt = "Grep ",
    },
    git = {
      icons = {
        ["M"] = { icon = "𝒎" },
        ["D"] = { icon = "𝒅" },
        ["A"] = { icon = "𝒂" },
        ["R"] = { icon = "𝒓" },
        ["C"] = { icon = "𝙘" },
        ["T"] = { icon = "𝙩" },
        ["?"] = { icon = "𝙪" },
      },
    },
    buffers = {
      prompt = "Buffers ",
      actions = {
        ["ctrl-d"] = { actions.buf_del, actions.resume },
      },
    },
  })
end
