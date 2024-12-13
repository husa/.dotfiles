return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    delay = 150,
    expand = 3,
    spec = {
      { "<leader>b", group = "Buffer" },
      { "<leader>c", group = "Code" },
      { "<leader>e", group = "Explore" },
      { "<leader>f", group = "Find/file" },
      { "<leader>q", group = "Quit/session" },
      { "<leader>u", group = "Utils/Tools" },
      { "<leader>w", group = "Window" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
