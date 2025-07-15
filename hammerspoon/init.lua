local startTime = hs.timer.absoluteTime()

-- load spoons from ~/Projects/*.spoon
local home = os.getenv("HOME")
package.path = package.path .. ";" .. home .. "/Projects/?.spoon/init.lua;"

local hyperKey = { "cmd", "ctrl", "alt", "shift" }

-- bind wezterm hotkey
local bindAppHotkey = require("bind-hotkey")
bindAppHotkey("WezTerm", { "cmd" }, "'")

-- reload config
hs.hotkey.bind(hyperKey, "R", function()
  hs.reload()
end)

-- hs.loadSpoon("MiroWindowsManager")
hs.loadSpoon("WhichApp")
local catpuccinPalette = {
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
spoon.WhichApp.apps = {
  { key = "b", app = "Bitwarden", desc = " Bitwarden", color = { hex = catpuccinPalette.blue } },
  {
    key = "c",
    app = "Google Chrome",
    desc = " Chrome",
    color = { hex = catpuccinPalette.yellow },
  },

  { key = "e", app = "Google Chrome Beta", desc = " Chrome Beta", color = { hex = catpuccinPalette.yellow } },
  { key = "f", app = "Fork", desc = " Fork", color = { hex = catpuccinPalette.teal } },
  { key = "m", app = "YouTube Music", desc = " Music", color = { hex = catpuccinPalette.red } },
  { key = "n", app = "Neovide", desc = " Neovide", color = { hex = catpuccinPalette.green } },
  {
    key = "o",
    app = "Obsidian",
    desc = "󰠮 Obsidian",
    color = { hex = catpuccinPalette.mauve },
  },
  {
    key = "o",
    modifier = "shift",
    app = "Outlook (PWA)",
    desc = "󰴢 Outlook",
    keySymbol = "O",
    color = { hex = catpuccinPalette.sky },
  },
  { key = "s", app = "Slack", desc = " Slack", color = { hex = catpuccinPalette.maroon } },
  { key = "t", app = "Microsoft Teams", desc = "󰊻 Teams", color = { hex = catpuccinPalette.mauve } },
  { key = "w", app = "Wezterm", desc = " Wezterm", color = { hex = catpuccinPalette.lavender } },
  { key = "z", app = "Zen", desc = " Zen Browser", color = { hex = catpuccinPalette.mauve } },
  {
    key = "space",
    app = "Alfred 5",
    keySymbol = "󱁐",
    desc = "󰮤 Alfred",
    color = { hex = catpuccinPalette.pink },
  },
  {
    key = "1",
    modifier = "shift",
    app = "Admin By Request",
    keySymbol = "!",
    desc = "󱥡 ABR",
    color = { hex = catpuccinPalette.peach },
  },
}
spoon.WhichApp.options = {
  columns = 2,
  dialogWidth = 550,
  fontName = "Maple Mono NF",
  fontSize = 18,
  separator = " -> ",
  backgroundColor = { hex = catpuccinPalette.crust, alpha = 0.85 },
  screen = "main",
  -- hideTimeout = 0,
}

spoon.WhichApp:bindHotkeys({
  show = { { "cmd" }, "escape" },
  hide = { nil, "escape" },
})
-- window navigation
-- require("window-navigation")

-- modal application launcher
-- require("app-launcher")

-- require("playground")

-- window manager
require("window-manager")

-- display total config load time
local loadTime = math.floor((hs.timer.absoluteTime() - startTime) / 1e6)
hs.alert.show("Config loaded in " .. loadTime .. "ms")
print("Config loaded in " .. loadTime .. "ms")
