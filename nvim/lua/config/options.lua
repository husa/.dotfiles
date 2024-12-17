vim.cmd("let g:netrw_liststyle = 3")

vim.cmd("language en_US")

-- disable Netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.filetype.add({
  extension = {
    styl = "sass",
  },
})

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

opt.confirm = true -- get confirmation on :q and similar

opt.undofile = true -- save undo history

opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- wrapping
opt.wrap = true
opt.linebreak = true

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

opt.cursorline = true
opt.list = true

-- turn on termguicolors for tokyonight colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- folding
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
opt.foldcolumn = "auto"
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldtext = ""
-- function formatted_fold_text()
--   local text = vim.treesitter.foldtext()
--   print("some text")
--   local n_lines = vim.v.foldend - vim.v.foldstart
--   local text_lines = " lines"
--
--   if n_lines == 1 then
--     text_lines = " line"
--   end
--
--   -- table.insert(text, { " - " .. n_lines .. text_lines, { "Folded" } })
--
--   -- return text
--   return "afahjk fklashfkahjsf khjad "
-- end

-- sessions
-- opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

-- updatetime(trigger CursorHold to highlight matching word)
-- opt.updatetime = 500

-- spellcheck
opt.spell = true
opt.spelllang = "en"
opt.spellsuggest = "best,9"

opt.list = true
opt.listchars = {
  trail = "·",
  lead = "·", -- TODO: think how to deal with indent-blankline
  tab = ">-",
  extends = ">",
  precedes = "<",
}

-- Custom filetypes
vim.filetype.add({
  filename = {},
  pattern = {
    ["git/config"] = "gitconfig",
    [".*/%.kube/config"] = "yaml",
  },
})
