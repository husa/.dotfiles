-- literally the same as
-- https://github.com/aspeddro/gitui.nvim
-- https://github.com/mikinovation/nvim-gitui

local open_gitui = function()
  local width = vim.api.nvim_get_option_value("columns", {})
  local height = vim.api.nvim_get_option_value("lines", {})
  local win_width = math.floor(width * 0.8)
  local win_height = math.floor(height * 0.8)
  local row = math.floor((height - win_height) / 2)
  local col = math.floor((width - win_width) / 2)

  local window_options = {
    style = "minimal",
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col,
    border = "rounded",
  }

  local buffer = vim.api.nvim_create_buf(false, true)

  local win_id = vim.api.nvim_open_win(buffer, true, window_options)

  vim.fn.termopen("gitui -l", {
    on_exit = function()
      vim.api.nvim_win_close(win_id, true)
      vim.api.nvim_buf_delete(buffer, { force = true })
    end,
  })

  vim.cmd("startinsert!")
end

-- set keymap
vim.keymap.set("n", "<leader>gu", open_gitui, { desc = "Open GitUI", noremap = true, silent = true })
