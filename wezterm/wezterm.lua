---@type Wezterm
local wezterm = require("wezterm")
local act = wezterm.action

---@class Config
local config = wezterm.config_builder()

-- colorscheme
-- config.color_scheme = "Catppuccin Mocha (Gogh)" -- black tabs
config.color_scheme = "Catppuccin Mocha"

-- font
-- config.font = wezterm.font("FiraCode Nerd Font")
-- config.font = wezterm.font("GeistMono Nerd Font")
-- config.font = wezterm.font_with_fallback({ "SF Mono", "FiraCode Nerd Font" })
-- config.font = wezterm.font("Maple Mono NF")
-- config.font = wezterm.font("PT Mono")
-- config.font = wezterm.font("Monaco")
-- config.font = wezterm.font({ "JetBrains Mono" })
config.font = wezterm.font("JetBrainsMono Nerd Font")

config.font_size = 15
config.line_height = 1.2

-- window appearance
-- config.window_decorations = "MACOS_FORCE_ENABLE_SHADOW|INTEGRATED_BUTTONS|RESIZE"
-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_decorations = "MACOS_FORCE_ENABLE_SHADOW|RESIZE"
config.window_close_confirmation = "AlwaysPrompt"
config.enable_scroll_bar = true
config.scrollback_lines = 20000
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
  brightness = 0.5,
}

-- command palette
config.command_palette_font_size = 18

