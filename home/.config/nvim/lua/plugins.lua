require("packer").startup({
  function(use)
    use({
      {
        "airblade/vim-rooter",
        config = function()
          vim.g.rooter_silent_chdir = 1
        end,
      },
      {
        "antoinemadec/fixcursorhold.nvim",
        config = function() vim.g.cursorhold_updatetime = 100 end,
      },
      { "asheq/close-buffers.vim", cmd = "Bdelete" },
      {
        "cormacrelf/dark-notify",
        event = "CursorHold",
        config = function()
          require("dark_notify").run()
        end,
      },
      {
        "https://gitlab.com/yorickpeterse/nvim-pqf",
        event = "QuickFixCmdPre",
        config = function()
          require("pqf").setup()
        end,
      },
      { "honza/vim-snippets" },
      {
        "iamcco/markdown-preview.nvim",
        run = "cd app && yarn install",
        config = require("plugin-configs.markdown-preview"),
      },
      { "gelguy/wilder.nvim", config = require("plugin-configs.wilder"), requires = "romgrk/fzy-lua-native" },
      { "ibhagwan/fzf-lua", config = require("plugin-configs.fzf"), cmd = "FzfLua" },
      { "joosepalviste/nvim-ts-context-commentstring", event = "CursorHold" },
      { "junegunn/vim-easy-align", keys = { "<Plug>(EasyAlign)" } },
      { "lewis6991/gitsigns.nvim", config = require("plugin-configs.gitsigns") },
      { "lewis6991/impatient.nvim" },
      { "lukas-reineke/indent-blankline.nvim", config = require("plugin-configs.indent-blankline") },
      { "mcauleypenney/tidy.nvim", event = "BufWritePre" },
      { "mcchrish/zenbones.nvim", config = require("plugin-configs.zenbones"), requires = "rktjmp/lush.nvim" },
      { "nathom/filetype.nvim" },
      { "neoclide/coc.nvim", branch = "release", config = require("plugin-configs.coc"), event = "CursorHold" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-lualine/lualine.nvim", config = require("plugin-configs.lualine") },
      { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = require("plugin-configs.treesitter") },
      {
        "rmagatti/auto-session",
        config = function()
          require("auto-session").setup({ log_level = "error" })
        end,
      },
      { "romainl/vim-qf", event = "CursorHold" },
      { "sheerun/vim-polyglot" },
      { "simnalamburt/vim-mundo", cmd = "MundoToggle" },
      { "sindrets/diffview.nvim", cmd = { "DiffviewOpen", "DiffviewFileHistory" } },
      { "sindrets/winshift.nvim", cmd = "WinShift" },
      { "sqve/sort.nvim", cmd = "Sort" },
      { "tpope/vim-commentary", event = "CursorHold" },
      { "tpope/vim-fugitive", event = "CursorHold" },
      { "tpope/vim-repeat", keys = { "." } },
      { "tpope/vim-rhubarb", event = "CursorHold" },
      { "tpope/vim-surround", event = "CursorHold" },
      { "tpope/vim-unimpaired", event = "CursorHold" },
      { "tpope/vim-vinegar", event = "CursorHold" },
      {
        "tversteeg/registers.nvim",
        keys = { '"' },
        event = "InsertEnter",
        config = function()
          vim.g.registers_delay = 500
        end,
      },
      { "wbthomason/packer.nvim" },
      {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
          require("nvim-autopairs").setup()
        end,
      },
      { "wellle/targets.vim", event = "CursorHold" },
      { "windwp/nvim-ts-autotag", event = "CursorHold" },
    })
  end,
})
