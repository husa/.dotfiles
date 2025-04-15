return {
  "norcalli/nvim-colorizer.lua",
  -- version = "*", -- no releases
  config = function()
    require("colorizer").setup(
      {
        "*",
        css = { css = true },
        scss = { css = true },
      },
      { css = true } -- enable all CSS color formats
    )
  end,
}
