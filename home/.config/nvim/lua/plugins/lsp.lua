return {
  "neovim/nvim-lspconfig",
  event = "BufReadPost",
  dependencies = {
    "creativenull/efmls-configs-nvim",
    "hoffs/omnisharp-extended-lsp.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "lukas-reineke/lsp-format.nvim",
    "nvim-lua/plenary.nvim",
    "pmizio/typescript-tools.nvim",
  },
  config = function()
    vim.diagnostic.config({
      float = { source = true },
      severity_sort = true,
      virtual_text = false,
    })

    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local lsp = require("lspconfig")
    local lspformat = require("lsp-format")
    local map = require("which-key").register
    local json_schemas = require("schemastore").json.schemas({})

    lspformat.setup({ sync = true })

    local on_attach = function(client, bufnr)
      lspformat.on_attach(client)

      if client.name == "eslint" then
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
      end

      map({
        buffer = bufnr,
        K = { vim.lsp.buf.hover, "Show docs" },
        ["<space>"] = {
          p = { vim.diagnostic.goto_prev, "Previous diagnostic" },
          n = { vim.diagnostic.goto_next, "Next diagnostic" },
          r = {
            { vim.lsp.buf.rename, "Rename word", mode = "n" },
            { '"sy:%s/<C-r>s//c <Left><Left><Left>', "Replace selection", mode = "x" },
          },
          q = {
            ":TroubleToggle workspace_diagnostics<cr>",
            "Diagnostics",
          },
          l = {
            name = "LSP",
            a = { vim.lsp.buf.code_action, "Code action" },
            q = { vim.diagnostic.setloclist, "Send diagnostics to quickfix" },
            d = { ":TroubleToggle lsp_definitions<cr>", "Go to definition" },
            D = { vim.lsp.buf.declaration, "Go to declaration" },
            i = { ":TroubleToggle lsp_implementations<cr>", "Go to implementation" },
            f = {
              {
                mode = "n",
                function()
                  vim.lsp.buf.format({ async = true })
                end,
                "Format buffer",
              },
            },
            r = { ":TroubleToggle lsp_references<cr>", "References" },
            t = { ":TroubleToggle lsp_type_definitions<cr>", "Go to type definition" },
            I = { ":LspInfo<cr>", "Info" },
            L = { ":LspLog<cr>", "Log" },
            S = { ":LspStop<cr>", "Stop" },
            R = { ":LspRestart<cr>", "Restart" },
          },
        },
      })
    end

    local default_config = { capabilities = capabilities, on_attach = on_attach }

    lsp.cssls.setup(default_config)
    lsp.eslint.setup(default_config)
    lsp.gopls.setup(default_config)
    lsp.html.setup(default_config)
    lsp.pyright.setup(default_config)
    lsp.rust_analyzer.setup(default_config)
    lsp.taplo.setup(default_config)
    lsp.yamlls.setup(default_config)

    local function extend_config(extension)
      return vim.tbl_deep_extend("force", default_config, extension)
    end

    lsp.graphql.setup(extend_config({ filetypes = { "graphql", "typescriptreact", "javascriptreact", "typescript" } }))

    local prettier = require("efmls-configs.formatters.prettier_d")
    local shfmt = require("efmls-configs.formatters.shfmt")
    local shellcheck = require("efmls-configs.linters.shellcheck")
    lsp.efm.setup(extend_config({
      init_options = { documentFormatting = true },
      settings = {
        languages = {
          bash = { shellcheck },
          cs = { { formatCommand = "dotnet dotnet-csharpier", formatStdin = true } },
          fish = { require("efmls-configs.formatters.fish_indent"), shfmt },
          go = { require("efmls-configs.formatters.gofmt"), require("efmls-configs.formatters.goimports") },
          grahql = { prettier },
          html = { prettier },
          javascript = { prettier },
          javascriptreact = { prettier },
          json = { prettier },
          lua = { require("efmls-configs.formatters.stylua") },
          markdown = { prettier },
          sh = { shellcheck, shfmt },
          typescript = { prettier },
          typescriptreact = { prettier },
          yaml = { prettier, require("efmls-configs.linters.actionlint") },
        },
      },
    }))

    require("typescript-tools").setup(extend_config({
      settings = {
        expose_as_code_action = "all",
        tsserver_plugins = {},
        tsserver_format_options = {},
        tsserver_file_preferences = {},
        complete_function_calls = false,
      },
    }))

    lsp.lua_ls.setup(extend_config({
      settings = {
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
    }))

    local yaml_schemas = {}
    vim.tbl_map(function(schema)
      yaml_schemas[schema.url] = schema.fileMatch
    end, json_schemas)

    lsp.jsonls.setup(extend_config({
      init_options = {
        provideFormatter = false,
      },
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
      },
    }))

    lsp.omnisharp.setup(extend_config({
      cmd = {
        "dotnet",
        vim.fn.expand("~/.omnisharp/omnisharp-osx-arm64-net6.0/OmniSharp.dll"),
        "--languageserver",
        "--hostPID",
        tostring(vim.fn.getpid()),
      },
      handlers = {
        ["textDocument/definition"] = require("omnisharp_extended").handler,
      },
      on_init = function(client)
        if client.server_capabilities then
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.semanticTokensProvider = false
        end
      end,
    }))
  end,
}
