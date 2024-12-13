return {
  "lewis6991/gitsigns.nvim",
  version = "*",
  event = "BufEnter",
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    -- signs_staged = {
    --   add = { text = "▎" },
    --   change = { text = "▎" },
    --   delete = { text = "" },
    --   topdelete = { text = "" },
    --   changedelete = { text = "▎" },
    -- },
  },
  keys = {
    {
      "<leader>ug",
      function()
        local gitsigns = require("gitsigns")
        gitsigns.toggle_linehl()
        gitsigns.toggle_numhl()
      end,
      desc = "Toggle GitSigns",
    },
  },
}
