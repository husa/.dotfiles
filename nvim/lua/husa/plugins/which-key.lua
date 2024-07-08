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
      ["<leader>b"] = { name = "+ Buffer" },
      ["<leader>e"] = { name = "+ Explore" },
      ["<leader>f"] = { name = "+ Find/file" },
      ["<leader>c"] = { name = "+ Code" },
      ["<leader>w"] = { name = "+ Window" },
      ["<leader>u"] = { name = "+ Utils/Tools" },
      ["<leader>q"] = { name = "+ Quit/session" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}
