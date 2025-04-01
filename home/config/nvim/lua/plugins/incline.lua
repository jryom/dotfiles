return {
  "b0o/incline.nvim",
  config = function()
    require("incline").setup({
      render = function(props)
        local max_length = math.floor(vim.api.nvim_win_get_width(0) * 0.4)
        local a = vim.api
        local bufname = a.nvim_buf_get_name(props.buf)
        local shortened_path = bufname ~= "" and vim.fn.fnamemodify(bufname, ":~:.") or "[No Name]"
        if #shortened_path > max_length then shortened_path = "..." .. shortened_path:sub(-1 * (max_length - 3)) end
        if a.nvim_get_option_value("modified", { buf = props.buf }) then shortened_path = shortened_path .. " [+]" end
        return shortened_path
      end,
      window = {
        overlap = { borders = true },
        zindex = 40,
      },
      hide = { cursorline = "focused_win" },
    })
  end,
  event = "VeryLazy",
}
