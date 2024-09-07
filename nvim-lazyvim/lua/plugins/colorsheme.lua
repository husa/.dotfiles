return {
  {
    "catppuccin/nvim",
    lazy = false,
    opts = function(_, opts)
      -- enable transparent background, but not in neovide
      if not vim.g.neovide then
        opts.transparent_background = true
      end
      return opts
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
