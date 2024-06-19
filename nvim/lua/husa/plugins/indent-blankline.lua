return {
  "lukas-reineke/indent-blankline.nvim",
  config = function()
    require("ibl").setup({
      scope = { enabled = true, char = "▎" },
      indent = { char = "┊" },
      exclude = {
        filetypes = {
          "help",
          "neotree",
          "trouble",
          "lazy",
          "mason",
        },
      },
    })
  end,
}
