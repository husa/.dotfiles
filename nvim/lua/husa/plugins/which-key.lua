return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 150
  end,
  opts = {
    plugins = { spelling = true },
    defaults = {
      mode = { "n", "v" },
      ["<leader>e"] = { name = "+explore" },
      ["<leader>f"] = { name = "+file/find" },
      ["<leader>c"] = { name = "+code" },
      ["<leader>w"] = { name = "+windows" },
      ["<leader>u"] = { name = "+utils/tools" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}
