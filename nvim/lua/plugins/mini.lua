return {
  "echasnovski/mini.nvim",
  event = "VeryLazy",
  disabled = true,
  version = "*",
  config = function()
    require("mini.ai").setup()
    require("mini.bufremove").setup()
    require("mini.cursorword").setup()
    require("mini.indentscope").setup()
    require("mini.pairs").setup()
    require("mini.surround").setup()

    -- set mini.cursorword highlight groups(bg color without underline)
    local colors = require("catppuccin.palettes").get_palette("mocha")
    vim.api.nvim_set_hl(0, "MiniCursorword", { bg = colors.surface1 })
    vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { underline = false })
  end,
  keys = {
    { "<leader>bd", "<cmd>:lua MiniBufremove.delete()<cr>", mode = "n", desc = "Delete Buffer" },
    { "<leader>bD", "<cmd>:bdelete<cr>", mode = "n", desc = "Delete Buffer and Window" },
  },
}
