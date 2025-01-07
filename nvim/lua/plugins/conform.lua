return {
  "stevearc/conform.nvim",
  version = "*",
  event = { "BufWritePre", "BufNewFile" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
    },
    format_on_save = {
      timeout_ms = 1000,
      async = false,
      lsp_fallback = true,
    },
  },
}
