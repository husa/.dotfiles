return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  opts = {},
  config = function()
    require("mason").setup({})

    require("mason-lspconfig").setup({
      ensure_installed = {
        "tsserver",
        "html",
        "cssls",
        "jsonls",
        "somesass_ls",
        "lua_ls",
        "terraformls",
        "dockerls",
        "yamlls",
        -- "emmet_ls",
        -- "emmet_language_server",
      },
    })
    require("mason-tool-installer").setup({
      ensure_installed = {
        "prettier",
        "stylua",
        "eslint_d",
        "tflint",
      },
    })
  end,
}
