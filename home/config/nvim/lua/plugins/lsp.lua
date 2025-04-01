---@type LazySpec
return {

  {
    "wansmer/symbol-usage.nvim",
    event = "LspAttach",
    config = function() require("symbol-usage").setup({}) end,
  },

  {
    "artemave/workspace-diagnostics.nvim",
    keys = { "<space>lp" },
    config = function()
      require("workspace-diagnostics").setup({
        workspace_files = function()
          local ignore_list = { "generated", ".md", ".json" }
          local cwd = vim.fn.getcwd()
          local workspace_files = vim.fn.split(vim.fn.system("git ls-files " .. cwd), "\n")
          workspace_files = vim.tbl_filter(function(file)
            for _, ignore in ipairs(ignore_list) do
              if file:match(ignore) then return false end
            end
            return true
          end, workspace_files)

          return workspace_files
        end,
      })
    end,
  },

  {
    "b0o/schemastore.nvim",
    ft = { "json", "yaml" },
  },

  {
    "junnplus/lsp-setup.nvim",
    dependencies = {
      { "lukas-reineke/lsp-format.nvim", event = "LspAttach", version = "*" },
      { "neovim/nvim-lspconfig", version = "*" },
      {
        "icholy/lsplinks.nvim",
        event = "LspAttach",
        config = function()
          local lsplinks = require("lsplinks")
          lsplinks.setup()
          vim.keymap.set("n", "gx", lsplinks.gx)
        end,
      },
    },
    event = "VeryLazy",
    config = function()
      vim.diagnostic.config({
        float = { source = true },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = "",
          },
        },
        virtual_text = false,
      })

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

        require("which-key").add({
          { "<space>l", group = "LSP", buffer = bufnr },
          { "<space>lR", ":LspRestart<cr>", desc = "Restart", buffer = bufnr },
          { "<space>lS", ":LspStop<cr>", desc = "Stop", buffer = bufnr },
          { "<space>la", vim.lsp.buf.code_action, desc = "Actions", buffer = bufnr },
          { "<space>lc", ":Trouble lsp_declarations toggle<cr>", desc = "Declarations", buffer = bufnr },
          { "<space>ld", ":Trouble lsp_definitions toggle<cr>", desc = "Definitions", buffer = bufnr },
          { "<space>li", ":Trouble lsp_implementations toggle<cr>", desc = "Implementation", buffer = bufnr },
          {
            "<space>lf",
            ":FzfLua lsp_live_workspace_symbols<cr>",
            desc = "Search for symbols",
            buffer = bufnr,
            mode = { "n", "x" },
          },
          { "<space>ll", ":Trouble lsp toggle win.position=right<cr>", desc = "All", buffer = bufnr },
          { "<space>lI", ":Trouble lsp_incoming_calls toggle<cr>", desc = "Incoming calls", buffer = bufnr },
          { "<space>lO", ":Trouble lsp_outgoing_calls toggle<cr>", desc = "Outgoing calls", buffer = bufnr },
          { "<space>lq", vim.diagnostic.setloclist, desc = "Diagnostics to quickfix", buffer = bufnr },
          { "<space>lr", ":Trouble lsp_references toggle<cr>", desc = "References", buffer = bufnr },
          { "<space>lt", ":Trouble lsp_type_definitions toggle<cr>", desc = "Type definition", buffer = bufnr },
          { "<space>r", vim.lsp.buf.rename, desc = "Rename word", buffer = bufnr },
          {
            "<space>ls",
            ":Trouble lsp_document_symbols toggle win.position=right win.size=0.15<cr>",
            desc = "Document symbols",
            buffer = bufnr,
          },
          {
            "<space>lh",
            function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })) end,
            desc = "Toggle inlay hints",
            buffer = bufnr,
          },
          {
            "<space>lp",
            function() require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr) end,
            desc = "Populate workspace diagnostics",
            buffer = bufnr,
          },
        })
      end

      require("lsp-setup").setup({
        capabilities = capabilities,
        default_mappings = false,
        on_attach = on_attach,
        servers = {
          ansiblels = {},
          bashls = {},
          biome = { cmd = { "npx", "biome", "lsp-proxy" } },
          cssls = {},
          dockerls = {},
          docker_compose_language_service = {},
          eslint = {},
          gopls = {},
          graphql = { filetypes = { "graphql", "typescriptreact", "javascriptreact", "typescript" } },
          html = {},
          marksman = {},
          pyright = {},
          -- taplo = {} -- https://github.com/tamasfe/taplo/issues/431,
          terraformls = {},
          vtsls = {
            settings = {
              vtsls = {
                autoUseWorkspaceTsdk = true,
              },
              typescript = {
                format = { enable = false },
              },
            },
          },
          yamlls = {},
          jsonls = {
            init_options = { provideFormatter = false },
            settings = {
              yaml = {
                schemas = require("schemastore").yaml.schemas(),
                schemaStore = {
                  enable = true,
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
                diagnostics = {
                  enable = true,
                  globals = { "vim", "describe" },
                },
              },
            },
          },
        },
      })
      vim.cmd("LspStart")
    end,
  },
}
