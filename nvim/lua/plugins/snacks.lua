return {
  "folke/snacks.nvim",
  version = "*",
  -- priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- bigfile = { enabled = true },
    bufdelete = { enabled = true },
    -- dashboard = { enabled = true },
    -- indent = { enabled = true },
    -- input = { enabled = true },
    -- notifier = { enabled = true },
    -- quickfile = { enabled = true },
    -- scroll = { enabled = true },
    statuscolumn = { enabled = true },
    -- words = { enabled = true },
  },
  keys = {
    { "<leader>bd", "<cmd>:lua Snacks.bufdelete()<cr>", mode = "n", desc = "Delete Buffer" },
    { "<leader>bo", "<cmd>:lua Snacks.bufdelete.other()<cr>", mode = "n", desc = "Delete Other Buffers" },
    { "<leader>ba", "<cmd>:lua Snacks.bufdelete.all()<cr>", mode = "n", desc = "Delete All Buffers" },
    { "<leader>bD", "<cmd>:bdelete<cr>", mode = "n", desc = "Delete Buffer and Window" },
  },
}
