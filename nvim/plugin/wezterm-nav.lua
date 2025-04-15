-- similar to https://github.com/letieu/wezterm-move.nvim and https://github.com/mrjones2014/smart-splits.nvim
local wezterm_directions = { h = "Left", j = "Down", k = "Up", l = "Right" }

--- Check if the current window is at the edge of the screen
--- @param direction 'h' | 'j' | 'k' | 'l'
local function at_edge(direction)
  return vim.fn.winnr() == vim.fn.winnr(direction)
end

local function wezterm_exec(cmd)
  local command = vim.deepcopy(cmd)
  table.insert(command, 1, "wezterm")
  table.insert(command, 2, "cli")
  return vim.fn.system(command)
end

--- Send a key to wezterm
--- @param direction 'h' | 'j' | 'k' | 'l'
local function send_key_to_wezterm(direction)
  wezterm_exec({ "activate-pane-direction", wezterm_directions[direction] })
end

--- Try to move to the next pane in the given direction
--- @param direction 'h' | 'j' | 'k' | 'l'
local function try_move(direction)
  if at_edge(direction) then
    send_key_to_wezterm(direction)
  else
    vim.cmd("wincmd " .. direction)
  end
end

-- attach keymaps(same as wezterm)
vim.keymap.set("n", "<C-S-k>", function()
  try_move("k")
end)
vim.keymap.set("n", "<C-S-j>", function()
  try_move("j")
end)
vim.keymap.set("n", "<C-S-h>", function()
  try_move("h")
end)
vim.keymap.set("n", "<C-S-l>", function()
  try_move("l")
end)
