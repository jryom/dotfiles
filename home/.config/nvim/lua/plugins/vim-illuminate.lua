return {
  "rrethy/vim-illuminate",
  event = "VeryLazy",
  config = function()
    local illuminate = require("illuminate")
    local map = require("which-key").register

    illuminate.configure({
      delay = 100,
      filetype_overrides = {},
      filetypes_denylist = {
        "DressingSelect",
        "NvimTree",
        "Trouble",
        "fugitive",
        "lazy",
        "lir",
        "terminal",
      },
      min_count_to_highlight = 2,
    })

    map({
      ["<C-k>"] = { illuminate.goto_prev_reference, "Previous reference", mode = "n" },
      ["<C-j>"] = { illuminate.goto_next_reference, "Next reference", mode = "n" },
    })
  end,
}
