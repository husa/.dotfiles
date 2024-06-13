vim.g.mapleader = " "

vim.keymap.set("n", "<leader>qa", "<cmd>qa<cr>", { desc = "Quit All" })
vim.keymap.set("n", "<leader>qq", "<cmd>q<cr>", { desc = "Quit" })

-- better indent
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

vim.keymap.set({ "n", "v" }, "<leader>wv", "<cmd>:vnew<cr>", { desc = "Split Vertically |" })
vim.keymap.set({ "n", "v" }, "<leader>wh", "<cmd>:new<cr>", { desc = "Split Horizontally ---" })
