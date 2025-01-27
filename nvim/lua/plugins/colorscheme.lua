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
          -- NormalFloat = { fg = colors.text, bg = colors.mantle }, -- floating windows/popups

          BlinkCmpDoc = { link = "Pmenu" },
          BlinkCmpDocBorder = { link = "Pmenu" },
          BlinkCmpDocSeparator = { link = "Pmenu" },
          BlinkCmpSignatureHelp = { link = "Pmenu" },
          BlinkCmpSignatureHelpBorder = { link = "Pmenu" },
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
}
