return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader><leader>", "<cmd>Telescope find_files<cr>", desc = "Find File" },
    { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Find String" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find String" },
    { "<leader>fo", "<cmd>Telescope oldfiles cwd_only=true<cr>", desc = "Find Old Files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find String" },
    { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Find Buffers" },
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
