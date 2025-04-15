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
    {
      "[g",
      function()
        local gitsigns = require("gitsigns")
        gitsigns.nav_hunk("prev", { preview = true })
      end,
      desc = "Prev Git Hunk",
    },
    {
      "]g",
      function()
        local gitsigns = require("gitsigns")
        gitsigns.nav_hunk("next", { preview = true })
      end,
      desc = "Next Git Hunk",
    },
  },
}
