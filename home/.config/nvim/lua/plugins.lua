require("packer").startup({
  function(use)
    use({
      { "airblade/vim-rooter", config = function() vim.g.rooter_silent_chdir = 1 end },
      { "asheq/close-buffers.vim" },
      { "cormacrelf/dark-notify", config = function() require("dark_notify").run() end },
      { "honza/vim-snippets" },
      { "https://gitlab.com/yorickpeterse/nvim-pqf.git", config = function() require("pqf").setup() end },
      { "ibhagwan/fzf-lua", config = require("plugin-configs.fzf") },
      { "joosepalviste/nvim-ts-context-commentstring" },
      { "junegunn/vim-easy-align" },
      { "lewis6991/gitsigns.nvim", config = require("plugin-configs.gitsigns") },
      { "lukas-reineke/indent-blankline.nvim", config = require("plugin-configs.indent-blankline") },
      { "mbbill/undotree" },
      { "mcauleypenney/tidy.nvim" },
      { "mcchrish/zenbones.nvim", config = require("plugin-configs.zenbones") },
      { "neoclide/coc.nvim", branch = "release", config = require("plugin-configs.coc") },
      { "nvim-lualine/lualine.nvim", config = require("plugin-configs.lualine") },
      { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = require("plugin-configs.treesitter") },
      { "rmagatti/auto-session", config = function() require("auto-session").setup({ log_level = "error" }) end },
      { "romainl/vim-qf" },
      { "sheerun/vim-polyglot" },
      { "tpope/vim-commentary" },
      { "tpope/vim-fugitive" },
      { "tpope/vim-repeat" },
      { "tpope/vim-rhubarb" },
      { "tpope/vim-surround" },
      { "tpope/vim-unimpaired" },
      { "tpope/vim-vinegar" },
      { "wbthomason/packer.nvim" },
      { "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup() end },
      { "windwp/nvim-ts-autotag" },
    })
  end,
})
