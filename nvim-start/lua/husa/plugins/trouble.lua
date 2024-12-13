return {
  "folke/trouble.nvim",
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>cs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
}

-- -- TODO: refine. add telescope and shit
-- return {
--   "folke/trouble.nvim",
--   cmd = "Trouble",
--   -- dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
--   -- keys = {
--   --   { "<leader>xx", "<cmd>Trouble<CR>", desc = "Open/close trouble list" },
--   --   { "<leader>xw", "<cmd>Trouble workspace_diagnostics<CR>", desc = "Open trouble workspace diagnostics" },
--   --   { "<leader>xd", "<cmd>Trouble document_diagnostics<CR>", desc = "Open trouble document diagnostics" },
--   --   { "<leader>xq", "<cmd>Trouble quickfix<CR>", desc = "Open trouble quickfix list" },
--   --   { "<leader>xl", "<cmd>Trouble loclist<CR>", desc = "Open trouble location list" },
--   --   { "<leader>xt", "<cmd>TodoTrouble<CR>", desc = "Open todos in trouble" },
--   -- },
--   -- keys = {
--   --   {
--   --     "<leader>xx",
--   --     "<cmd>Trouble diagnostics toggle<cr>",
--   --     desc = "Diagnostics (Trouble)",
--   --   },
--   --   {
--   --     "<leader>xX",
--   --     "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
--   --     desc = "Buffer Diagnostics (Trouble)",
--   --   },
--   --   {
--   --     "<leader>cs",
--   --     "<cmd>Trouble symbols toggle focus=false<cr>",
--   --     desc = "Symbols (Trouble)",
--   --   },
--   --   {
--   --     "<leader>cl",
--   --     "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
--   --     desc = "LSP Definitions / references / ... (Trouble)",
--   --   },
--   --   {
--   --     "<leader>xL",
--   --     "<cmd>Trouble loclist toggle<cr>",
--   --     desc = "Location List (Trouble)",
--   --   },
--   --   {
--   --     "<leader>xQ",
--   --     "<cmd>Trouble qflist toggle<cr>",
--   --     desc = "Quickfix List (Trouble)",
--   --   },
--   -- },
-- }
