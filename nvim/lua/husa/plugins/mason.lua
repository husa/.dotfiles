return {
  "williamboman/mason.nvim",
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  opts = {},
  config = function()
    require("mason").setup({})

    require("mason-tool-installer").setup({
      ensure_installed = {
        "prettier",
        "stylua",
      },
    })
  end,
}
