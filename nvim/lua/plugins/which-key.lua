return {
  "folke/which-key.nvim",
  version = "*",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    spec = {
      { "<leader>a", group = "AI" },
      { "<leader>b", group = "Buffer" },
      { "<leader>c", group = "Code" },
      { "<leader>d", group = "Debug" },
      { "<leader>e", group = "Explore" },
      { "<leader>f", group = "Find/file" },
      { "<leader>g", group = "Git" },
      { "<leader>q", group = "Quit/session" },
      { "<leader>s", group = "Search" },
      { "<leader>t", group = "Tabs" },
      { "<leader>u", group = "Utils/Tools" },
      { "<leader>w", group = "Window" },
      { "<leader>x", group = "Trouble" },
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
