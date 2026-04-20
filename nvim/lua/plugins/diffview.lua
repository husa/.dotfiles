return {
  -- "sindrets/diffview.nvim",
  "dlyongemallo/diffview.nvim", -- actively maintained fork of sindrets/diffview.nvim
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
    { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
  },
}
