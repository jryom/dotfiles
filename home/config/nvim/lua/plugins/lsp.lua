return {
  "junnplus/lsp-setup.nvim",
  dependencies = {
    "lukas-reineke/lsp-format.nvim",
    "neovim/nvim-lspconfig",
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
        gn = {
          function()
            require("illuminate").goto_next_reference(true)
          end,
          "Goto next reference",
        },
        gN = {
          function()
            require("illuminate").goto_prev_reference(true)
          end,
          "Goto previous reference",
        },
        ["<space>"] = {
          r = { vim.lsp.buf.rename, "Rename word" },
          l = {
            name = "LSP",
            a = { vim.lsp.buf.code_action, "Actions" },
            q = { vim.diagnostic.setloclist, "Diagnostics to quickfix" },
            h = {
              function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
              end,
              "Toggle inlay hints",
            },
            i = { ":Trouble lsp_implementations toggle<cr>", "Implementation" },
            r = { ":Trouble lsp_references toggle<cr>", "References" },
            t = { ":Trouble lsp_type_definitions toggle<cr>", "Type definition" },
            s = { ":Trouble lsp_document_symbols toggle win.position=right<cr>", "Document symbols" },
            d = { ":Trouble lsp_definitions toggle<cr>", "Definitions" },
            c = { ":Trouble lsp_declarations toggle<cr>", "Declarations" },
            n = { ":Trouble lsp_incoming_calls toggle<cr>", "Incoming calls" },
            o = { ":Trouble lsp_outgoing_calls toggle<cr>", "Outgoing calls" },
            l = { ":Trouble lsp toggle win.position=right<cr>", "All" },
            I = { ":LspInfo<cr>", "Info" },
            L = { ":LspLog<cr>", "Log" },
            S = { ":LspStop<cr>", "Stop" },
            R = { ":LspRestart<cr>", "Restart" },
          },
        },
      })
    end

    return {
      capabilities = capabilities,
      default_mappings = false,
      on_attach = on_attach,
      servers = {
        ansiblels = {},
        bashls = {},
        biome = {},
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
        vtsls = {},
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
