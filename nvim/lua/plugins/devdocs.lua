return {
  "luckasRanarison/nvim-devdocs",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {},
  keys = {
    { "<leader>s?", "<cmd>DevdocsOpen<cr>", desc = "Search DevDocs", mode = "n" },
  },
}
