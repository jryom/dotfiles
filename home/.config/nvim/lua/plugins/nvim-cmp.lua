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
    "onsails/lspkind.nvim",
    "rafamadriz/friendly-snippets",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    vim.opt.completeopt = { "menu", "menuone", "noselect" }

    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")
    lspkind.init({ preset = "codicons" })

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

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      experimental = {
        ghost_text = {
          hl_group = "LspCodeLens",
        },
      },
      sources = {
        { name = "nvim_lsp_signature_help" },
        { name = "copilot" },
        { name = "luasnip", keyword_length = 2 },
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
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
          local strings = vim.split(kind.kind, "%s", { trimempty = true })
          kind.kind = " " .. (strings[1] or "") .. " "
          kind.menu = "    (" .. (strings[2] or "") .. ")"

          return kind
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["K"] = cmp.mapping.scroll_docs(-4),
        ["J"] = cmp.mapping.scroll_docs(4),
        ["<C-l>"] = function()
          if luasnip.expand_or_jumpable() and not cmp.visible() then
            luasnip.expand_or_jump()
          else
            cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })()
          end
        end,
        ["<C-p>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-n>"] = cmp.mapping(function(fallback)
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-j>"] = function()
          if cmp.visible() then
            cmp.select_next_item()
          else
            cmp.complete({
              config = {
                sources = {
                  { name = "nvim_lsp_signature_help" },
                  { name = "nvim_lsp" },
                  { name = "nvim_lua" },
                  { name = "luasnip", keyword_length = 2 },
                  { name = "path" },
                  { name = "buffer" },
                },
              },
            })
          end
        end,
        ["<C-k>"] = function()
          if cmp.visible() then
            cmp.select_prev_item()
          else
            cmp.complete()
          end
        end,
      }),
    })
  end,
}
