local startTime = os.time()

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
hs.window.animationDuration = 0.2
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
require("app-launcher")

-- display total config load time
hs.alert.show("Config loaded in " .. os.time() - startTime .. "s")
