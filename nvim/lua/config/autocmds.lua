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
local empty_buf_delete_augroup = vim.api.nvim_create_augroup("emptybufdelete", {})
vim.api.nvim_create_autocmd({ "BufLeave" }, {
  pattern = "*",
  group = empty_buf_delete_augroup,
  callback = function()
    local buffers = vim.api.nvim_list_bufs()
    for _, buf in ipairs(buffers) do
      if
        vim.api.nvim_buf_is_loaded(buf)
        and vim.api.nvim_buf_get_name(buf) == ""
        and vim.api.nvim_buf_get_option(buf, "buftype") == ""
        and vim.api.nvim_buf_get_option(buf, "buflisted")
      then
        local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        if #lines == 1 and #lines[1] == 0 then
          vim.api.nvim_buf_delete(buf, {})
          print("deleted empty bufffer")
        end
      end
    end
  end,
})

-- open telescope by default instead of netrw
-- https://github.com/nvim-telescope/telescope.nvim/issues/2806
local find_files_on_startup = vim.api.nvim_create_augroup("find_files_on_startup", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
  group = find_files_on_startup,
  pattern = "*",
  callback = function()
    if vim.fn.isdirectory(vim.fn.expand("%:p")) ~= 0 then
      -- open Telescope
      -- local current_dir = vim.fn.expand("%:p:h")
      -- require("telescope.builtin").find_files({ cwd = current_dir })

      -- open Dashboard
      Snacks.dashboard.open()
    end
  end,
})
