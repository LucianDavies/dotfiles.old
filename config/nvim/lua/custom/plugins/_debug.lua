-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'mxsdev/nvim-dap-vscode-js',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = false,

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {},
    }

    -- You can provide additional configuration to the handlers,
    -- see mason-nvim-dap README for more information
    require('mason-nvim-dap').setup_handlers()

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', dap.continue)
    vim.keymap.set('n', '<F1>', dap.step_into)
    vim.keymap.set('n', '<F2>', dap.step_over)
    vim.keymap.set('n', '<F3>', dap.step_out)
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end)

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
        },
      },
    }


    dap.listeners.after.event_initialized["dapui_config"] = function()
      vim.keymap.set("n", "<down>", dap.step_over, { desc = "dap: step over" })
      vim.keymap.set("n", "<left>", dap.step_out, { desc = "dap: step out" })
      vim.keymap.set("n", "<right>", dap.step_into, { desc = "dap: step into" })
      vim.o.signcolumn = "yes:1"
      dapui.open()
    end
    local after_session = function()
      pcall(vim.keymap.del, "n", "<down>")
      pcall(vim.keymap.del, "n", "<left>")
      pcall(vim.keymap.del, "n", "<right>")
      vim.o.signcolumn = "auto"
      dapui.close()
    end
    dap.listeners.after.event_terminated["dapui_config"] = after_session
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
    dap.listeners.after.disconnected["dapui_config"] = after_session

    require("dap-vscode-js").setup({
      debugger_path = vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter", -- Path to VSCode Debugger
      debugger_cmd = { "js-debug-adapter" },
      adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
    })
    local exts = {
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      -- using pwa-chrome
      "vue",
      "svelte",
    }

    for _, language in ipairs(exts) do
      dap.configurations[language] = {
        {
          name = "Node: Attach",
          type = "pwa-node",
          request = "attach",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
        {
          command = "npm run dev",
          name = "Debug SvelteKit",
          request = "launch",
          type = "node-terminal",
          cwd = "${workspaceFolder}"
        },
        {
          name = "Vitest: Debug Tests",
          type = "pwa-node",
          request = "launch",
          cwd = "${workspaceFolder}",
          program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
          args = {
            "--inspect-brk",
            "--threads",
            "false",
          },
          autoAttachChildProcesses = true,
          trace = true,
          console = "integratedTerminal",
          skipFiles = { "<node_internals>/**", "node_modules/**" },
          sourceMaps = true,
          smartStep = true,
        },
        {
          name = "Jest: Debug Tests",
          type = "pwa-node",
          request = "launch",
          trace = true,
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
      }
    end
  end
}
