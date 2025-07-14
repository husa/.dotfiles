local hotkey = require("hs.hotkey")
local application = require("hs.application")

--- Bind a hotkey for launching an app on the screen where the cursor is located
--- @param appName string The name of the application to launch
--- @param modifier table|string modifier key(s) to use (e.g., "cmd", "ctrl", "alt", or { "cmd", "option" })
--- @param key string key to bind the hotkey to
local function bindAppHotkey(appName, modifier, key)
  hotkey.bind(modifier, key, function()
    local app = application.find(appName, true)
    if app then
      if app:isFrontmost() then
        app:hide()
      else
        app:setFrontmost()
      end
    else
      application.launchOrFocus(appName)
    end
  end)
end

return bindAppHotkey
