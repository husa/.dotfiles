-- SOURCE: https://github.com/wez/wezterm/issues/1751#issuecomment-2014752114
--
-- Import necessary Hammerspoon modules
local hotkey = require("hs.hotkey")
local application = require("hs.application")
-- local mouse = require("hs.mouse")
-- local screen = require("hs.screen")
-- local geometry = require("hs.geometry")
-- local spaces = require("hs.spaces")
-- local timer = require("hs.timer")

-- Detect the screen under the cursor
-- local function screenUnderCursor()
-- 	local mousePoint = mouse.getAbsolutePosition()
-- 	local screens = screen.allScreens()
-- 	for _, scr in ipairs(screens) do
-- 		if geometry.point(mousePoint):inside(scr:frame()) then
-- 			return scr
-- 		end
-- 	end
-- 	return nil
-- end

-- hotkey.bind({ "cmd" }, "M", function()
-- 	application.launch("WezTerm")
-- end)

-- local hotkeyWindowID

-- local function launchApp()
-- 	-- start watching for new window
-- 	startWindowFilterSubscription(function(win)
-- 		hotkeyWindowID = win:id()
-- 		print("FINAL: window id = " .. hotkeyWindowID)
-- 		local currentScreen = screenUnderCursor()
-- 		if currentScreen then
-- 			local max = currentScreen:fullFrame()
-- 			local f = win:frame()
-- 			f.x = max.x
-- 			f.y = max.y
-- 			f.w = max.w
-- 			f.h = max.h * 0.55
-- 			win:setFrame(f)
-- 			win:focus()
-- 		end
-- 		stopWindowFilterSubscription()
-- 	end)
--
-- 	application.launchOrFocus("WezTerm")
-- end

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
		-- print("BIND: key triggered")
		-- if hotkeyWindowID == nil then -- window hasn't been created yet
		-- 	print("BIND: window id is nil, going to create")
		-- 	launchApp()
		-- else -- windows has been created but could be dead
		-- 	print("BIND: have window id")
		-- 	local app = application.find("WezTerm", true)
		-- 	if app == nil then
		-- 		launchApp()
		-- 	else
		-- 		local appWindows = app:allWindows()
		-- 		local hotkeyWindowFound = false
		-- 		for _, w in ipairs(appWindows) do
		-- 			if w:id() == hotkeyWindowID then
		-- 				print("BIND: found window")
		--
		--           spaces.moveWindowToSpace(w, spaces.focusedSpace())
		-- 				w:focus()
		-- 				hotkeyWindowFound = true
		-- 				break
		-- 			end
		-- 		end
		-- 		if hotkeyWindowFound == false then
		-- 			print("BIND: window not found")
		-- 		end
		-- 	end
		-- end

		-- hotkeyWindowID = nil
		-- -- print(hotkeyWindowPID)
		-- local shouldLaunch = false
		-- if hotkeyWindowID then
		-- 	print("got pid")
		-- 	local hotkeyWindowApp = application.applicationForPID(hotkeyWindowID)
		-- 	if hotkeyWindowApp then
		-- 		print("got pid window")
		-- 		if hotkeyWindowApp:isFrontmost() then
		-- 			print("pid window is frontmost")
		-- 			hotkeyWindowApp:hide()
		-- 		else
		-- 			print("show window")
		-- 			local appWindow = hotkeyWindowApp:mainWindow()
		-- 			spaces.moveWindowToSpace(appWindow, spaces.focusedSpace())
		-- 			appWindow:focus()
		-- 		end
		-- 	else
		-- 		print("app with PID not found")
		-- 		shouldLaunch = true
		-- 	end
		-- else
		-- 	shouldLaunch = true
		-- end
		--
		-- if shouldLaunch then
		-- 	launchApp()
		-- end
		--
		-- local currentScreen = screenUnderCursor()
		-- if shouldLaunch and false then
		-- 	hotkeyWindowID = nil
		-- 	print("app not found - not running, going to start")
		-- 	application.launchOrFocus(appName)
		-- 	timer.doAfter(1, function()
		-- 		local launched_app = application.find(appName)
		-- 		if launched_app then
		-- 			hotkeyWindowID = launched_app:pid()
		-- 			print("lauchedapp pid" .. hotkeyWindowID)
		-- 			local app_window = launched_app:mainWindow()
		-- 			print(app_window:id())
		--
		-- 			if app_window and currentScreen then
		-- 				print(app_window:id())
		-- 				local max = currentScreen:fullFrame()
		-- 				local f = app_window:frame()
		-- 				f.x = max.x
		-- 				f.y = max.y
		-- 				f.w = max.w
		-- 				f.h = max.h * 0.55
		-- 				app_window:setFrame(f)
		-- 				app_window:focus()
		-- 			else
		-- 				print("no app_window or currentScreen")
		-- 			end
		-- 		else
		-- 			print("launched app not found")
		-- 		end
		-- 	end)
		-- end
		--    return
		-- 	print(hotkeyWindowPID)
		-- 	local app = application.find(appName)
		-- 	local currentScreen = screenUnderCursor()
		-- 	if app then
		-- 		if app:isFrontmost() then
		-- 			app:hide()
		-- 		else
		-- 			local app_window = app:mainWindow()
		-- 			if app_window and currentScreen then
		-- 				local max = currentScreen:fullFrame()
		-- 				local f = app_window:frame()
		-- 				f.x = max.x
		-- 				f.y = max.y
		-- 				f.w = max.w
		-- 				f.h = max.h * 0.55
		-- 				spaces.moveWindowToSpace(app_window, spaces.focusedSpace())
		-- 				timer.doAfter(0.2, function()
		-- 					app_window:setFrame(f)
		-- 				end)
		-- 				app_window:focus()
		-- 			end
		-- 		end
		-- 	else
		-- 		print("app not found - not running, going to start")
		-- 		application.launchOrFocus(appName)
		-- 		timer.doAfter(0.5, function()
		-- 			local launched_app = application.find(appName)
		-- 			if launched_app then
		-- 				hotkeyWindowPID = launched_app:pid()
		-- 				local app_window = launched_app:mainWindow()
		--
		-- 				if app_window and currentScreen then
		-- 					local max = currentScreen:fullFrame()
		-- 					local f = app_window:frame()
		-- 					f.x = max.x
		-- 					f.y = max.y
		-- 					f.w = max.w
		-- 					f.h = max.h * 0.55
		-- 					app_window:setFrame(f)
		-- 					app_window:focus()
		-- 				else
		-- 					print("no app_window or currentScreen")
		-- 				end
		-- 			else
		-- 				print("app not found")
		-- 			end
		-- 		end)
		-- 	end
	end)
end

-- weztermLaunchWatcher = application.watcher.new(function(appName, eventType, app)
-- 	if eventType == hs.application.watcher.launched and appName == "WezTerm" then
-- 		print("APPWATCHER: wezterm launched")
-- 		print("APPWATCHER: wezterm lauched with PID " .. app:pid())
-- 		local window = app:mainWindow()
-- 		-- print("APPWATCHER: wezterm launched window id " .. window:id())
-- 	end
-- end)

-- local windowFilter = hs.window.filter.new(false):setAppFilter("WezTerm")
-- function startWindowFilterSubscription(fn)
-- 	windowFilter:subscribe(hs.window.filter.windowCreated, fn)
-- end
-- function stopWindowFilterSubscription()
-- 	windowFilter:unsubscribeAll()
-- end
--
-- startWindowFilterSubscription()

-- TEMP
-- weztermLaunchWatcher:start()

local bindWeztermHotkey = function(modifier, key)
	-- Bind the hotkey for WezTerm
	bindHotkey("WezTerm", modifier, key)
end

return bindWeztermHotkey
