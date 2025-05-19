---@type LazySpec
return {

  {
    "wansmer/symbol-usage.nvim",
    event = "LspAttach",
    config = function()
      require("symbol-usage").setup({
        vt_position = "end_of_line",
        request_pending_text = "",
        hl = { link = "LspInlayHint" },
      })
    end,
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
    ft = { "json", "yaml", "toml" },
  },

  { "icholy/lsplinks.nvim", ft = "yaml" },

  {
    "junnplus/lsp-setup.nvim",
    dependencies = {
      { "lukas-reineke/lsp-format.nvim", event = "LspAttach", version = "*" },
      { "neovim/nvim-lspconfig", version = "*" },
    },
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
        require("lsp-format").on_attach(client)

        if vim.bo[bufnr].filetype == "yaml" then
          local lsplinks = require("lsplinks")
          lsplinks.setup()
          vim.keymap.set("n", "gx", lsplinks.gx, { buffer = bufnr })
        end

        require("which-key").add({
          { "gr", group = "LSP bindings" },
          { "<space>l", group = "LSP", buffer = bufnr },
          { "<space>lR", ":LspRestart<cr>", desc = "Restart", buffer = bufnr },
          { "<space>lS", ":LspStop<cr>", desc = "Stop", buffer = bufnr },
          { "<space>lc", ":Trouble lsp_declarations toggle<cr>", desc = "Declarations", buffer = bufnr },
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
          gopls = {},
          html = {},
          marksman = {},
          pyright = {},
          taplo = { filetypes = { "toml" } },
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
            settings = function()
              local ft = vim.bo.filetype
              if ft == "json" or ft == "yaml" then
                return {
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
                }
              end
              return {
                yaml = { schemaStore = { enable = false, url = "" } },
                json = { validate = { enable = true } },
              }
            end,
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
      vim.lsp.set_log_level("warn")
      vim.cmd("LspStart")
    end,
  },
}
