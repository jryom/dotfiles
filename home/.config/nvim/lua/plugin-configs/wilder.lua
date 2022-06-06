return function()
  local wilder = require("wilder")

  wilder.setup({
    modes = { ":", "/", "?" },
    next_key = "<C-j>",
    previous_key = "<C-k>",
    accept_key = "<C-l>",
    reject_key = "<C-c>",
  })

  wilder.set_option("use_python_remote_plugin", 0)

  wilder.set_option("pipeline", {
    wilder.branch(
      wilder.cmdline_pipeline({
        fuzzy = 1,
        fuzzy_filter = wilder.lua_fzy_filter(),
      }),
      wilder.vim_search_pipeline()
    ),
  })

  wilder.set_option(
    "renderer",
    wilder.renderer_mux({
      [":"] = wilder.popupmenu_renderer({
        highlighter = wilder.lua_fzy_highlighter(),
        highlights = {
          accent = wilder.make_hl("WilderAccent", "Search"),
        },
        left = {
          " ",
        },
        right = {
          " ",
          wilder.popupmenu_scrollbar(),
        },
      }),
      ["/"] = wilder.wildmenu_renderer({
        highlighter = wilder.lua_fzy_highlighter(),
      }),
    })
  )
end
