return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "williamboman/mason.nvim",
    { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" }, opts = {} },
    { "theHamsta/nvim-dap-virtual-text", opts = {} },
    "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()
    local dap = require("dap")

    -- set DAP log level for troubleshooting
    dap.set_log_level("TRACE")

    -- JS setup
    local js_debug_adapter_path = vim.fs.joinpath(
      vim.fn.stdpath("data") --[[@as string]],
      "mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"
    )
    local adapter_names = { "pwa-node" }
    for _, name in ipairs(adapter_names) do
      dap.adapters[name] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            js_debug_adapter_path,
            "${port}",
          },
        },
      }
    end
    if not dap.adapters["node"] then
      dap.adapters["node"] = function(cb, config)
        if config.type == "node" then
          config.type = "pwa-node"
        end
        local nativeAdapter = dap.adapters["pwa-node"]
        if type(nativeAdapter) == "function" then
          nativeAdapter(cb, config)
        else
          cb(nativeAdapter)
        end
      end
    end

    local js_filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" }
    local js_config = {
      {
        type = "pwa-node",
        request = "launch",
        name = " Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-node",
        request = "attach",
        name = " Attach",
        processId = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
      },
    }
    for _, lang in ipairs(js_filetypes) do
      dap.configurations[lang] = js_config
    end

    -- Visuals
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

    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    -- Keymaps
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { desc = desc })
    end
    map("<leader>db", dap.toggle_breakpoint, "Toggle Breakpoint")
    map("<leader>dB", function()
      dap.set_breakpoint(vim.fn.input("Condition"))
    end, "Set Conditional Breakpoint")
    map("<leader>dc", dap.continue, "Start/Continue")
    map("<leader>dQ", dap.clear_breakpoints, "Clear Breakpoints")
    map("<leader>di", dap.step_into, "Step Into")
    map("<leader>do", dap.step_over, "Step Over")
    map("<leader>ds", dap.step_out, "Step Out")
    map("<leader>dr", dap.repl.toggle, "Toggle REPL")
    map("<leader>dl", dap.run_last, "Run Last")
    map("<leader>du", function()
      require("dapui").toggle()
    end, "Toggle DAP UI")
  end,
}
