return require("packer").startup({
  function()
    use({
      "jose-elias-alvarez/null-ls.nvim",
      "lewis6991/impatient.nvim",
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
      "tpope/vim-commentary",
      "tpope/vim-sleuth",
      "tpope/vim-surround",
      "tpope/vim-unimpaired",
      "tpope/vim-vinegar",
      "wbthomason/packer.nvim",

      require("configs.cmp"),
      require("configs.telescope"),
      require("configs.theme"),
      require("configs.treesitter"),

      { "asheq/close-buffers.vim", cmd = "Bdelete" },
      { "bronson/vim-visual-star-search", keys = "*" },
      { "junegunn/vim-easy-align", keys = { "<Plug>(EasyAlign)" } },
      { "phaazon/hop.nvim", cmd = { "HopWord", "HopLineStart" } },
      { "romainl/vim-qf", cmd = "qf_qf_toggle" },
      { "simnalamburt/vim-mundo", cmd = "MundoToggle" },
      { "szw/vim-maximizer", cmd = "MaximizerToggle" },
      { "tpope/vim-fugitive", event = "CursorHold" },
      { "tpope/vim-repeat", event = "CursorHold" },
      { "tpope/vim-rhubarb", cmd = "GBrowse" },
      { "windwp/nvim-ts-autotag", event = "CursorHold" },

      {
        "rmagatti/auto-session",
        config = function()
          require("auto-session").setup({
            log_level = "error",
          })
        end,
      },

      {
        "airblade/vim-rooter",
        config = function()
          vim.g.rooter_silent_chdir = 1
        end,
      },

      {
        "f-person/git-blame.nvim",
        event = "CursorHold",
        config = function()
          vim.g.gitblame_date_format = "%r"
        end,
      },

      {
        "rrethy/vim-hexokinase",
        run = "make hexokinase",
        event = "CursorHold",
        config = function()
          vim.g.Hexokinase_optInPatterns = "full_hex,rgb,rgba,hsl,hsla"
          vim.g.Hexokinase_virtualText = "▮"
        end,
      },

      {
        "lukas-reineke/indent-blankline.nvim",
        event = "CursorHold",
        config = function()
          vim.g.indent_blankline_char = "▏"
          vim.g.indent_blankline_filetype_exclude = { "help", "markdown" }
          vim.g.indent_blankline_show_trailing_blankline_indent = false
          vim.g.indent_blankline_use_treesitter = true
        end,
      },

      {
        "tversteeg/registers.nvim",
        event = "InsertEnter",
        keys = '"',
        config = function()
          vim.g.registers_window_border = "single"
          vim.g.registers_window_max_width = 150
        end,
      },

      {
        "iamcco/markdown-preview.nvim",
        run = "cd app && yarn install",
        cmd = "MarkdownPreview",
      },

      {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
          require("nvim-autopairs").setup()
        end,
      },

      {
        "lewis6991/gitsigns.nvim",
        config = function()
          require("gitsigns").setup({
            signs = {
              add = { text = "▍" },
              change = { text = "▍" },
              delete = { text = "▁" },
              topdelete = { text = "▔" },
            },
          })
        end,
      },

      {
        "folke/trouble.nvim",
        cmd = { "Trouble", "TroubleToggle" },
        config = function()
          require("trouble").setup({
            fold_open = "v",
            fold_closed = ">",
            indent_lines = false,
            signs = {
              error = "error",
              warning = "warn",
            },
            use_lsp_diagnostic_signs = false,
          })
        end,
      },
    })
  end,
  config = {
    compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
  },
})
