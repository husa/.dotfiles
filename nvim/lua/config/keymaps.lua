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
-- map("i", "<A-cr>", "<C-o>o", { desc = "Append line and enter" })
-- map("i", "<S-A-cr>", "<C-o>O", { desc = "Prepend line and enter" })

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- better indent
map("v", ">", ">gv")
map("v", "<", "<gv")

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- buffers
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
-- map("n", "<leader>bd", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })
map("n", "[b", "<cmd>bnext<cr>", { desc = "Previous Buffer" })
map("n", "]b", "<cmd>bprevious<cr>", { desc = "Next Buffer" })

-- toggle some options
map("n", "<leader>uw", function()
  vim.opt.wrap = not vim.opt.wrap:get()
end, { desc = "Toggle wrap" })
map("n", "<leader>us", function()
  vim.opt.spell = not vim.opt.spell:get()
end, { desc = "Toggle spelling" })
-- utility shortcuts
map("n", "<leader>ul", "<cmd>Lazy<cr>", { desc = "Lazy" })
map("n", "<leader>um", "<cmd>Mason<cr>", { desc = "Mason" })
map("n", "<leader>ui", "<cmd>LspInfo<cr>", { desc = "LspInfo" })

-- next/prev diagnostics
map("n", "]d", function()
  vim.diagnostic.goto_next()
end, { desc = "Diagnostics next" })
map("n", "[d", function()
  vim.diagnostic.goto_prev()
end, { desc = "Diagnostics prev" })

map("n", "<leader>ur", function()
  local plugins = require("lazy").plugins()

  local plugin_names = {}
  for _, plugin in ipairs(plugins) do
    table.insert(plugin_names, plugin.name)
  end

  vim.ui.select(plugin_names, {
    title = "Reload plugin",
  }, function(selected, idx)
    require("lazy").reload({ plugins = { selected } })
  end)
end, { desc = "Reload plugin" })
