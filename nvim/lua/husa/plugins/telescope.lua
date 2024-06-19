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
    { "<leader>fr", "<cmd>Telescope resume <cr>", desc = "Resume last search" },
  },
  opts = function()
    local actions = require("telescope.actions")
    return {
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = actions.close,
          },
        },
        file_ignore_patterns = {
          "package%-lock%.json",
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
    }
  end,
}
