return {
  "junnplus/lsp-setup.nvim",
  dependencies = {
    "creativenull/efmls-configs-nvim",
    -- "hoffs/omnisharp-extended-lsp.nvim",
    "lukas-reineke/lsp-format.nvim",
    "neovim/nvim-lspconfig",
    "pmizio/typescript-tools.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
  init = function()
    vim.diagnostic.config({
      float = { source = true },
      severity_sort = true,
      virtual_text = false,
    })
  end,
  opts = function()
    local prettier = require("efmls-configs.formatters.prettier")
    local shellcheck = require("efmls-configs.linters.shellcheck")
    local shfmt = require("efmls-configs.formatters.shfmt")
    local lspformat = require("lsp-format")

    local on_attach = function(client, bufnr)
      if client.name == "typescript-tools" then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end

      if client.name == "eslint" then
        client.server_capabilities.documentFormattingProvider = true
        client.server_capabilities.documentRangeFormattingProvider = true
      end

      lspformat.on_attach(client)

      require("which-key").register({
        buffer = bufnr,
        K = { vim.lsp.buf.hover, "Show docs" },
        ["<space>"] = {
          p = { vim.diagnostic.goto_prev, "Previous diagnostic" },
          n = { vim.diagnostic.goto_next, "Next diagnostic" },
          r = { vim.lsp.buf.rename, "Rename word" },
          l = {
            name = "LSP",
            a = { vim.lsp.buf.code_action, "Actions" },
            q = { vim.diagnostic.setloclist, "Diagnostics to quickfix" },
            d = { ":TroubleToggle lsp_definitions<cr>", "Definition" },
            D = { vim.lsp.buf.declaration, "Declaration" },
            i = { ":TroubleToggle lsp_implementations<cr>", "Implementation" },
            f = { vim.lsp.buf.format, "Format" },
            r = { ":TroubleToggle lsp_references<cr>", "References" },
            t = { ":TroubleToggle lsp_type_definitions<cr>", "Type definition" },
            I = { ":LspInfo<cr>", "Info" },
            L = { ":LspLog<cr>", "Log" },
            S = { ":LspStop<cr>", "Stop" },
            R = { ":LspRestart<cr>", "Restart" },
          },
        },
      })
    end

    require("typescript-tools").setup({ on_attach = on_attach, settings = { expose_as_code_actions = "all" } })

    return {
      default_mappings = false,
      on_attach = on_attach,
      servers = {
        cssls = {},
        eslint = {},
        gopls = {},
        graphql = { filetypes = { "graphql", "typescriptreact", "javascriptreact", "typescript" } },
        html = {},
        pyright = {},
        taplo = {},
        yamlls = {},
        efm = {
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
              json5 = { prettier },
              jsonc = { prettier },
              json = { prettier },
              lua = { require("efmls-configs.formatters.stylua") },
              markdown = { prettier },
              sh = { shellcheck, shfmt },
              typescript = { prettier },
              typescriptreact = { prettier },
              yaml = { prettier, require("efmls-configs.linters.actionlint") },
            },
          },
        },
        jsonls = {
          init_options = { provideFormatter = false },
          settings = {
            yaml = {
              schemas = require("schemastore").yaml.schemas(),
              schemaStore = {
                enable = false,
                url = "",
              },
            },
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              format = { enable = false },
              diagnostics = { globals = { "vim" } },
            },
          },
        },
        --   omnisharp = {
        --     cmd = {
        --       "dotnet",
        --       vim.fn.expand("~/.omnisharp/omnisharp-osx-arm64-net6.0/OmniSharp.dll"),
        --       "--languageserver",
        --       "--hostPID",
        --       tostring(vim.fn.getpid()),
        --     },
        --     handlers = {
        --       ["textDocument/definition"] = require("omnisharp_extended").handler,
        --     },
        --     on_init = function(client)
        --       if client.server_capabilities then
        --         client.server_capabilities.documentFormattingProvider = false
        --         client.server_capabilities.semanticTokensProvider = false
        --       end
        --     end,
        --   },
      },
    }
  end,
}
