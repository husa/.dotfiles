print("start of config load")
local myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.dotfiles/hammerspoon/", hs.reload):start()

local bindWeztermHotkey = require("wezterm-hotkey")
bindWeztermHotkey("cmd", "escape")

hs.alert.show("Config loaded")
-- Show Wi-Fi notifications
-- local wifiwatcher = hs.wifi.watcher.new(function()
-- 	local net = hs.wifi.currentNetwork()
-- 	if net == nil then
-- 		hs.notify.show("You lost Wi-Fi connection", "", "", "")
-- 	else
-- 		hs.notify.show("Connected to Wi-Fi network", "", net, "")
-- 	end
-- end)
-- wifiwatcher:start()

-- local choices = {
-- 	{
-- 		["text"] = "First Choice",
-- 		-- ["subText"] = "This is the subtext of the first choice",
-- 		["uuid"] = "0001",
-- 	},
-- 	{ ["text"] = "Second Option", ["subText"] = "I wonder what I should type here?", ["uuid"] = "Bbbb" },
-- 	{
-- 		["text"] = hs.styledtext.new(
-- 			"Third Possibility",
-- 			{ font = { size = 18 }, color = hs.drawing.color.definedCollections.hammerspoon.green }
-- 		),
-- 		-- ["subText"] = "What a lot of choosing there is going on here!",
-- 		["uuid"] = "III3",
-- 	},
-- }
--
-- choices = {
-- 	{
-- 		text = "chrome",
-- 	},
-- 	{
-- 		text = "chromium",
-- 	},
-- }
--
-- hs.chooser
-- 	.new(function()
-- 		hs.alert.show("loaded")
-- 	end)
-- 	:choices(function()
-- 		hs.alert.show("get choices")
-- 		return choices
-- 	end)
-- 	:show()
