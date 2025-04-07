---@type Wezterm
local wezterm = require("wezterm")

---@class Config
local config = wezterm.config_builder()

-- Spawn a fish shell in login mode
config.default_prog = { "/usr/local/bin/fish", "-l" }

-- colorscheme
-- config.color_scheme = "Catppuccin Mocha (Gogh)" -- black tabs
config.color_scheme = "Catppuccin Mocha"

-- font
-- config.font = wezterm.font("FiraCode Nerd Font")
-- config.font = wezterm.font("GeistMono Nerd Font")
config.font = wezterm.font_with_fallback({ "SF Mono", "FiraCode Nerd Font" })
config.font_size = 16

-- window appearance
-- config.window_decorations = "MACOS_FORCE_ENABLE_SHADOW|INTEGRATED_BUTTONS|RESIZE"
-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_decorations = "MACOS_FORCE_ENABLE_SHADOW|RESIZE"
config.window_close_confirmation = "AlwaysPrompt"
config.enable_scroll_bar = true
config.window_background_opacity = 0.93
config.macos_window_background_blur = 40
config.window_padding = {
  left = 10,
  bottom = 0,
  top = 10,
  right = 0,
}

-- tabbar
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.prefer_to_spawn_tabs = true
config.tab_max_width = 32
config.tab_bar_at_bottom = false
config.show_new_tab_button_in_tab_bar = false

-- cursor
config.cursor_blink_rate = 500
config.cursor_thickness = "200%"

-- inactive panes
config.inactive_pane_hsb = {
  saturation = 0.7,
  brightness = 0.3,
}

-- command palette
config.command_palette_font_size = 16

