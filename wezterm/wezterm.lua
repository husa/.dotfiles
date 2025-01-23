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
config.font = wezterm.font("GeistMono Nerd Font")
config.font_size = 15

-- window appearance
-- config.window_decorations = "MACOS_FORCE_ENABLE_SHADOW|INTEGRATED_BUTTONS|RESIZE"
-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_decorations = "MACOS_FORCE_ENABLE_SHADOW|RESIZE"
config.window_close_confirmation = "AlwaysPrompt"
config.enable_scroll_bar = true
config.window_background_opacity = 0.9
config.macos_window_background_blur = 40

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
wezterm.on("format-tab-title", function(tab)
  local panel_title = tab.active_pane.title
  local tab_index = tab.tab_index + 1
  local title = { Text = " " .. tab_index .. ": " .. panel_title .. " " }
  if tab.is_active and not tab.active_pane.is_zoomed then
    return { title }
  end
  if tab.active_pane.is_zoomed then
    if tab.is_active then
      return {
        { Background = { Color = "#fab387" } },
        { Foreground = { Color = "#11111b" } },
        title,
        { Text = wezterm.nerdfonts.oct_screen_full .. "  " },
      }
    else
      return {
        { Foreground = { Color = "#fab387" } },
        title,
        { Text = wezterm.nerdfonts.oct_screen_full .. "  " },
      }
    end
  end

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
  return { title }
end)

return config
