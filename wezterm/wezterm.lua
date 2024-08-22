local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Spawn a fish shell in login mode
config.default_prog = { "/usr/local/bin/fish", "-l" }

-- colorscheme
config.color_scheme = "Catppuccin Mocha"

-- font
config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 14

-- window appearance
-- config.window_decorations = "MACOS_FORCE_ENABLE_SHADOW|INTEGRATED_BUTTONS|RESIZE"
-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_decorations = "RESIZE"
config.window_close_confirmation = "AlwaysPrompt"
config.enable_scroll_bar = true
config.window_background_opacity = 0.9
config.macos_window_background_blur = 40

-- tabbar
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false

-- experiment

-- wezterm.on("update-right-status", function(window)
-- 	local cwd = window:get_current_tab().cwd
-- 	local cwd_uri = cwd
-- 	window:set_right_status({ Text = "yoo" })
-- end)

config.cursor_blink_rate = 500
config.cursor_thickness = "200%"

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
	-- command palette(as in Sublime Text, waay too old)
	{
		key = "p",
		mods = "SUPER|SHIFT",
		action = wezterm.action.ActivateCommandPalette,
	},
}

wezterm.on("update-right-status", function(window, pane)
	local date = wezterm.strftime("%Y-%m-%d %H:%M:%S")

	-- Make it italic and underlined
	window:set_right_status(wezterm.format({
		{ Attribute = { Underline = "Single" } },
		{ Attribute = { Italic = true } },
		{ Text = "Hello " .. date },
	}))
end)

return config
