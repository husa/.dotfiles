local hotkey = require("hs.hotkey")
local application = require("hs.application")

-- Bind a hotkey for launching an app on the screen where the cursor is located
local function bindHotkey(appName, modifier, key)
	hotkey.bind({ modifier }, key, function()
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

return bindHotkey
