local startTime = os.time()

hs.loadSpoon("EmmyLua")

package.path = package.path .. ";" .. os.getenv("HOME") .. "/Projects/?.spoon/init.lua"
print(package.path)
-- bind wezterm hotkey
local bindHotkey = require("bind-hotkey")
bindHotkey("WezTerm", "cmd", "escape")

-- reload config
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "R", function()
  hs.reload()
end)

-- window manager
hs.loadSpoon("MiroWindowsManager")
local windowManagerLeader = { "ctrl", "alt", "shift" }
hs.window.animationDuration = 0
spoon.MiroWindowsManager:bindHotkeys({
  up = { windowManagerLeader, "up" },
  right = { windowManagerLeader, "right" },
  down = { windowManagerLeader, "down" },
  left = { windowManagerLeader, "left" },
  fullscreen = { windowManagerLeader, "return" },
})

-- window navigation
require("window-navigation")

-- modal application launcher

-- configuration
-- catpuccin palette
local colors = {
  rosewater = "#f5e0dc",
  flamingo = "#f2cdcd",
  pink = "#f5c2e7",
  mauve = "#cba6f7",
  red = "#f38ba8",
  maroon = "#eba0ac",
  peach = "#fab387",
  yellow = "#f9e2af",
  green = "#a6e3a1",
  teal = "#94e2d5",
  sky = "#89dceb",
  sapphire = "#74c7ec",
  blue = "#89b4fa",
  lavender = "#b4befe",
  text = "#cdd6f4",
  subtext1 = "#bac2de",
  subtext0 = "#a6adc8",
  overlay2 = "#9399b2",
  overlay1 = "#7f849c",
  overlay0 = "#6c7086",
  surface2 = "#585b70",
  surface1 = "#45475a",
  surface0 = "#313244",
  base = "#1e1e2e",
  mantle = "#181825",
  crust = "#11111b",
}
local apps = {
  { key = "a", app = "Arc", desc = " Arc", color = { hex = colors.rosewater } },
  { key = "b", app = "Bitwarden", desc = " Bitwarden", color = { hex = colors.blue } },
  { key = "c", app = "Google Chrome Beta", desc = " Chrome󰂡", color = { hex = colors.yellow } },
  {
    key = "c",
    modifier = { "shift" },
    app = "Google Chrome",
    desc = " Chrome",
    keySymbol = "C",
    color = { hex = colors.yellow },
  },
  { key = "f", app = "Fork", desc = " Fork", color = { hex = colors.teal } },
  { key = "m", app = "YouTube Music", desc = " YouTube Music", color = { hex = colors.red } },
  { key = "n", app = "Neovide", desc = " Neovide", color = { hex = colors.green } },
  { key = "o", app = "Microsoft Outlook", desc = "󰴢 Outlook", color = { hex = colors.sky } },
  {
    key = "o",
    modifier = { "shift" },
    app = "Obsidian",
    desc = "󰠮 Obsidian",
    keySymbol = "O",
    color = { hex = colors.mauve },
  },
  { key = "s", app = "Slack", desc = " Slack", color = { hex = colors.maroon } },
  { key = "t", app = "Microsoft Teams", desc = "󰊻 Teams", color = { hex = colors.mauve } },
  { key = "w", app = "Wezterm", desc = " Wezterm", color = { hex = colors.lavender } },
  { key = "z", app = "Zen Browser", desc = " Zen Browser", color = { hex = colors.mauve } },
  {
    key = "space",
    app = "Alfred 5",
    keySymbol = "󱁐",
    desc = "󰮤 Alfred",
    color = { hex = colors.pink },
  },
  {
    key = "1",
    modifier = { "shift" },
    app = "Admin By Request",
    keySymbol = "!",
    desc = "󱥡 ABR",
    color = { hex = colors.peach },
  },
}
hs.loadSpoon("WhichAppLauncher")
-- spoon.WhichAppLauncher.apps = {
--   { key = "t", app = "Microsoft Teams", desc = "AJjjjqfp" },
--   { key = "o", app = "Microsoft Outlook" },
-- }
spoon.WhichAppLauncher.apps = apps
spoon.WhichAppLauncher.options = {
  fontName = "GeistMono Nerd Font",
  fontSize = 16,
  columns = 2,
  lineSpacing = 4,
  overlayWidthFraction = 3,
  backgroundColor = { hex = colors.base, alpha = 0.9 },
}
spoon.WhichAppLauncher:bindHotkeys({
  show = { "alt", "space" },
  hide = { nil, "escape" },
})

-- display total config load time
hs.alert.show("Config loaded in " .. os.time() - startTime .. "s")
