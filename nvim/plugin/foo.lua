-- helper functions
local pad_right = function(s, n)
  return s .. string.rep(" ", n - #s)
end

---get same named property of all tables in a list
---@param prop string property name
---@param list table[] list of tables
---@return any[]
local pluck = function(prop, list)
  return vim.tbl_map(function(item)
    return item[prop]
  end, list)
end
local clamp = function(val, min, max)
  return math.min(math.max(val, min), max)
end

---get max length of strings in an array of string
---@param list string[]
---@return integer
local get_max_length = function(list)
  if #list == 0 then
    return 0
  end
  local max = #list[1]
  for i = 2, #list do
    if #list[i] > max then
      max = #list[i]
    end
  end
  return max
end

local dictionary = "sadflewcmpghio"
local keymaps = {
  ["<Esc>"] = "close",
  ["q"] = "close",
  ["H"] = "open_split",
  ["V"] = "open_vsplit",
  ["D"] = "close_buffer",
  ["<cr>"] = "open_buffer",
}

local mocha = require("catppuccin.palettes").get_palette("mocha")
local highlight_groups = {
  anchor = { name = "FooAnchor", definition = { fg = mocha.peach, bold = true } },
  filename = { name = "FooFilename", definition = { link = "Normal" } },
  dirname = { name = "FooDirname", definition = { link = "Comment" } },
}

local get_buffer_filename = function(line)
  local start_quote = line:find('"')
  local end_quote = #line - line:reverse():find('"')
  return line:sub(start_quote + 1, end_quote)
end

local get_buffers = function()
  local ls_output = vim.api.nvim_cmd({ cmd = "ls" }, { output = true })
  local ls_lines = vim.split(ls_output, "\n", { trimempty = true })
  local buffers = {}
  for _, line in ipairs(ls_lines) do
    local id = tonumber(vim.split(line, " ", { trimempty = true })[1])
    local name = get_buffer_filename(line)
    table.insert(buffers, {
      id = id,
      name = name,
      is_dir = vim.fn.isdirectory(vim.api.nvim_buf_get_name(id)),
      basename = vim.fs.basename(name),
      dirname = vim.fs.dirname(name),
    })
  end
  return buffers
end

local create_highlight_groups = function()
  local ns = vim.api.nvim_create_namespace("foo")
  for _, hlgroup in pairs(highlight_groups) do
    vim.api.nvim_set_hl(ns, hlgroup.name, hlgroup.definition)
  end
  return ns
end

local create_buffer = function()
  local bufnr = vim.api.nvim_create_buf(false, false)
  vim.bo[bufnr].filetype = "foo-type"
  vim.bo[bufnr].buflisted = false
  vim.bo[bufnr].buftype = "nofile" -- ensures no "unsaved changes" popup
  return bufnr
end

local create_window = function(buf, win_opts)
  local win = vim.api.nvim_open_win(buf, true, {
    anchor = "NW",
    row = 0,
    col = 0,
    width = win_opts.width,
    height = win_opts.height,
    title = "Foo",
    border = "rounded",
    style = "minimal",
    relative = "editor",
    zindex = 99,
  })
  vim.wo[win].foldenable = false
  vim.wo[win].wrap = false
  vim.wo[win].cursorline = true
  return win
end

local write_buffer = function(bufnr, lines)
  vim.bo[bufnr].modifiable = true
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
  vim.bo[bufnr].modifiable = false
end

local assign_anchors = function(buffers)
  -- TODO: check if #buffers is higher than #dictionary
  for i = 1, #buffers do
    buffers[i].anchor = dictionary:sub(i, i)
  end
end

local get_max_line_length = function(lines)
  return get_max_length(lines)
end

local format_filenames = function(buffers)
  local max_filename_length = get_max_length(pluck("basename", buffers))
  for _, buffer in pairs(buffers) do
    buffer.formatted_name = pad_right(buffer.basename, max_filename_length)
  end
  -- return vim.tbl_map(function(buf)
  --   return vim.tbl_extend("keep", buf, { formatted_name = pad_right(buf.basename, max_filename_length) })
  -- end, buffers)
end

local format_lines = function(buffers)
  for _, buffer in pairs(buffers) do
    ---@type {text: string, hlgroup: string}[]
    local format = {
      { text = buffer.anchor, hlgroup = highlight_groups.anchor.name },
      { text = buffer.icon.symbol, hlgroup = buffer.icon.hlgroup },
      { text = buffer.formatted_name, hlgroup = highlight_groups.filename.name },
      { text = buffer.dirname, hlgroup = highlight_groups.dirname.name },
    }
    local delimeter = " "
    local line_text = pluck("text", format)
    local line = table.concat(line_text, delimeter)

    ---@type {first: integer, last: integer, hlgroup: string}[]
    local highlights = {}
    for i = 1, #format do
      local first = 0
      if i >= 2 then
        first = highlights[i - 1].last + #delimeter
      end
      highlights[i] = {
        first = first,
        last = first + #format[i].text,
        hlgroup = format[i].hlgroup,
      }
    end
    buffer.line = line
    buffer.highlights = highlights
  end
  -- return vim.tbl_map(function(buf)
  --   ---@type {text: string, hlgroup: string}[]
  --   local format = {
  --     { text = buf.anchor, hlgroup = highlight_groups.anchor.name },
  --     { text = buf.icon.symbol, hlgroup = buf.icon.hlgroup },
  --     { text = buf.formatted_name, hlgroup = highlight_groups.filename.name },
  --     { text = buf.dirname, hlgroup = highlight_groups.dirname.name },
  --   }
  --   local delimeter = " "
  --   local line_text = pluck("text", format)
  --   local line = table.concat(line_text, delimeter)
  --
  --   ---@type {first: integer, last: integer, hlgroup: string}[]
  --   local highlights = {}
  --   for i = 1, #format do
  --     local first = 0
  --     if i >= 2 then
  --       first = highlights[i - 1].last + #delimeter
  --     end
  --     highlights[i] = {
  --       first = first,
  --       last = first + #format[i].text,
  --       hlgroup = format[i].hlgroup,
  --     }
  --   end
  --
  --   return vim.tbl_extend("keep", buf, {
  --     line = line,
  --     highlights = highlights,
  --   })
  -- end, buffers)
end

local get_lines = function(buffers)
  return vim.tbl_map(function(buf)
    return buf.line
  end, buffers)
end

local add_highlights = function(bufnr, ns, buffer_list)
  for i = 1, #buffer_list.items do
    for _, hl_config in ipairs(buffer_list.items[i].highlights) do
      vim.api.nvim_buf_add_highlight(bufnr, ns, hl_config.hlgroup, i - 1, hl_config.first, hl_config.last)
    end
  end
end

local add_filetype_icons = function(buffers)
  vim.print("format_filenames start")
  vim.print("len" .. #buffers)
  vim.print(buffers)
  vim.print("format_filenames end")
  for _, buffer in pairs(buffers) do
    if _G.MiniIcons then
      local icon, hl = MiniIcons.get("file", buffer.basename)
      buffer.icon = { symbol = icon, hlgroup = hl }
    end
  end
  -- return vim.tbl_map(function(buf)
  --   if _G.MiniIcons then
  --     local icon, hl = MiniIcons.get("file", buf.basename)
  --     return vim.tbl_extend("keep", buf, {
  --       icon = { symbol = icon, hlgroup = hl },
  --     })
  --   end
  --   return buf
  -- end, buffers)
end

local get_buffer_list = function()
  local buffers = get_buffers()
  assign_anchors(buffers)
  format_filenames(buffers)
  add_filetype_icons(buffers)
  format_lines(buffers)
  return buffers
end

---@class BufferList
local BufferList = {
  items = {},
}
BufferList.__index = BufferList
function BufferList:new()
  local o = setmetatable({}, self)
  o.__index = self
  self:refresh()
  return o
end
function BufferList:refresh()
  self.items = self:list_buffers()
  self:assign_anchors()
  self:add_filetype_icons()
  self:format_filenames()
  self:format_lines()
end
function BufferList:list_buffers()
  local ls_output = vim.api.nvim_cmd({ cmd = "ls" }, { output = true })
  local ls_lines = vim.split(ls_output, "\n", { trimempty = true })
  local buffers = {}
  for _, line in ipairs(ls_lines) do
    local id = tonumber(vim.split(line, " ", { trimempty = true })[1])
    local name = get_buffer_filename(line)
    table.insert(buffers, {
      id = id,
      name = name,
      is_dir = vim.fn.isdirectory(vim.api.nvim_buf_get_name(id)),
      basename = vim.fs.basename(name),
      dirname = vim.fs.dirname(name),
    })
  end
  return buffers
end
function BufferList:assign_anchors()
  for i = 1, #self.items do
    self.items[i].anchor = dictionary:sub(i, i)
  end
end
function BufferList:format_filenames()
  local max_filename_length = get_max_length(pluck("basename", self.items))
  for _, buffer in pairs(self.items) do
    buffer.formatted_name = pad_right(buffer.basename, max_filename_length)
  end
end
function BufferList:add_filetype_icons()
  for _, buffer in pairs(self.items) do
    if _G.MiniIcons then
      local icon, hl = MiniIcons.get("file", buffer.basename)
      buffer.icon = { symbol = icon, hlgroup = hl }
    end
  end
end
function BufferList:format_lines()
  for _, buffer in pairs(self.items) do
    ---@type {text: string, hlgroup: string}[]
    local format = {
      { text = buffer.anchor, hlgroup = highlight_groups.anchor.name },
      { text = buffer.icon.symbol, hlgroup = buffer.icon.hlgroup },
      { text = buffer.formatted_name, hlgroup = highlight_groups.filename.name },
      { text = buffer.dirname, hlgroup = highlight_groups.dirname.name },
    }
    local delimeter = " "
    local line_text = pluck("text", format)
    local line = table.concat(line_text, delimeter)

    ---@type {first: integer, last: integer, hlgroup: string}[]
    local highlights = {}
    for i = 1, #format do
      local first = 0
      if i >= 2 then
        first = highlights[i - 1].last + #delimeter
      end
      highlights[i] = {
        first = first,
        last = first + #format[i].text,
        hlgroup = format[i].hlgroup,
      }
    end
    buffer.line = line
    buffer.highlights = highlights
  end
end
function BufferList:get_max_line_length()
  return get_max_length(self:get_lines())
end
function BufferList:get_lines()
  return pluck("line", self.items)
end

---@class Menu
local Menu = {
  ns = nil,
  buffer = nil,
  win = nil,
  ---@type BufferList
  buffer_list = nil,
}
Menu.__index = Menu
function Menu:new(buffer_list)
  local o = setmetatable({}, self)
  o.__index = self
  self.ns = create_highlight_groups()
  self.buffer = create_buffer()
  self.buffer_list = buffer_list
  return o
end
function Menu:open()
  self:render()
end
function Menu:close()
  vim.api.nvim_win_close(self.win, true)
  self.win = nil
end
function Menu:render()
  self.buffer_list:refresh()
  local lines = self.buffer_list:get_lines()
  local max_line_length = self.buffer_list:get_max_line_length()
  local window_exists = self.win ~= nil
  if not window_exists then
    self.win = create_window(self.buffer, { width = max_line_length, height = #lines })
  else
    vim.api.nvim_win_set_height(self.win, #lines)
    vim.api.nvim_win_set_width(self.win, max_line_length)
  end
  write_buffer(self.buffer, lines)
  if not window_exists then
    vim.api.nvim_win_set_hl_ns(self.win, self.ns)
    vim.api.nvim_set_current_win(self.win)
    self:bind_keymaps()
  else
    vim.api.nvim_buf_clear_namespace(self.buffer, self.ns, 0, #lines)
  end

  add_highlights(self.buffer, self.ns, self.buffer_list)
  self:bind_anchor_keymaps()
end
function Menu:bind_keymaps()
  local get_hovered_buf_id = function(win, buffer_list)
    local cursor_position = vim.api.nvim_win_get_cursor(win)
    local row = cursor_position[1]
    local hovered_buf = buffer_list.items[row]
    return hovered_buf.id
  end
  local actions = {
    close = function(win)
      self:close()
    end,
    close_buffer = function()
      -- TODO: handle current buffer(can't be closed)
      local id = get_hovered_buf_id(self.win, self.buffer_list)
      local cursor_position = vim.api.nvim_win_get_cursor(self.win)
      vim.api.nvim_cmd({ cmd = "bdelete", args = { id } }, { output = false })
      self:render()
      cursor_position[1] = clamp(cursor_position[1], 1, vim.api.nvim_win_get_height(self.win))
      cursor_position[2] = clamp(cursor_position[2], 0, vim.api.nvim_win_get_width(self.win))
      vim.api.nvim_win_set_cursor(self.win, { 1, 0 })
      vim.api.nvim_win_set_cursor(self.win, cursor_position)
      vim.api.nvim_win_set_cursor(self.win, cursor_position)
    end,
    open_buffer = function()
      local id = get_hovered_buf_id(self.win, self.buffer_list)
      self:close()
      vim.api.nvim_set_current_buf(id)
    end,
    open_split = function()
      local id = get_hovered_buf_id(self.win, self.buffer_list)
      self:close()
      vim.api.nvim_open_win(id, true, { win = 0, split = "below" })
    end,
    open_vsplit = function()
      local id = get_hovered_buf_id(self.win, self.buffer_list)
      self:close()
      vim.api.nvim_open_win(id, true, { vertical = true, win = 0 })
    end,
  }
  for key, action in pairs(keymaps) do
    vim.keymap.set("n", key, function()
      actions[action]()
    end, { buffer = self.buffer })
  end
end

function Menu:bind_anchor_keymaps()
  for _, buf in ipairs(self.buffer_list.items) do
    vim.keymap.set("n", buf.anchor, function()
      self:close()
      vim.api.nvim_set_current_buf(buf.id)
    end, { buffer = self.buffer })
  end
end

local Foo = {}

Foo.setup = function()
  local menu = Menu:new(BufferList:new())
  vim.keymap.set("n", "<leader>v", function()
    menu:open()
  end)
end

Foo.setup()

-- local ns = create_highlight_groups()
-- vim.keymap.set("n", "<leader>v", function()
--   local buffer_list = BufferList:new()
--   local bufnr = create_buffer()
--   local lines = buffer_list:get_lines()
--   local max_line_length = buffer_list:get_max_line_length()
--   local win = create_window(bufnr, { width = max_line_length, height = #lines })
--   write_buffer(bufnr, lines)
--   vim.api.nvim_win_set_hl_ns(win, ns)
--   add_highlights(bufnr, ns, buffer_list)
--   vim.api.nvim_set_current_win(win)
--
--   bind_keymaps(win, bufnr, buffer_list)
--   bind_anchor_keymaps(win, bufnr, buffer_list)
-- end, {})

-- for _, buf in ipairs(buffers) do
--   log(vim.api.nvim_buf_get_name(buf))
-- end
-- log(vim.uv.cwd())
-- vim.fn.is

-- for _, buf in ipairs(buffers) do
--   local loaded = vim.api.nvim_buf_is_loaded(buf)
--   local listed = vim.api.nvim_get_option_value("buflisted", { buf = buf })
--   log({ buf = buf, loaded = loaded, listed = listed })
-- end
-- for _, buf in ipairs(buffers) do
--   if
--     vim.api.nvim_buf_is_loaded(buf)
--     and vim.api.nvim_buf_get_name(buf) == ""
--     and vim.api.nvim_buf_get_option(buf, "buftype") == ""
--     and vim.api.nvim_buf_get_option(buf, "buflisted")
--   then
--     local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
--     if #lines == 1 and #lines[1] == 0 then
--       vim.api.nvim_buf_delete(buf, {})
--       print("deleted empty buffer")
--     end
--   end
return Foo
