local opt = vim.opt

-- NeoVide
if vim.g.neovide then
  -- opt.cmdheight = 0
  opt.linespace = 2
end

vim.g.neovide_window_blurred = true
-- disable transparency as neovide loses window shadow when it's enabled
-- vim.g.neovide_transparency = 0.85

-- LazyVim
-- disable root detection(not convenient when editing multi-language dirs, like this ".dotfiles" one)
-- default is vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }
vim.g.root_spec = { "cwd" }

-- Regular options

-- wrapping
opt.wrap = true -- wrap by default

-- Custom filetypes
vim.filetype.add({
  filename = {},
  pattern = {
    ["git/config"] = "gitconfig",
    [".*/%.kube/config"] = "yaml",
  },
})
