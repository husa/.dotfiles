return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File" },
    { "<leader><leader>", "<cmd>Telescope find_files<cr>", desc = "Find File" },
    { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Find Old Files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find String" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
    { "<leader>fc", "<cmd>Telescope grep_string<cr>", desc = "Find string under cursor" },
    { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find Todos" },
    { "<leader>fr", "<cmd>Telescope resume<cr>", desc = "Resume Last Search" },
    { "<leader>fT", "<cmd>Telescope<cr>", desc = "Telescope" },
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
          hidden = true, -- show hidden files in results
        },
      },
    }
  end,
}
