return {
  "echasnovski/mini.nvim",
  version = "*",
  event = "VeryLazy",
  config = function()
    require("mini.ai").setup()
    require("mini.bufremove").setup()
    require("mini.cursorword").setup()
    require("mini.indentscope").setup()

    local neigh_pattern = "[^\\%a%d][^%a%d]"
    require("mini.pairs").setup({
      mappings = {
        ['"'] = { action = "closeopen", pair = '""', neigh_pattern = neigh_pattern, register = { cr = false } },
        ["'"] = { action = "closeopen", pair = "''", neigh_pattern = neigh_pattern, register = { cr = false } },
        ["`"] = { action = "closeopen", pair = "``", neigh_pattern = neigh_pattern, register = { cr = false } },
      },
    })

    require("mini.surround").setup({
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    })
    require("which-key").add({
      { "gs", group = "Surround" },
    })

    -- set mini.cursorword highlight groups(bg color without underline)
    local colors = require("catppuccin.palettes").get_palette("mocha")
    vim.api.nvim_set_hl(0, "MiniCursorword", { bg = colors.surface1 })
    vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { underline = false })
  end,
}
