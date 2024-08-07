-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- NeoVide
if vim.g.neovide then
  -- opt.cmdheight = 0
end
vim.g.neovide_window_blurred = true
vim.g.neovide_transparency = 0.85

local opt = vim.opt

-- wrapping
opt.wrap = true -- wrap by default
