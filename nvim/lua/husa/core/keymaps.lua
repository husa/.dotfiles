vim.g.mapleader = " "

local map = vim.keymap.set

-- map("n", "<leader>qa", "<cmd>qa<cr>", { desc = "Quit All" })
-- map("n", "<leader>qq", "<cmd>q<cr>", { desc = "Quit" })

-- better indent
map("v", ">", ">gv")
map("v", "<", "<gv")

-- windows
map({ "n", "v" }, "<leader>wv", "<cmd>vnew<cr>", { desc = "Split Vertically |" })
map({ "n", "v" }, "<leader>wh", "<cmd>new<cr>", { desc = "Split Horizontally ---" })
map("n", "<leader>w<Left>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<leader>w<Down>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<leader>w<Up>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<leader>w<Right>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- utils
map("n", "<leader>ul", "<cmd>Lazy<cr>", { desc = "Lazy" })
map("n", "<leader>um", "<cmd>Mason<cr>", { desc = "Mason" })

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })
map("n", "<A-Down>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-Up>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-Down>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-Up>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })
