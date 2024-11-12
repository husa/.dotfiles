-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- move lines
-- use arrows(jk bindings in lazyvim)
map("n", "<A-Down>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-Up>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-Down>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-Up>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- scroll
map({ "n", "v" }, "<S-Down>", "10j", { desc = "Scroll down and center" })
map({ "n", "v" }, "<S-Up>", "10k", { desc = "Scroll up and center" })

-- find and center
map("n", "n", "nzzzv", { desc = "Find next and center" })
map("n", "N", "Nzzzv", { desc = "Find previous and center" })

-- delete single character without copying into register
map({ "n", "v" }, "x", '"_x', { desc = "Delete single character" })

-- "natural" navigation by words using Alt
map("n", "<A-Left>", "b")
map("n", "<A-Right>", "e")
map("i", "<A-Left>", "<C-o>b")
map("i", "<A-Right>", "<C-o>e")

-- insert newline in insert mode, same as <A-o> and <S-A-o>
map("i", "<A-cr>", "<C-o>o", { desc = "Append line and enter" })
map("i", "<S-A-cr>", "<C-o>O", { desc = "Prepend line and enter" })
