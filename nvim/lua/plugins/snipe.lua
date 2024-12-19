return {
  "leath-dub/snipe.nvim",
  opts = {
    ui = {
      text_align = "file-first",
    },
  },
  keys = {
    {
      "<leader>v",
      function()
        require("snipe").open_buffer_menu()
      end,
      desc = "Open Snipe buffer menu",
    },
  },
}
