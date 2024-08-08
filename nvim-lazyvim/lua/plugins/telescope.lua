return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader>fr", "<cmd>Telescope oldfiles cwd_only=true<cr>", desc = "Recent" },
    { "<leader>fl", "<cmd>Telescope resume<cr>", desc = "Resume last search " },

    { "<leader>ut", "<cmd>Telescope filetypes<cr>", desc = "Filetype" },
  },
}
