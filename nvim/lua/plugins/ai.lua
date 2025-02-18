local copilot = {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  enabled = false,
  opts = {
    -- triggered by blink.cmp
    suggestion = {
      -- auto_trigger = true,
      enabled = false,
    },
    panel = { enabled = false },
  },
  keys = {
    {
      "<leader>uA",
      function()
        if require("copilot.client").is_disabled() then
          require("copilot.command").enable()
        else
          require("copilot.command").disable()
        end
      end,
      desc = "Toggle Copilot",
    },
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

local codeium = {
  {
    "Exafunction/codeium.nvim",
    cmd = "Codeium",
    event = "InsertEnter",
    enabled = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      enable_cmp_source = true,
      -- virtual_text = {
      --   enabled = false,
      --   manual = false,
      -- },
    },
    -- config = function()
    --   require("codeium").setup({})
    -- end,
  },
  {
    "saghen/blink.cmp",
    dependencies = { "codeium.nvim", "saghen/blink.compat" },
    opts = {
      sources = {
        default = { "codeium" },
        providers = {
          codeium = {
            name = "codeium",
            module = "blink.compat.source",
            -- score_offset = 100,
            -- async = true,
          },
        },
      },
    },
  },
}

return { codeium }
