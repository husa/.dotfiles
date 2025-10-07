local map = vim.keymap.set

-- move lines using arrows
map("n", "<A-Down>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-Up>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-Down>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-Up>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

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

-- write buffer
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- new buffer
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New Buffer" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- buffers
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
-- map("n", "<leader>bd", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })
map("n", "[b", "<cmd>bnext<cr>", { desc = "Previous Buffer" })
map("n", "]b", "<cmd>bprevious<cr>", { desc = "Next Buffer" })

-- tabs
map("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader>to", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
map("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader>t]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader>t[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "<leader>tf", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader>tl", "<cmd>tablast<cr>", { desc = "Last Tab" })

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
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Diagnostics next" })
map("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Diagnostics prev" })
-- toggle diagnostics
map("n", "<leader>ud", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { silent = true, noremap = true, desc = "Toggle diagnostics" })

-- select and reload a lazy plugin
map("n", "<leader>ur", function()
  local plugins = require("lazy").plugins()

  local plugin_names = {}
  for _, plugin in ipairs(plugins) do
    table.insert(plugin_names, plugin.name)
  end

  vim.ui.select(plugin_names, {
    prompt = "Reload plugin",
  }, function(selected)
    require("lazy").reload({ plugins = { selected } })
  end)
end, { desc = "Reload plugin" })

-- select and set filetype
map("n", "<leader>ut", function()
  local filetypes = vim.fn.getcompletion("", "filetype")
  vim.ui.select(filetypes, {
    prompt = "Set Filetype",
  }, function(selected)
    vim.bo.filetype = selected
  end)
end, { desc = "Switch filetype" })

-- toggle relative number
map("n", "<leader>un", function()
  vim.g.toggle_relativenumber = not vim.g.toggle_relativenumber
  vim.opt.relativenumber = vim.g.toggle_relativenumber
end, { desc = "Toggle relative number" })

-- toggle animated cursor
map("n", "<leader>uc", "<cmd>SmearCursorToggle<cr>", { desc = "Toggle number" })
