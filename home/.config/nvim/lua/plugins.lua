return require("packer").startup({
  function(use)
    use({

      "honza/vim-snippets",
      "joosepalviste/nvim-ts-context-commentstring",
      "lewis6991/impatient.nvim",
      "mcchrish/zenbones.nvim",
      "nathom/filetype.nvim",
      "nvim-lua/plenary.nvim",
      "romainl/vim-qf",
      "sheerun/vim-polyglot",
      "sindrets/diffview.nvim",
      "tpope/vim-commentary",
      "tpope/vim-obsession",
      "tpope/vim-rhubarb",
      "tpope/vim-surround",
      "tpope/vim-unimpaired",
      "tpope/vim-vinegar",
      "wbthomason/packer.nvim",

      { "asheq/close-buffers.vim", cmd = "Bdelete" },
      { "bronson/vim-visual-star-search", keys = "*" },
      { "junegunn/vim-easy-align", keys = { "<Plug>(EasyAlign)" } },
      { "simnalamburt/vim-mundo", cmd = "MundoToggle" },
      { "szw/vim-maximizer", cmd = "MaximizerToggle" },
      { "tpope/vim-fugitive", event = "CursorHold" },
      { "tpope/vim-repeat", event = "CursorHold" },
      { "windwp/nvim-ts-autotag", event = "CursorHold" },

      {
        "nvim-lualine/lualine.nvim",
        config = function()
          require("lualine").setup({
            options = {
              icons_enabled = false,
              section_separators = { left = "", right = "" },
              component_separators = { left = "|", right = "" },
              disabled_filetypes = {},
            },
            sections = {
              lualine_b = {
                "branch",
                "diff",
              },
              lualine_c = { { "filename", path = 1 } },
              lualine_x = { "g:coc_status" },
              lualine_y = { "filetype" },
              lualine_z = {
                "%l/%L:%-2.c",
                {
                  "diagnostics",
                  diagnostics_color = {
                    error = "DiagnosticVirtualTextError",
                    warn = "DiagnosticVirtualTextWarn",
                    info = "DiagnosticVirtualTextInfo",
                    hint = "DiagnosticVirtualTextHint",
                  },
                  symbols = { error = "", warn = "", info = "", hint = "" },
                },
              },
            },
          })
        end,
      },

      {
        "cormacrelf/dark-notify",
        event = "CursorHold",
        config = function()
          require("dark_notify").run()
        end,
      },

      {
        "phaazon/hop.nvim",
        cmd = { "HopWord", "HopLineStart", "HopChar2" },
        config = function()
          require("hop").setup()
        end,
      },

      {
        "airblade/vim-rooter",
        config = function()
          vim.g.rooter_silent_chdir = 1
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
          vim.g.indent_blankline_filetype_exclude = { "help", "markdown", "man" }
          vim.g.indent_blankline_show_trailing_blankline_indent = false
          vim.g.indent_blankline_use_treesitter = true
        end,
      },

      {
        "iamcco/markdown-preview.nvim",
        run = "cd app && yarn install",
      },

      {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
          require("nvim-autopairs").setup()
        end,
      },

      {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function()
          require("nvim-treesitter.configs").setup({
            autopairs = { enable = true },
            autotag = {
              enable = true,
            },
            context_commentstring = {
              enable = true,
            },
            ensure_installed = "all",
            ignore_install = { "phpdoc" },
            highlight = { enable = true },
            indent = { enable = true },
          })
        end,
      },

      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      {
        "nvim-telescope/telescope.nvim",
        config = function()
          local actions = require("telescope.actions")
          require("telescope").setup({
            defaults = {
              dynamic_preview_title = true,
              mappings = {
                i = {
                  ["<esc>"] = actions.close,
                  ["K"] = actions.preview_scrolling_up,
                  ["J"] = actions.preview_scrolling_down,
                  ["<C-n>"] = actions.cycle_history_next,
                  ["<C-p>"] = actions.cycle_history_prev,
                  ["<C-k>"] = actions.move_selection_previous,
                  ["<C-j>"] = actions.move_selection_next,
                },
              },
              prompt_prefix = "",
              layout_config = {
                scroll_speed = 2,
                preview_cutoff = 200,
              },
            },
            pickers = {
              find_files = {
                find_command = { "rg", "--files" },
                previewer = false,
                theme = "dropdown",
              },
              live_grep = {
                disable_coordinates = true,
                only_sort_text = true,
              },
              grep_string = {
                disable_coordinates = true,
              },
              buffers = {
                only_cwd = true,
                previewer = false,
                sort_mru = true,
                theme = "dropdown",
              },
            },
          })

          require("telescope").load_extension("fzf")
        end,
      },

      {
        "lewis6991/gitsigns.nvim",
        config = function()
          require("gitsigns").setup({
            current_line_blame = true,
            current_line_blame_opts = {
              delay = 100,
            },
            current_line_blame_formatter = function(name, blame_info, opts)
              if blame_info.author == name then
                blame_info.author = "You"
              end

              local text
              if blame_info.author == "Not Committed Yet" then
                text = blame_info.author
              else
                local date_time

                if opts.relative_time then
                  date_time = require("gitsigns.util").get_relative_time(
                    tonumber(blame_info["author_time"])
                  )
                else
                  date_time = os.date("%Y-%m-%d", tonumber(blame_info["author_time"]))
                end

                text = string.format(
                  "      %s | %s | %s",
                  blame_info.author,
                  date_time,
                  blame_info.summary
                )
              end

              return { { " " .. text, "GitSignsCurrentLineBlame" } }
            end,
            current_line_blame_formatter_opts = {
              relative_time = true,
            },
            signs = {
              add = { text = "+" },
              change = { text = "~" },
              delete = { text = "_" },
              topdelete = { text = "‾" },
            },
          })
        end,
      },

      {
        "neoclide/coc.nvim",
        branch = "release",
        config = function()
          vim.g.coc_global_extensions = {
            "coc-css",
            "coc-diagnostic",
            "coc-eslint",
            "coc-html",
            "coc-json",
            "coc-lua",
            "coc-prettier",
            "coc-pyright",
            "coc-snippets",
            "coc-solargraph",
            "coc-styled-components",
            "coc-stylelintplus",
            "coc-tsserver",
            "coc-yaml",
          }
        end,
      },
    })
  end,
})
