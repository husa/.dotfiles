return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Find old files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find string" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
    { "<leader>fc", "<cmd>Telescope grep_string<cr>", desc = "Find string under cursor" },
    { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find todos" },
  },
  opts = {
    defaults = {
      file_ignore_patterns = {
        "package%-lock%.json",
      },
    },
  },
}
