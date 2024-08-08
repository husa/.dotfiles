-- NeoVide
if vim.g.neovide then
  -- opt.cmdheight = 0
end
vim.g.neovide_window_blurred = true
vim.g.neovide_transparency = 0.85

-- Regular options
local opt = vim.opt

-- wrapping
opt.wrap = true -- wrap by default

-- Custom filetypes
vim.filetype.add({
  filename = {},
  pattern = {
    [".*/git/config"] = "gitconfig",
    [".*/.kube/config"] = "yaml",
  },
})
