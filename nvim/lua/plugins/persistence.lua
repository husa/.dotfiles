return {
  "folke/persistence.nvim",
  version = "*",
  event = "BufReadPre", -- this will only start session saving when an actual file was opened
  opts = {
    -- add any custom options here
  },
}
