return require("packer").startup(function()
  use("airblade/vim-rooter")
  use("asheq/close-buffers.vim")
  use("bronson/vim-visual-star-search")
  use("f-person/git-blame.nvim")
  use("honza/vim-snippets")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-vsnip")
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/vim-vsnip")
  use("junegunn/vim-easy-align")
  use("lukas-reineke/indent-blankline.nvim")
  use("neovim/nvim-lspconfig")
  use("phaazon/hop.nvim")
  use("rktjmp/lush.nvim")
  use("romainl/vim-qf")
  use("sheerun/vim-polyglot")
  use("simnalamburt/vim-mundo")
  use("szw/vim-maximizer")
  use("tpope/vim-commentary")
  use("tpope/vim-fugitive")
  use("tpope/vim-obsession")
  use("tpope/vim-repeat")
  use("tpope/vim-rhubarb")
  use("tpope/vim-surround")
  use("tpope/vim-unimpaired")
  use("tpope/vim-vinegar")
  use("wbthomason/packer.nvim")

  use({
    "mcchrish/zenbones.nvim",
    config = function()
      vim.g.zenbones_dim_noncurrent_window = true
      vim.g.zenflesh_darkness = "warm"
      vim.g.zenflesh_lighten_noncurrent_window = true
      vim.cmd(isDarkMode and "colo zenflesh-lush" or "color zenbones-lush")
    end,
  })

  use({
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "▍" },
          change = { text = "▍" },
          delete = { text = "▁" },
          topdelete = { text = "▔" },
          changedelete = { text = "~" },
        },
      })
    end,
  })

  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && yarn install",
    cmd = "MarkdownPreview",
  })

  use({
    "jose-elias-alvarez/null-ls.nvim",
    requires = { { "nvim-lua/plenary.nvim" } },
  })

  use({ "RRethy/vim-hexokinase", run = "make hexokinase" })

  function _G.getLualineOpts(isDarkMode)
    return {
      options = {
        theme = isDarkMode == "dark" and "zenflesh" or "zenbones",
        section_separators = "",
        component_separators = "",
      },
      sections = {
        lualine_x = { "filetype" },
        lualine_y = {
          {
            "diagnostics",
            sources = { "nvim_lsp" },
            symbols = { error = "E: ", warn = "W: ", info = "I: ", hint = "H: " },
            sections = { "error", "warn" },
          },
        },
        lualine_z = { "location" },
      },
    }
  end

  use({
    "hoob3rt/lualine.nvim",
    config = function()
      require("lualine").setup(
        getLualineOpts(
          string.match(vim.fn.system("defaults read -g AppleInterfaceStyle"), "Dark") == "Dark"
        )
      )
    end,
  })

  use({
    "cormacrelf/dark-notify",
    config = function()
      require("dark_notify").run({
        onchange = function(mode)
          if vim.g.colors_name == nil then
            vim.cmd(mode == "dark" and "colo zenflesh-lush" or "color zenbones-lush")
            require("plenary.reload").reload_module("lualine", true)
            require("lualine").setup(getLualineOpts(mode))
          end
        end,
      })
    end,
  })

  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/plenary.nvim" } },
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = require("telescope.actions").close,
            },
          },
        },
      })
    end,
  })

  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        autopairs = { enable = true },
        ensure_installed = "maintained",
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  })

  use({
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  })
end)
