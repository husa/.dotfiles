return {
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
          Pmenu = { bg = colors.surface0 }, -- popups(autocomplete)
        }
      end,
      integrations = { blink_cmp = true },
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}
