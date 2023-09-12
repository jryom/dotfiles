return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "b0o/schemastore.nvim",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    "l3mon4d3/luasnip",
    "rafamadriz/friendly-snippets",
    "saadparwaiz1/cmp_luasnip",
    "windwp/nvim-autopairs",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })

    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

    cmp.setup({
      view = {
        name = "custom",
        selection_order = "near_cursor",
      },
      experimental = {
        ghost_text = {
          hl_group = "LspCodeLens",
        },
      },
      sources = {
        { name = "nvim_lsp_signature_help" },
        { name = "luasnip", keyword_length = 2 },
        { name = "copilot" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "path" },
        { name = "buffer" },
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-u>"] = cmp.mapping.scroll_docs(4),
        ["<C-l>"] = function()
          if luasnip.expand_or_jumpable() and not cmp.visible() then
            luasnip.expand_or_jump()
          else
            cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })()
          end
        end,
        ["<C-p>"] = function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end,
        ["<C-n>"] = function(fallback)
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end,
        ["<C-j>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_next_item()
          else
            cmp.complete()
          end
        end, { "i", "s", "c" }),
        ["<C-k>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_prev_item()
          else
            cmp.complete()
          end
        end, { "i", "s", "c" }),
      }),
    })
  end,
}
