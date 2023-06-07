return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  config = function()
    local history_dir = vim.fn.expand("~/.local/share/nvim")

    local winopts_fn = function(width, height)
      local cols = vim.o.columns
      local lines = vim.o.lines

      return {
        col = cols > width and (cols - width) / 2 or 0,
        height = height,
        rows = lines > height and (lines - height) / 2 or 0,
        width = width,
      }
    end

    require("fzf-lua").setup({
      winopts = {
        hl = {
          border = "FloatBorder",
          scrollborder_f = "NonText",
        },
        preview = { delay = 0 },
      },
      winopts_fn = function()
        return winopts_fn(220, 30)
      end,
      fzf_opts = {
        ["--info"] = "hidden",
      },
      keymap = {
        builtin = {
          ["shift-K"] = "preview-page-up",
          ["shift-J"] = "preview-page-down",
        },
      },
      files = {
        winopts_fn = function()
          return winopts_fn(80, 15)
        end,
        previewer = false,
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
        prompt = "Search ",
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
      blines = {
        prompt = "Lines ",
        previewer = false,
        winopts = {
          split = "belowright new | resize 10",
        },
      },
    })
  end,
}
