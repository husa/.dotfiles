return {
  "aspeddro/gitui.nvim",
  lazy = false,
  keys = {
    {
      "<leader>gg",
      function()
        require("gitui").open()
      end,
      desc = "Open GitUI",
    },
  },
  config = function()
    -- remove lazyvim's keymaps for lazygit
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimKeymaps",
      once = true,
      callback = function()
        pcall(vim.keymap.del, "n", "<leader>gf")
        pcall(vim.keymap.del, "n", "<leader>gl")
        pcall(vim.keymap.del, "n", "<leader>gL")
        -- pcall(vim.keymap.del, "n", "<leader>gg")
        pcall(vim.keymap.del, "n", "<leader>gG")
      end,
    })
  end,
}
