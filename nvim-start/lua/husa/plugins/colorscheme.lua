return {
  -- gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    -- priority = 1000,
  },
  -- tokyonight
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "moon" },
  },

  -- catppuccin
  {
    "catppuccin/nvim",
    -- lazy = true,
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = false,
        show_end_of_buffer = true,
        integrations = {
          aerial = true,
          alpha = true,
          cmp = true,
          dashboard = true,
          flash = true,
          gitsigns = true,
          headlines = true,
          illuminate = true,
          indent_blankline = { enabled = true },
          leap = true,
          lsp_trouble = true,
          mason = true,
          markdown = true,
          mini = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
          navic = { enabled = true, custom_bg = "lualine" },
          neotest = true,
          neotree = false,
          noice = true,
          notify = true,
          semantic_tokens = true,
          telescope = true,
          treesitter = true,
          treesitter_context = true,
          which_key = true,
        },
        highlight_overrides = {
          all = function(colors)
            return {
              NormalMoody = { fg = colors.blue },
              InsertMoody = { fg = colors.green },
              VisualMoody = { fg = colors.pink },
              CommandMoody = { fg = colors.maroon },
              ReplaceMoody = { fg = colors.red },
              SelectMoody = { fg = colors.pink },
              TerminalMoody = { fg = colors.mauve },
              TerminalNormalMoody = { fg = colors.mauve },
            }
          end,
        },
      })
      vim.cmd("colorscheme catppuccin")
    end,
  },
}
