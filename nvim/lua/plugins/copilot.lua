return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "BufReadPost",
  enabled = true,
  opts = {
    filetypes = {
      markdown = true,
    },
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
}
