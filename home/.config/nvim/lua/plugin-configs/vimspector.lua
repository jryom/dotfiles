return function()
  vim.g.vimspector_base_dir = vim.fn.stdpath("data") .. "/site/pack/packer/start/vimspector"
  vim.g.vimspector_install_gadgets = { "vscode-node-debug2", "debugger-for-chrome", "vscode-firefox-debug" }

  vim.cmd([[
    sign define vimspectorBP            text=\  texthl=WarningMsg
    sign define vimspectorBPCond        text=\  texthl=WarningMsg
    sign define vimspectorBPLog         text=\  texthl=SpellRare
    sign define vimspectorBPDisabled    text=\  texthl=LineNr
    sign define vimspectorPC            text=\  texthl=Error 
    sign define vimspectorPCBP          text=\  texthl=Error
    sign define vimspectorCurrentThread text=\  texthl=Error linehl=CursorLine
    sign define vimspectorCurrentFrame  text=\  texthl=Error linehl=CursorLine
  ]])

  vim.g.vimspector_configurations = {
    jest = {
      adapter = "vscode-node",
      filetypes = { "javascript", "typescript" },
      configuration = {
        type = "node",
        request = "launch",
        name = "Jest Current File",
        program = "${cwd}/node_modules/.bin/jest",
        args = { "${fileBasenameNoExtension}" },
        console = "integratedTerminal",
        cwd = vim.fn.getcwd(),
      },
    },
    node = {
      adapter = "vscode-node",
      filetypes = { "javascript", "typescript" },
      configuration = {
        request = "launch",
        protocol = "auto",
        stopOnEntry = true,
        console = "integratedTerminal",
        program = "${file}",
        cwd = "${workspaceRoot}",
      },
    },
  }
end
