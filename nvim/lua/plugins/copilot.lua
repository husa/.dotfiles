return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  opts = {
    -- triggered by blink.cmp
    suggestion = {
      -- auto_trigger = true,
      enabled = false,
    },
    panel = { enabled = false },
  },
  -- opts = {
  --   suggestion = {
  --     enabled = not vim.g.ai_cmp,
  --     auto_trigger = true,
  --     keymap = {
  --       accept = false, -- handled by nvim-cmp / blink.cmp
  --       next = "<M-]>",
  --       prev = "<M-[>",
  --     },
  --   },
  --   panel = { enabled = false },
  --   filetypes = {
  --     markdown = true,
  --     help = true,
  --   },
  -- },
}
