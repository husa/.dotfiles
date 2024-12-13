return {
  "stevearc/oil.nvim",
  version = "*",
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- command = "Oil",
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    default_file_explorer = true,
    view_options = {
      show_hidden = true,
    },
  },
  keys = {
    {
      "<leader>eo",
      function()
        require("oil").toggle_float()
      end,
      { desc = "Open Oil" },
    },
  },
}