config.keys = {
  -- create "panes" as in iTerm
  {
    key = "d",
    mods = "SUPER",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "D",
    mods = "SUPER",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  -- close pane, then tab, then window
  {
    key = "w",
    mods = "CMD",
    action = wezterm.action.CloseCurrentPane({ confirm = true }),
  },
  -- zoom panel
  {
    key = "F",
    mods = "CMD|SHIFT",
    action = wezterm.action.TogglePaneZoomState,
  },
  -- tab navigation
  {
    key = "[",
    mods = "CMD",
    action = wezterm.action.ActivateTabRelative(-1),
  },
  {
    key = "]",
    mods = "CMD",
    action = wezterm.action.ActivateTabRelative(1),
  },
  -- tab reordering
  {
    key = "[",
    mods = "CMD|SHIFT",
    action = wezterm.action.MoveTabRelative(-1),
  },
  {
    key = "]",
    mods = "CMD|SHIFT",
    action = wezterm.action.MoveTabRelative(1),
  },
  -- command palette(as in Sublime Text, waay too old)
  {
    key = "p",
    mods = "SUPER|SHIFT",
    action = wezterm.action.ActivateCommandPalette,
  },
  -- pane selection
  {
    key = "p",
    mods = "SUPER",
    action = wezterm.action.PaneSelect,
  },
  -- pane swap
  {
    key = "s",
    mods = "SUPER",
    action = wezterm.action.PaneSelect({
      mode = "SwapWithActiveKeepFocus",
    }),
  },

  -- pane rotation
  {
    key = "r",
    mods = "SUPER",
    action = wezterm.action.RotatePanes("Clockwise"),
  },
  {
    key = "r",
    mods = "SUPER|SHIFT",
    action = wezterm.action.RotatePanes("CounterClockwise"),
  },
  -- disable full-screen toggle by ALT+Enter
  {
    key = "Enter",
    mods = "ALT",
    action = wezterm.action.DisableDefaultAssignment,
  },
}

-- status
config.status_update_interval = 1000
wezterm.on("update-status", function(window, pane)
  local status = ""
  -- current workspace and number of workspaces
  status = wezterm.nerdfonts.oct_table .. " " .. window:active_workspace()
  local numberOfWorkspaces = #wezterm.mux.get_workspace_names()
  if numberOfWorkspaces > 1 then
    status = status .. " [" .. numberOfWorkspaces .. "]"
  end
  -- active key table
  if window:active_key_table() then
    status = status .. window:active_key_table()
  end

  -- make it italic
  window:set_right_status(wezterm.format({
    { Attribute = { Italic = true } },
    { Text = status .. " " },
  }))
end)

-- format and color tab bar
local colors = {
  active = "#cba6f7",
  focused = "#fab387",
  inactive = "#313244",
  background = "#1e1e2e",
  text_on_dark = "#cdd6f4",
  text_on_light = "#1e1e2e",
}
config.colors = {
  tab_bar = {
    background = colors.background,
  },
}

local list_concat = function(...)
  local result = {}
  local lists = { ... }
  for _, list in ipairs(lists) do
    for _, value in ipairs(list) do
      table.insert(result, value)
    end
  end
  return result
end

wezterm.on("format-tab-title", function(tab)
  local panel_title = tab.active_pane.title
  local tab_index = tab.tab_index + 1

  -- define background/foreground colors
  local background = colors.inactive
  local foreground = colors.text_on_dark
  if tab.is_active and not tab.active_pane.is_zoomed then
    background = colors.active
    foreground = colors.text_on_light
  end
  if tab.active_pane.is_zoomed then
    if tab.is_active then
      background = colors.focused
      foreground = colors.text_on_light
    else
      background = colors.inactive
      foreground = colors.focused
    end
  end
  -- set start/end symbols
  local start_symbol_text = wezterm.nerdfonts.ple_left_half_circle_thick
  local end_symbol_text = wezterm.nerdfonts.ple_right_half_circle_thick .. " "
  -- local start_symbol_text = wezterm.nerdfonts.ple_lower_right_triangle
  -- local end_symbol_text = wezterm.nerdfonts.ple_upper_left_triangle
  local start_symbol = {
    { Background = { Color = colors.background } },
    { Foreground = { Color = background } },
    { Text = start_symbol_text },
  }
  local end_symbol = {
    { Background = { Color = colors.background } },
    { Foreground = { Color = background } },
    { Text = end_symbol_text },
  }
  -- define
  local main_style = {
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
  }
  -- truncate title
  local total_width_of_symbols = 3 + #tostring(tab_index) + 5 -- make more space on the right
  local max_title_width = config.tab_max_width - total_width_of_symbols
  if #panel_title > max_title_width then
    panel_title = panel_title:sub(1, max_title_width - 3) .. ""
  end

  local title = { { Text = tab_index .. ": " .. panel_title } }
  if tab.active_pane.is_zoomed then
    title = list_concat({ { Text = wezterm.nerdfonts.oct_screen_full .. " " } }, title)
  end

  return list_concat(start_symbol, main_style, title, end_symbol)
  -- add highlight for panes with unseen output
  -- doesn't work well with nvim(it always has unseen output)
  -- might add a check for nvim specifically
  -- but what about other(vim, yazi, k8s, other tui's) will it work? need to investigate
  -- local has_unseen_output = false
  -- for _, pane in ipairs(tab.panes) do
  --   if pane.has_unseen_output then
  --     has_unseen_output = true
  --     break
  --   end
  -- end
  -- if has_unseen_output then
  --   return {
  --     { Background = { Color = "#f5e0dc" } },
  --     { Foreground = { Color = "#11111b" } },
  --     { Text = " " .. tab_index .. ": " },
  --     { Text = panel_title .. " " },
  --   }
  -- end
end)

-- pane navigation between Wezterm and Neovim
local function add_pane_nav_keys()
  local pane_nav_mods = "CTRL|SHIFT"

  -- map of { key = direction }
  local pane_nav_keys = {
    UpArrow = "Up",
    DownArrow = "Down",
    LeftArrow = "Left",
    RightArrow = "Right",
  }

  local is_vim = function(pane)
    local process_info = pane:get_foreground_process_info()
    local process_name = process_info and process_info.name
    return process_name == "nvim" or process_name == "vim"
  end

  local try_nav_pane = function(key, direction, win, pane)
    if is_vim(pane) then
      -- pass the keys through to vim/nvim
      win:perform_action({
        SendKey = { key = key, mods = pane_nav_mods },
      }, pane)
    else
      win:perform_action({ ActivatePaneDirection = direction }, pane)
    end
  end

  for key, direction in pairs(pane_nav_keys) do
    -- alternative is:
    -- action = wezterm.action_callback(function(win, pane)
    --   try_nav_pane(key, direction, win, pane)
    -- end),
    -- but for some reason, events are messed up, need to investigate further
    wezterm.on("nav-" .. key .. direction, function(win, pane)
      try_nav_pane(key, direction, win, pane)
    end)
    table.insert(config.keys, {
      key = key,
      mods = pane_nav_mods,
      action = wezterm.action.EmitEvent("nav-" .. key .. direction),
    })
  end
end
add_pane_nav_keys()

return config
