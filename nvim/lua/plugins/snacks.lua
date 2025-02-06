return {
  "folke/snacks.nvim",
  -- version = "*",
  -- priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bufdelete = { enabled = true },
    statuscolumn = { enabled = true },
    zen = { enabled = true },
    explorer = {
      replace_netrw = false, -- Replace netrw with the snacks explorer
    },
    picker = {
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          exclude = { ".DS_Store" },
        },
      },
    },
  },
  keys = {
    -- buf delete
    { "<leader>bd", "<cmd>:lua Snacks.bufdelete()<cr>", mode = "n", desc = "Delete Buffer" },
    { "<leader>bo", "<cmd>:lua Snacks.bufdelete.other()<cr>", mode = "n", desc = "Delete Other Buffers" },
    { "<leader>ba", "<cmd>:lua Snacks.bufdelete.all()<cr>", mode = "n", desc = "Delete All Buffers" },
    { "<leader>bD", "<cmd>:bdelete<cr>", mode = "n", desc = "Delete Buffer and Window" },

    -- zen
    {
      "<leader>uz",
      function()
        Snacks.zen.zen()
      end,
      desc = "Zen Mode",
    },
    {
      "<leader>uZ",
      function()
        Snacks.zen.zoom()
      end,
      desc = "Zoom Mode",
    },

    -- explorer
    { "\\", "<cmd>:lua Snacks.explorer.open()<cr>", mode = "n", desc = "Explorer" },
    { "|", "<cmd>:lua Snacks.explorer.open({focus = 'input'})<cr>", mode = "n", desc = "Explorer (Find)" },
  },
}
