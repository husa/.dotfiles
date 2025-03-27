return {
  {
    "catppuccin/nvim",
    -- version = "*", -- disable version check, probably nothing will break
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    config = function()
      -- enable transparent background, but not in neovide
      local transparent_background = true
      if vim.g.neovide then
        transparent_background = false
      end

      require("catppuccin").setup({
        transparent_background = transparent_background,
        custom_highlights = function(colors)
          return {
            -- force solid background
            Folded = { bg = colors.surface1 }, -- folds
          }
        end,
        integrations = {
          blink_cmp = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  { "rebelot/kanagawa.nvim", lazy = true },
  { "folke/tokyonight.nvim", lazy = true },
  { "EdenEast/nightfox.nvim", lazy = true },
  { "rose-pine/neovim", lazy = true },
  { "shaunsingh/nord.nvim", lazy = true },
  { "WTFox/jellybeans.nvim", opts = {}, lazy = true },
}
