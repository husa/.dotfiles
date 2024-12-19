return {
  "leath-dub/snipe.nvim",
  version = "*",
  keys = {
    {
      "<leader>v",
      function()
        require("snipe").open_buffer_menu()
      end,
      desc = "Open Snipe buffer menu",
    },
  },
  config = function()
    require("snipe").setup({
      ui = {
        text_align = "file-first",
        open_win_override = {
          border = "rounded",
        },
        preselect = require("snipe").preselect_by_classifier("#"),
      },
    })
  end,
}
