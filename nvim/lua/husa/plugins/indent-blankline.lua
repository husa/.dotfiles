return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    scope = { enabled = false },
    exclude = {
      filetypes = {
        "help",
        "neotree",
        "trouble",
        "lazy",
        "mason",
      },
    },
  },
}
