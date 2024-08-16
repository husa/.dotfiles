return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader>fr", "<cmd>Telescope oldfiles cwd_only=true<cr>", desc = "Recent" },
    { "<leader>fl", "<cmd>Telescope resume<cr>", desc = "Resume last search " },

    { "<leader>ut", "<cmd>Telescope filetypes<cr>", desc = "Filetype" },
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<esc>"] = require("telescope.actions").close,
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
  },
}
