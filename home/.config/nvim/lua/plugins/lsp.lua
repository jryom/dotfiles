return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "jose-elias-alvarez/null-ls.nvim",
    "lukas-reineke/lsp-format.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    vim.diagnostic.config({
      float = { source = true },
      severity_sort = true,
      virtual_text = false,
    })

    local additional_server_filetypes = {
      graphql = {
        "typescript",
      },
    }

    local servers = {
      "cssls",
      "eslint",
      "graphql",
      "html",
      "jsonls",
      "lua_ls",
      "pyright",
      "taplo",
      "tsserver",
      "yamlls",
    }

    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local lspconfig = require("lspconfig")
    local lspformat = require("lsp-format")
    local map = require("which-key").register
    local null_ls = require("null-ls")
    local json_schemas = require("schemastore").json.schemas({})

    lspformat.setup({ sync = true })

    local signs = { Error = "𝐞", Warn = "𝐰", Hint = "𝐡", Info = "𝐢" }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    local on_attach = function(client, bufnr)
      if client.name ~= "tsserver" then
        lspformat.on_attach(client)
      end

      if client.name == "eslint" then
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
      end

      map({
        buffer = bufnr,
        name = "LSP",
        K = { vim.lsp.buf.hover, "Show docs" },
        ["<space>"] = {
          p = { vim.diagnostic.goto_prev, "Previous diagnostic" },
          n = { vim.diagnostic.goto_next, "Next diagnostic" },
          r = {
            { vim.lsp.buf.rename, "Rename word", mode = "n" },
            { '"sy:%s/<C-r>s//c <Left><Left><Left>', "Replace selection", mode = "x" },
          },
          q = {
            "<cmd>TroubleToggle workspace_diagnostics<cr>",
            "Diagnostics",
          },
          l = {
            name = "LSP",
            a = { vim.lsp.buf.code_action, "Code action" },
            q = { vim.diagnostic.setloclist, "Send diagnostics to quickfix" },
            d = { "<cmd>TroubleToggle lsp_definitions<cr>", "Go to definition" },
            D = { vim.lsp.buf.declaration, "Go to declaration" },
            i = { "<cmd>TroubleToggle lsp_implementations<cr>", "Go to implementation" },
            f = {
              {
                mode = "n",
                function()
                  vim.lsp.buf.format({ async = true })
                end,
                "Format buffer",
              },
            },
            r = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
            t = { "<cmd>TroubleToggle lsp_type_definitions<cr>", "Go to type definition" },
          },
        },
      })
    end

    local yaml_schemas = {}
    vim.tbl_map(function(schema)
      yaml_schemas[schema.url] = schema.fileMatch
    end, json_schemas)

    local function get_default_filenames(server)
      if type(lspconfig[server]) == "table" then
        return lspconfig[server].document_config.default_config.filetypes
      end
    end

    for _, lsp in ipairs(servers) do
      local filetypes = get_default_filenames(lsp)
      for _, v in ipairs(additional_server_filetypes[lsp] or {}) do
        table.insert(filetypes, v)
      end

      lspconfig[lsp].setup({
        capabilities = capabilities,
        filetypes = filetypes,
        on_attach = on_attach,
        settings = {
          yaml = {
            format = {
              enable = true,
            },
            schemas = yaml_schemas,
          },
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            format = {
              enable = false,
            },
            diagnostics = {
              globals = {
                "vim",
              },
            },
          },
        },
      })
    end

    null_ls.setup({
      on_attach = on_attach,
      sources = {
        null_ls.builtins.code_actions.shellcheck,
        null_ls.builtins.diagnostics.actionlint,
        null_ls.builtins.diagnostics.commitlint,
        null_ls.builtins.diagnostics.dotenv_linter,
        null_ls.builtins.diagnostics.fish,
        null_ls.builtins.diagnostics.hadolint,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.diagnostics.stylelint,
        null_ls.builtins.diagnostics.tsc,
        null_ls.builtins.diagnostics.zsh,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.fish_indent,
        null_ls.builtins.formatting.just,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.stylelint,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.tidy,
        null_ls.builtins.formatting.trim_newlines,
        null_ls.builtins.formatting.trim_whitespace,
      },
    })
  end,
}
