return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "williamboman/mason.nvim",
    "rcarriga/nvim-dap-ui",
    { "theHamsta/nvim-dap-virtual-text", opts = {} },
    "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()
    local dap = require("dap")

    require("mason-nvim-dap").setup({
      ensure_installed = { "js" },
      automatic_installation = true,
      -- handlers = {
      --   js = function(config)
      --     config.adapters = {
      --       type = "executable",
      --       command = vim.fn.exepath("js-debug-adapter"),
      --     }
      --     config.configurations123 = {
      --       {
      --         type = "node",
      --         name = "Debug current file",
      --         request = "launch",
      --         program = "${file}",
      --         -- cwd = vim.fn.getcwd(),
      --         -- runtimeArgs = {},
      --         -- runtimeExecutable = "",
      --         -- sourceMaps = true,
      --         -- protocol = "inspector",
      --         -- console = "integratedTerminal",
      --       },
      --     }
      --     require("mason-nvim-dap").default_setup(config)
      --   end,
      -- },
    })
    dap.set_log_level("TRACE")
    -- dap.adapters.node = {
    --   type = "executable",
    --   command = "js-debug-adapter",
    --   args = {},
    -- }
    -- dap.adapters.node = {
    --   type = "executable",
    --   command = "node",
    --   args = {
    --     "/Users/husa/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
    --   },
    -- }
    --
    dap.adapters.node = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = {
          "/Users/husa/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
          "${port}",
        },
      },
    }
    require("dap").adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        -- ?? Make sure to update this path to point to your installation
        args = { vim.fn.exepath("js-debug-adapter"), "${port}" },
      },
    }

    -- default configurations
    require("dap").configurations.javascript = {
      {
        type = "node",
        request = "launch",
        name = "Launch file nvim",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
      {
        type = "node",
        request = "attach",
        name = "attach nvim",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
    }

    require("nvim-dap-virtual-text").setup()

    -- JS setup
    -- local js_filetypes = {'javascript', 'typescript', 'javascriptreact', 'typescriptreact'}
    -- local js_config = {}
    --
    -- for _, lang in ipairs(js_filetypes) do
    --   dap.configurations[lang] = js_config
    -- end

    -- custom sign icons and highlights
    local sign_icons = {
      DapStopped = { "󰁕 ", "DiagnosticSignWarn", "DapStoppedLine", "DiagnosticSignWarn" },
      DapBreakpoint = { " ", "DiagnosticSignInfo", nil, "DiagnosticSignInfo" },
      DapBreakpointCondition = { " ", "DiagnosticSignInfo", nil, "DiagnosticSignInfo" },
      DapBreakpointRejected = { " ", "DiagnosticSignError" },
      DapLogPoint = { ".>" },
    }

    for name, sign in pairs(sign_icons) do
      vim.fn.sign_define(
        name,
        { text = sign[1], texthl = sign[2] or "DiagnosticSignInfo", linehl = sign[3], numhl = sign[4] }
      )
    end

    -- Keymaps
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { desc = desc })
    end
    map("<leader>db", dap.toggle_breakpoint, "Toggle Breakpoint")
    map("<leader>dB", function()
      dap.set_breakpoint(vim.fn.input("Condition"))
    end, "Set Conditional Breakpoint")
    map("<leader>dc", dap.continue, "Start/Continue")
    map("<leader>di", dap.step_into, "Step Into")
    map("<leader>do", dap.step_over, "Step Over")
    map("<leader>ds", dap.step_out, "Step Out")
    map("<leader>dr", dap.repl.toggle, "Toggle REPL")
    map("<leader>dl", dap.run_last, "Run Last")
  end,
}
