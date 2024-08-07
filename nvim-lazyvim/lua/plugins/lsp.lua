return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false }, -- disable inlay_hints by default
      servers = {
        cssls = {},
        somesass_ls = {},
      },
    },
  },
}
