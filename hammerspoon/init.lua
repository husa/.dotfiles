local startTime = os.time()
require("window-manager")

local bindHotkey = require("bind-hotkey")
bindHotkey("WezTerm", "cmd", "escape")

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "R", function()
  hs.reload()
end)

hs.alert.show("Config loaded in " .. os.time() - startTime .. "s")
