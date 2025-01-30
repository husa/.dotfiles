return {
  "stevearc/oil.nvim",
  version = "*",
  dependencies = { "echasnovski/mini.icons" },
  command = "Oil",
  event = "VeryLazy", -- uncomment, to replace this way
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    default_file_explorer = false,
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
      desc = "Open Oil",
    },
  },
}
