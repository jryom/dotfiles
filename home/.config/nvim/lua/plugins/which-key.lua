return {
  "folke/which-key.nvim",
  config = function()
    local wk = require("which-key")
    local map = wk.register

    vim.o.timeout = true
    vim.o.timeoutlen = 300

    wk.setup({
      window = {
        winblend = 10,
      },
      layout = {
        height = { min = 4, max = 25 },
        width = { min = 20, max = 50 },
        spacing = 0,
      },
      show_help = false,
      show_keys = false, -- show the currently pressed key and its label as a message in the command line
    })

    map({
      name = "Various mappings",
      C = { { '"_C', "", mode = "x" }, { '"_C', "", mode = "n" } },
      c = { { '"_c', "", mode = "x" }, { '"_c', "", mode = "n" } },
      gt = { "<C-]>", "Go to tag" },
      j = { "v:count == 0 ? 'gj' : '<Esc>'.v:count.'j'", "Next visual line", expr = true },
      k = { "v:count == 0 ? 'gk' : '<Esc>'.v:count.'k'", "Previous visual line", expr = true },
      p = { "pgvy", "Paste and yank content", mode = "x" },
      ["<esc>"] = { "<cmd>nohlsearch<cr>", "Disable search highlight" },
      [">"] = { ">gv", "Indent", mode = "x" },
      ["<"] = { "<gv", "Outdent", mode = "x" },
      ["-"] = { "<cmd>execute 'e ' .. expand('%:p:h')<CR>", "NvimTree" },
      ["<space>"] = {
        ["<space>"] = { "<cmd>update<cr>", "Update file" },
        L = { "<cmd>Lazy<cr>", "Lazy" },
        u = { "<cmd>UndotreeToggle<cr>", "Undotree" },
        s = {
          { "<cmd>lua require('spectre').open_visual({select_word = true})<CR>", "Spectre", mode = "n" },
          {
            '"vy :lua require("spectre").open({ is_insert_mode=false,search_text=vim.fn.getreg("v") })<CR>',
            "Spectre",
            mode = "x",
          },
        },
      },
    })

    map({
      name = "Close buffers",
      Q = {
        a = { "<cmd>Bdelete all<cr>", "Delete all buffers" },
        h = { "<cmd>Bdelete hidden<cr>", "Delete hidden buffers" },
        o = { "<cmd>Bdelete other<cr>", "Delete other buffers" },
        t = { "<cmd>Bdelete this<cr>", "Delete this buffer" },
      },
    })

    map({
      name = "Tabs",
      ["<C-t>"] = {
        h = { "<cmd>tabprev<cr>", "Previous tab" },
        l = { "<cmd>tabnext<cr>", "Next tab" },
        n = { "<cmd>tabnew<cr>", "New tab" },
        c = { "<cmd>tabclose<cr>", "Close tab" },
        H = { "<cmd>-tabmove<cr>", "Move tab left" },
        L = { "<cmd>tabmove<cr>", "Move tab right" },
      },
    })

    map({
      ["s"] = { "<cmd>HopChar1<cr>", "Hop word" },
      ["gw"] = { "<cmd>HopWord<cr>", "Hop word" },
    })

    map({
      ["<space>g"] = {
        name = "Git",
        h = { "<cmd>DiffviewFileHistory %<cr>", "View current file history" },
        d = { "<cmd>DiffviewOpen<cr>", "Open diffview" },
      },
    })

    map({
      name = "FZF",
      ["<space>"] = {
        b = { "<cmd>FzfLua buffers<cr>", "Buffers" },
        f = { "<cmd>FzfLua blines<cr>", "Search in file" },
        H = { "<cmd>FzfLua help_tags<cr>", "Help" },
        i = {
          {
            function()
              require("fzf-lua").grep({ search = "", fzf_opts = { ["--nth"] = "2..", ["--delimiter"] = ":" } })
            end,
            "Search in project",
            mode = "n",
          },
          { '"vy :FzfLua grep_visual <C-R>v<cr>', "Search selection in project", mode = "x" },
        },
        o = { "<cmd>FzfLua files<cr>", "Open file" },
      },
    })

    map({
      ["<space>d"] = {
        name = "Debugger",
        B = { "<Plug>VimspectorBreakpoints", "Breakpoints" },
        O = { "<Plug>VimspectorStepOut", "Step out" },
        b = { "<Plug>VimspectorToggleBreakpoint", "Toggle breakpoint" },
        c = { "<Plug>VimspectorContinue", "Continue" },
        f = { "<Plug>VimspectorAddFunctionBreakpoint", "Function breakpoint" },
        h = { "<Plug>VimspectorPause", "Pause" },
        i = { "<Plug>VimspectorStepInto", "Step into" },
        n = { "<Plug>VimspectorJumpToNextBreakpoint", "Next breakpoint" },
        o = { "<Plug>VimspectorStepOver", "Step over" },
        p = { "<Plug>VimspectorJumpToPreviousBreakpoint", "Previous breakpoint" },
        r = { "<Plug>VimspectorRestart", "Restart" },
        s = { "<Plug>VimspectorStop", "Stop" },
      },
    })
  end,
}
