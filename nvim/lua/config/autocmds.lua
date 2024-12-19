-- Toggle relative numbers
-- from https://github.com/sitiom/nvim-numbertoggle/tree/main
local number_toggle_augroup = vim.api.nvim_create_augroup("numbertoggle", {})

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
  pattern = "*",
  group = number_toggle_augroup,
  callback = function()
    if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
      vim.opt.relativenumber = true
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
  pattern = "*",
  group = number_toggle_augroup,
  callback = function()
    if vim.o.nu then
      vim.opt.relativenumber = false
      vim.cmd("redraw")
    end
  end,
})

-- Delete empty buffers  automatically, such as after :enew
-- local empty_buf_delete_augroup = vim.api.nvim_create_augroup("emptybufdelete", {})
-- vim.api.nvim_create_autocmd({ "BufLeave" }, {
--   pattern = "*",
--   group = empty_buf_delete_augroup,
--   callback = function()
--     local buffers = vim.api.nvim_list_bufs()
--     for _, buf in ipairs(buffers) do
--       if
--         vim.api.nvim_buf_is_loaded(buf)
--         and vim.api.nvim_buf_get_name(buf) == ""
--         and vim.api.nvim_buf_get_option(buf, "buftype") == ""
--         and vim.api.nvim_buf_get_option(buf, "buflisted")
--       then
--         local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
--         if #lines == 1 and #lines[1] == 0 then
--           vim.api.nvim_buf_delete(buf, {})
--           print("deleted empty buffer")
--         end
--       end
--     end
--   end,
-- })

-- open telescope/dashboard/restore session by default instead of netrw
-- https://github.com/nvim-telescope/telescope.nvim/issues/2806
local startup = vim.api.nvim_create_augroup("startup", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
  group = startup,
  pattern = "*",
  callback = function()
    if vim.fn.isdirectory(vim.fn.expand("%:p")) ~= 0 or vim.fn.argc() == 0 and not vim.g.started_with_stdin then
      -- open Telescope
      -- local current_dir = vim.fn.expand("%:p:h")
      -- require("telescope.builtin").find_files({ cwd = current_dir })

      -- open Dashboard
      -- Snacks.dashboard.open()

      -- load last session
      require("persistence").load()
    end
  end,
  nested = true,
})

-- highlight CursorLineNr with mode colors from lualine
local set_cursorlinenr_highlight_based_on_mode = function()
  local modes_map = {
    n = "normal",
    i = "insert",
    v = "visual",
    V = "visual",
    c = "command",
    R = "replace",
  }
  local mode = vim.api.nvim_get_mode().mode
  local hl_name = modes_map[mode] or "normal"
  vim.api.nvim_set_hl(0, "CursorLineNr", { link = "lualine_b_" .. hl_name })
end
local cursorlinenr_hightlight_augroup = vim.api.nvim_create_augroup("cursorlinenrhighlight", {})
vim.api.nvim_create_autocmd("ModeChanged", {
  group = cursorlinenr_hightlight_augroup,
  callback = set_cursorlinenr_highlight_based_on_mode,
})
vim.api.nvim_create_autocmd("VimEnter", {
  group = cursorlinenr_hightlight_augroup,
  callback = set_cursorlinenr_highlight_based_on_mode,
})

-- auto load last session for current_dir
-- from https://github.com/folke/persistence.nvim/issues/13
-- vim.api.nvim_create_autocmd("VimEnter", {
--   group = vim.api.nvim_create_augroup("persistence", { clear = true }),
--   callback = function()
--     -- NOTE: Before restoring the session, check:
--     -- 1. No arg passed when opening nvim, means no `nvim --some-arg ./some-path`
--     -- 2. No pipe, e.g. `echo "Hello world" | nvim`
--     if vim.fn.argc() == 0 and not vim.g.started_with_stdin then
--       require("persistence").load()
--     end
--   end,
--   -- HACK: need to enable `nested` otherwise the current buffer will not have a filetype(no syntax)
--   nested = true,
-- })
