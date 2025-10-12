return {
  "echasnovski/mini.nvim",
  version = "*",
  event = "VeryLazy",
  keys = {
    {
      "<leader>em",
      function()
        MiniFiles.open(vim.api.nvim_buf_get_name(0), true)
        MiniFiles.reveal_cwd()
      end,
      desc = "Explorer",
    },
  },
  config = function()
    require("mini.ai").setup()
    require("mini.bufremove").setup()
    require("mini.indentscope").setup()
    require("mini.files").setup({
      options = {
        use_as_default_explorer = false,
      },
      windows = {
        preview = true,
        width_preview = 40,
        width_focus = 25,
      },
    })

    require("mini.icons").setup({
      file = {
        [".eslintrc.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        [".node-version"] = { glyph = "", hl = "MiniIconsGreen" },
        [".prettierrc"] = { glyph = "", hl = "MiniIconsPurple" },
        [".prettierrc.json"] = { glyph = "", hl = "MiniIconsPurple" },
        [".yarnrc.yml"] = { glyph = "", hl = "MiniIconsBlue" },
        ["eslint.config.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        ["package.json"] = { glyph = "", hl = "MiniIconsGreen" },
        ["package-lock.json"] = { glyph = "", hl = "MiniIconsYellow" },
        ["tsconfig.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["tsconfig.build.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["yarn.lock"] = { glyph = "", hl = "MiniIconsBlue" },
      },
      filetype = {
        typescript = { glyph = "󰛦", hl = "MiniIconsBlue" },
      },
      lsp = {
        copilot = { glyph = "", hl = "MiniIconsBlue" },
        codeium = { glyph = "󱙺", hl = "MiniIconsGreen" },
      },
    })

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

    require("mini.cursorword").setup()
    -- set mini.cursorword highlight groups(bg color without underline)
    local colors = require("catppuccin.palettes").get_palette("mocha")
    vim.api.nvim_set_hl(0, "MiniCursorword", { bg = colors.surface1 })
    vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { underline = false })

    require("which-key").add({
      { "gs", group = "+Surround" },
    })
  end,
}
