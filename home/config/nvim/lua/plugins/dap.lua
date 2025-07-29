return {
  "mfussenegger/nvim-dap",
  dependencies = {
    { "rcarriga/nvim-dap-ui" },
    { "thehamsta/nvim-dap-virtual-text" },
    {
      "microsoft/vscode-js-debug",
      build = "npm install --ignore-scripts && npm run compile && npx gulp dapDebugServer",
    },
  },
  config = function()
    local dap = require("dap")
    require("dapui").setup()

    require("nvim-dap-virtual-text").setup({
      display_callback = function(variable)
        if #variable.value > 25 then return " " .. string.sub(variable.value, 1, 25) .. "... " end

        return " " .. variable.value
      end,
    })

    vim.fn.sign_define("DapBreakpoint", { text = "" })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "dap-repl",
      callback = function() require("dap.ext.autocompl").attach() end,
    })

    -- Adapters
    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = { vim.fn.expand("$HOME/.local/share/nvim/lazy/vscode-js-debug/dist/src/dapDebugServer.js"), "${port}" },
      },
    }

    -- js/ts config
    for _, language in ipairs({ "typescript", "javascript" }) do
      dap.configurations[language] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Debug Jest Test file",
          runtimeExecutable = "node",
          runtimeArgs = {
            "./node_modules/jest/bin/jest.js",
            "--runInBand",
            "${file}",
          },
          rootPath = "${workspaceFolder}",
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Debug Jest Tests",
          runtimeExecutable = "node",
          runtimeArgs = {
            "./node_modules/jest/bin/jest.js",
            "--runInBand",
          },
          rootPath = "${workspaceFolder}",
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
      }
    end
  end,
  keys = {
    {
      "<space>d",
      desc = "Debugger",
    },
    {
      "<space>dc",
      function() require("dap").continue() end,
      desc = "Continue",
    },
    {
      "<space>do",
      function() require("dap").step_over() end,
      desc = "Step Over",
    },
    {
      "<space>di",
      function() require("dap").step_into() end,
      desc = "Step Into",
    },
    {
      "<space>dO",
      function() require("dap").step_out() end,
      desc = "Step Out",
    },
    {
      "<leader>db",
      function() require("dap").toggle_breakpoint() end,
      desc = "Toggle Breakpoint",
    },
    {
      "<leader>dlb",
      function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end,
      desc = "Set Log Point Message",
    },
    {
      "<leader>du",
      function() require("dapui").toggle() end,
      desc = "Toggle Dap UI",
    },
    {
      "<leader>dC",
      function() require("dap").run_to_cursor() end,
      desc = "Run to Cursor",
    },
    {
      "<leader>de",
      function() require("dapui").eval(nil, { enter = true }) end,
      desc = "Evaluate under cursor",
    },
  },
}