config.keys = {
  -- create "panes" as in iTerm
  {
    key = "d",
    mods = "CMD",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "d",
    mods = "CMD|SHIFT",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  -- zoom panel
  {
    key = "f",
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
    mods = "CMD|SHIFT",
    action = wezterm.action.ActivateCommandPalette,
  },

  -- pane swap
  {
    key = "s",
    mods = "CMD",
    action = wezterm.action.PaneSelect({
      mode = "SwapWithActiveKeepFocus",
    }),
  },

  -- pane rotation
  {
    key = "r",
    mods = "CMD",
    action = wezterm.action.RotatePanes("Clockwise"),
  },
  {
    key = "r",
    mods = "CMD|SHIFT",
    action = wezterm.action.RotatePanes("CounterClockwise"),
  },
  -- disable full-screen toggle by ALT+Enter
  {
    key = "Enter",
    mods = "ALT",
    action = wezterm.action.DisableDefaultAssignment,
  },

  -- playground
  {
    key = "o",
    mods = "CMD|SHIFT",
    action = wezterm.action.PromptInputLine({
      description = "Enter new name for tab",
      -- initial_value = "My Tab Name",
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    }),
  },

  -- modal key tables (zellij-style)
  {
    key = "t",
    mods = "CMD",
    action = act.ActivateKeyTable({
      name = "tab_mode",
      one_shot = false,
      prevent_fallback = true,
    }),
  },
  {
    key = "p",
    mods = "CMD",
    action = act.ActivateKeyTable({
      name = "pane_mode",
      one_shot = true,
      prevent_fallback = true,
    }),
  },
  {
    key = "w",
    mods = "CMD",
    action = act.ActivateKeyTable({
      name = "workspace_mode",
      one_shot = true,
      prevent_fallback = true,
    }),
  },
}

local function mode_help(mode_name)
  return wezterm.action_callback(function(window, pane)
    local choices = {}
    for _, entry in ipairs(config.key_tables[mode_name]) do
      if entry.desc then
        local keys = entry.keys or entry.key
        table.insert(choices, { label = keys .. " \t " .. entry.desc })
      end
    end
    window:perform_action(
      act.InputSelector({
        title = mode_name,
        choices = choices,
        fuzzy = true,
        action = wezterm.action_callback(function() end),
      }),
      pane
    )
  end)
end

-- modal key tables
local pane_resize_step = 3
config.key_tables = {
  tab_mode = {
    { key = "h", keys = "hl", desc = "navigate tabs", action = act.ActivateTabRelative(-1) },
    { key = "l", action = act.ActivateTabRelative(1) },

    { key = "n", desc = "new tab", action = act.Multiple({ act.SpawnTab("CurrentPaneDomain"), "PopKeyTable" }) },
    {
      key = "x",
      desc = "close tab",
      action = act.Multiple({ act.CloseCurrentTab({ confirm = true }), "PopKeyTable" }),
    },

    {
      key = "r",
      desc = "rename tab",
      action = act.Multiple({
        act.PromptInputLine({
          description = "Enter new name for tab",
          action = wezterm.action_callback(function(window, _, line)
            if line then
              window:active_tab():set_title(line)
            end
          end),
        }),
        "PopKeyTable",
      }),
    },

    { key = "H", keys = "HL", desc = "reorder tab", action = act.MoveTabRelative(-1) },
    { key = "L", action = act.MoveTabRelative(1) },

    { key = "s", desc = "tab list", action = act.Multiple({ "ShowTabNavigator", "PopKeyTable" }) },

    { key = "?", desc = "help", action = mode_help("tab_mode") },
    { key = "Escape", action = "PopKeyTable" },
  },

  pane_mode = {
    { key = "h", keys = "hjkl", desc = "navigate panes", action = act.ActivatePaneDirection("Left") },
    { key = "j", action = act.ActivatePaneDirection("Down") },
    { key = "k", action = act.ActivatePaneDirection("Up") },
    { key = "l", action = act.ActivatePaneDirection("Right") },

    { key = "d", desc = "split vertical", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "v", desc = "split horizontal", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "n", desc = "new pane", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

    { key = "x", desc = "close pane", action = act.CloseCurrentPane({ confirm = true }) },
    { key = "z", desc = "toggle zoom", action = act.TogglePaneZoomState },

    { key = "Space", keys = "␣", desc = "select pane", action = act.PaneSelect },
    { key = "s", desc = "swap pane", action = act.PaneSelect({ mode = "SwapWithActiveKeepFocus" }) },

    { key = "o", keys = "oO", desc = "rotate panes", action = act.RotatePanes("Clockwise") },
    { key = "O", action = act.RotatePanes("CounterClockwise") },

    {
      key = "r",
      desc = "resize mode",
      action = act.ActivateKeyTable({
        name = "resize_pane",
        one_shot = false,
        replace_current = true,
        prevent_fallback = true,
      }),
    },

    { key = "?", desc = "help", action = mode_help("pane_mode") },
    { key = "Escape", action = "PopKeyTable" },
  },

  resize_pane = {
    { key = "h", keys = "hjkl", desc = "resize pane", action = act.AdjustPaneSize({ "Left", pane_resize_step }) },
    { key = "j", action = act.AdjustPaneSize({ "Down", pane_resize_step }) },
    { key = "k", action = act.AdjustPaneSize({ "Up", pane_resize_step }) },
    { key = "l", action = act.AdjustPaneSize({ "Right", pane_resize_step }) },
    { key = "H", keys = "HJKL", desc = "resize fine", action = act.AdjustPaneSize({ "Left", 1 }) },
    { key = "J", action = act.AdjustPaneSize({ "Down", 1 }) },
    { key = "K", action = act.AdjustPaneSize({ "Up", 1 }) },
    { key = "L", action = act.AdjustPaneSize({ "Right", 1 }) },

    { key = "?", desc = "help", action = mode_help("resize_pane") },
    { key = "Escape", action = "PopKeyTable" },
  },

  workspace_mode = {
    { key = "h", keys = "hl", desc = "prev/next workspace", action = act.SwitchWorkspaceRelative(-1) },
    { key = "l", action = act.SwitchWorkspaceRelative(1) },

    {
      key = "n",
      desc = "new workspace",
      action = act.PromptInputLine({
        description = "Enter name for new workspace",
        action = wezterm.action_callback(function(window, pane, line)
          if line and #line > 0 then
            window:perform_action(act.SwitchToWorkspace({ name = line }), pane)
          end
        end),
      }),
    },

    {
      key = "r",
      desc = "rename workspace",
      action = act.PromptInputLine({
        description = "Enter new name for workspace",
        action = wezterm.action_callback(function(window, pane, line)
          if line and #line > 0 then
            wezterm.mux.rename_workspace(window:active_workspace(), line)
          end
        end),
      }),
    },

    {
      key = "s",
      desc = "workspace list",
      action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
    },

    { key = "?", desc = "help", action = mode_help("workspace_mode") },
    { key = "Escape", action = "PopKeyTable" },
  },
}

-- status
config.status_update_interval = 1000

local mode_display = {
  tab_mode = { label = " TAB ", color = "#cba6f7" },
  pane_mode = { label = " PANE ", color = "#a6e3a1" },
  resize_pane = { label = " RESIZE ", color = "#f38ba8" },
  workspace_mode = { label = " WORKSPACE ", color = "#89b4fa" },
}

-- format and colors tab bar
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
wezterm.on("update-status", function(window, pane)
  local elements = {}

  local key_table = window:active_key_table()
  local mode = key_table and mode_display[key_table]
  if mode then
    table.insert(elements, { Background = { Color = colors.background } })
    table.insert(elements, { Foreground = { Color = mode.color } })
    table.insert(elements, { Text = wezterm.nerdfonts.ple_left_half_circle_thick })
    table.insert(elements, { Background = { Color = mode.color } })
    table.insert(elements, { Foreground = { Color = colors.text_on_light } })
    table.insert(elements, { Attribute = { Intensity = "Bold" } })
    table.insert(elements, { Text = mode.label })
    table.insert(elements, "ResetAttributes")
    table.insert(elements, { Background = { Color = colors.background } })
    table.insert(elements, { Foreground = { Color = mode.color } })
    table.insert(elements, { Text = wezterm.nerdfonts.ple_right_half_circle_thick })
    table.insert(elements, "ResetAttributes")
    table.insert(elements, { Text = " " })
  end

  local workspace = wezterm.nerdfonts.oct_table .. " " .. window:active_workspace()
  local num_workspaces = #wezterm.mux.get_workspace_names()
  if num_workspaces > 1 then
    workspace = workspace .. " [" .. num_workspaces .. "]"
  end

  table.insert(elements, { Attribute = { Italic = true } })
  table.insert(elements, { Text = workspace .. " " })

  window:set_right_status(wezterm.format(elements))
end)

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

local get_tab_title = function(tab_info)
  local title = tab_info.tab_title
  if title and #title > 0 then
    return title
  end
  if tab_info.active_pane.title and #tab_info.active_pane.title > 0 then
    return tab_info.active_pane.title
  end
  return "Tab #" .. (tab_info.tab_index + 1)
end

local truncate_tab_title = function(title, max_width)
  if wezterm.column_width(title) > max_width then
    return wezterm.truncate_right(title, max_width - 1) .. ""
  end
  return title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local title = get_tab_title(tab)

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
  local additional_symbols_length = wezterm.column_width(start_symbol_text) + wezterm.column_width(end_symbol_text)
  -- focused indicator
  local prefix = ""
  if tab.active_pane.is_zoomed then
    prefix = wezterm.nerdfonts.oct_screen_full .. " "
    additional_symbols_length = additional_symbols_length + 2 -- focused indicator and space
  end

  -- truncate title
  if max_width < additional_symbols_length then
    title = tostring(tab.tab_index + 1)
  else
    local max_title_width = max_width - additional_symbols_length
    title = truncate_tab_title(title, max_title_width)
    title = prefix .. title
  end

  local ws_title = { { Text = title } }
  return list_concat(start_symbol, main_style, ws_title, end_symbol)
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
    k = "Up",
    j = "Down",
    h = "Left",
    l = "Right",
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
