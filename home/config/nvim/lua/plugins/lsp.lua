return {
  "junnplus/lsp-setup.nvim",
  dependencies = {
    "lukas-reineke/lsp-format.nvim",
    "neovim/nvim-lspconfig",
    "pmizio/typescript-tools.nvim",
    {
      "rrethy/vim-illuminate",
      event = "VeryLazy",
      config = function()
        require("illuminate").configure({ providers = { "lsp" }, min_count_to_highlight = 2 })
      end,
    },
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
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    local on_attach = function(client, bufnr)
      if client.name == "typescript-tools" then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end

      if client.name == "eslint" then
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
        client.server_capabilities.documentFormattingProvider = true
        client.server_capabilities.documentRangeFormattingProvider = true
      end

      require("lsp-format").on_attach(client)

      require("which-key").register({
        buffer = bufnr,
        ["<space>"] = {
          r = { vim.lsp.buf.rename, "Rename word" },
          l = {
            name = "LSP",
            a = { vim.lsp.buf.code_action, "Actions" },
            q = { vim.diagnostic.setloclist, "Diagnostics to quickfix" },
            d = { ":FzfLua lsp_definitions<cr>", "Definition" },
            D = { vim.lsp.buf.declaration, "Declaration" },
            h = {
              function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
              end,
              "Toggle inlay hints",
            },
            i = { ":FzfLua lsp_implementations<cr>", "Implementation" },
            r = { ":FzfLua lsp_references<cr>", "References" },
            t = { ":FzfLua lsp_typedefs<cr>", "Type definition" },
            s = { ":FzfLua lsp_document_symbols<cr>", "Document symbols" },
            w = { ":FzfLua lsp_workspace_symbols<cr>", "Workspace symbols" },
            I = { ":LspInfo<cr>", "Info" },
            L = { ":LspLog<cr>", "Log" },
            S = { ":LspStop<cr>", "Stop" },
            R = { ":LspRestart<cr>", "Restart" },
          },
        },
      })
    end

    require("typescript-tools").setup({
      on_attach = on_attach,
      settings = {
        expose_as_code_actions = "all",
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
        },
      },
    })

    return {
      capabilities = capabilities,
      default_mappings = false,
      on_attach = on_attach,
      servers = {
        ansiblels = {},
        bashls = {},
        cssls = {},
        dockerls = {},
        docker_compose_language_service = {},
        eslint = {},
        gopls = {},
        graphql = { filetypes = { "graphql", "typescriptreact", "javascriptreact", "typescript" } },
        html = {},
        pyright = {},
        -- taplo = {} -- https://github.com/tamasfe/taplo/issues/431,
        terraformls = {},
        yamlls = {},
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
      },
    }
  end,
}
