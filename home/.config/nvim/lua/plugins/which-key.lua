return {
  "folke/which-key.nvim",
  event = "VeryLazy",
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
      C = { { '"_C', "", mode = "x" }, { '"_C', "", mode = "n" } },
      c = { { '"_c', "", mode = "x" }, { '"_c', "", mode = "n" } },
      gt = { "<C-]>", "Go to tag" },
      j = { "v:count == 0 ? 'gj' : '<Esc>'.v:count.'j'", "Next visual line", expr = true },
      k = { "v:count == 0 ? 'gk' : '<Esc>'.v:count.'k'", "Previous visual line", expr = true },
      p = { "pgvy", "Paste and yank content", mode = "x" },
      ["<esc>"] = { ":nohlsearch<cr>", "Disable search highlight" },
      [">"] = { ">gv", "Indent", mode = "x" },
      ["<"] = { "<gv", "Outdent", mode = "x" },
      ["-"] = { "<cmd>execute 'e ' .. expand('%:p:h')<CR>", "NvimTree" },
      ["<space>"] = {
        ["<space>"] = { ":update<cr>", "Update file" },
        L = { ":Lazy<cr>", "Lazy" },
        u = { ":UndotreeToggle<cr>", "Undotree" },
        s = {
          { ":lua require('spectre').open_visual({select_word = true})<CR>", "Spectre", mode = "n" },
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
        a = { ":Bdelete all<cr>", "Delete all buffers" },
        h = { ":Bdelete hidden<cr>", "Delete hidden buffers" },
        o = { ":Bdelete other<cr>", "Delete other buffers" },
        t = { ":Bdelete this<cr>", "Delete this buffer" },
      },
    })

    map({
      name = "Tabs",
      ["<C-t>"] = {
        h = { ":tabprev<cr>", "Previous tab" },
        l = { ":tabnext<cr>", "Next tab" },
        n = { ":tabnew<cr>", "New tab" },
        c = { ":tabclose<cr>", "Close tab" },
        H = { ":-tabmove<cr>", "Move tab left" },
        L = { ":tabmove<cr>", "Move tab right" },
      },
    })

    map({
    })

    map({
      ["<space>g"] = {
        name = "Git",
        n = { ":Gitsigns next_hunk<cr>", "Next hunk" },
        p = { ":Gitsigns prev_hunk<cr>", "Previous hunk" },
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
      ["<space>"] = {
        c = {
          name = "ChatGPT",
          c = { ":ChatGPT<CR>", "ChatGPT" },
          e = { ":ChatGPTEditWithInstruction<CR>", "Edit with instruction", mode = { "n", "v" } },
          g = { ":ChatGPTRun grammar_correction<CR>", "Grammar Correction", mode = { "n", "v" } },
          t = { ":ChatGPTRun translate<CR>", "Translate", mode = { "n", "v" } },
          k = { ":ChatGPTRun keywords<CR>", "Keywords", mode = { "n", "v" } },
          d = { ":ChatGPTRun docstring<CR>", "Docstring", mode = { "n", "v" } },
          a = { ":ChatGPTRun add_tests<CR>", "Add Tests", mode = { "n", "v" } },
          o = { ":ChatGPTRun optimize_code<CR>", "Optimize Code", mode = { "n", "v" } },
          s = { ":ChatGPTRun summarize<CR>", "Summarize", mode = { "n", "v" } },
          f = { ":ChatGPTRun fix_bugs<CR>", "Fix Bugs", mode = { "n", "v" } },
          x = { ":ChatGPTRun explain_code<CR>", "Explain Code", mode = { "n", "v" } },
          r = { ":ChatGPTRun roxygen_edit<CR>", "Roxygen Edit", mode = { "n", "v" } },
          l = { ":ChatGPTRun code_readability_analysis<CR>", "Code Readability Analysis", mode = { "n", "v" } },
        },
      },
    })
  end,
}
