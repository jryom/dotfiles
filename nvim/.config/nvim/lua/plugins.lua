return require("packer").startup(function()
  use({
    "airblade/vim-rooter",
    "jose-elias-alvarez/null-ls.nvim",
    "neovim/nvim-lspconfig",
    "nvim-lua/plenary.nvim",
    "rktjmp/lush.nvim",
    "sheerun/vim-polyglot",
    "tpope/vim-unimpaired",
    "tpope/vim-vinegar",
    "wbthomason/packer.nvim",

    require("configs.cmp"),
    require("configs.telescope"),
    require("configs.theme"),
    require("configs.treesitter"),

    { "asheq/close-buffers.vim", cmd = "Bdelete" },
    { "bronson/vim-visual-star-search", keys = "*" },
    { "f-person/git-blame.nvim", event = "CursorHold" },
    { "junegunn/vim-easy-align", keys = { "<Plug>(EasyAlign)" } },
    { "lukas-reineke/indent-blankline.nvim", event = "CursorHold" },
    { "phaazon/hop.nvim", cmd = { "HopWord", "HopLineStart" } },
    { "romainl/vim-qf", cmd = "qf_qf_toggle" },
    { "rrethy/vim-hexokinase", run = "make hexokinase", event = "CursorHold" },
    { "simnalamburt/vim-mundo", cmd = "MundoToggle" },
    { "szw/vim-maximizer", cmd = "MaximizerToggle" },
    { "tpope/vim-commentary", keys = "gc" },
    { "tpope/vim-fugitive", event = "CursorHold" },
    { "tpope/vim-obsession", cmd = "Obsession", event = "SessionLoadPost" },
    { "tpope/vim-repeat", event = "CursorHold" },
    { "tpope/vim-rhubarb", cmd = "GBrowse" },
    { "tpope/vim-surround", event = "CursorHold" },

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
  })
end)
