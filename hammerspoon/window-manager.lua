local hotkey = require("hs.hotkey")
local window = require("hs.window")

window.animationDuration = 0

-- move between windows
local windowNavLeader = { "alt", "ctrl" }
hotkey.bind(windowNavLeader, "left", function()
	local win = window.focusedWindow()
	win:focusWindowWest()
end)
hotkey.bind(windowNavLeader, "down", function()
	local win = window.focusedWindow()
	win:focusWindowSouth()
end)
hotkey.bind(windowNavLeader, "up", function()
	local win = window.focusedWindow()
	win:focusWindowNorth()
end)
hotkey.bind(windowNavLeader, "right", function()
	local win = window.focusedWindow()
	win:focusWindowEast()
end)

-- resize windows
local windowResizeLeader = { "alt", "ctrl", "shift" }
-- fullscreen
local windowSizeBeforeFullscreen = {}

local eqWithTolerance = function(tolerance)
	return function(a, b)
		return math.abs(a - b) <= tolerance
	end
end
local eq = eqWithTolerance(2)
hotkey.bind(windowResizeLeader, "return", function()
	local win = window.focusedWindow()
	local id = win:id()
	local winFrame = win:frame()
	local screen = win:screen()
	local screenFrame = screen:frame()
	local isFullScreen = eq(winFrame.w, screenFrame.w) and eq(winFrame.h, screenFrame.h)

	if not isFullScreen then
		-- store current frame for restoration and fullscreen
		windowSizeBeforeFullscreen[id] = winFrame
		winFrame = screenFrame
		win:setFrame(winFrame, 0)
	else
		-- try to restore frame
		if windowSizeBeforeFullscreen[id] then
			win:setFrame(windowSizeBeforeFullscreen[id], 0)
		end
	end
end)
-- clear cached window size on window close
-- NOTE: this "filter" is damn slow to initalize
window.filter.default:subscribe(window.filter.windowDestroyed, function(win)
	local id = win:id()
	if windowSizeBeforeFullscreen[id] then
		windowSizeBeforeFullscreen[id] = nil
	end
end)

-- halves
hotkey.bind(windowResizeLeader, "left", function()
	local win = window.focusedWindow()
	local winFrame = win:frame()
	local screen = win:screen()
	local screenFrame = screen:frame()

	winFrame.x = screenFrame.x
	winFrame.y = screenFrame.y
	winFrame.w = screenFrame.w / 2
	winFrame.h = screenFrame.h
	win:setFrame(winFrame, 0)
end)
hotkey.bind(windowResizeLeader, "down", function()
	local win = window.focusedWindow()
	local winFrame = win:frame()
	local screen = win:screen()
	local screenFrame = screen:frame()

	winFrame.x = screenFrame.x
	winFrame.y = screenFrame.y + (screenFrame.h / 2)
	winFrame.w = screenFrame.w
	winFrame.h = screenFrame.h / 2
	win:setFrame(winFrame, 0)
end)
hotkey.bind(windowResizeLeader, "up", function()
	local win = window.focusedWindow()
	local winFrame = win:frame()
	local screen = win:screen()
	local screenFrame = screen:frame()

	winFrame.x = screenFrame.x
	winFrame.y = screenFrame.y
	winFrame.w = screenFrame.w
	winFrame.h = screenFrame.h / 2
	win:setFrame(winFrame, 0)
end)
hotkey.bind(windowResizeLeader, "right", function()
	local win = window.focusedWindow()
	local winFrame = win:frame()
	local screen = win:screen()
	local screenFrame = screen:frame()

	winFrame.x = screenFrame.x + (screenFrame.w / 2)
	winFrame.y = screenFrame.y
	winFrame.w = screenFrame.w / 2
	winFrame.h = screenFrame.h
	win:setFrame(winFrame, 0)
end)

-- quarters
hotkey.bind(windowResizeLeader, "u", function()
	local win = window.focusedWindow()
	local winFrame = win:frame()
	local screen = win:screen()
	local screenFrame = screen:frame()

	winFrame.x = screenFrame.x
	winFrame.y = screenFrame.y
	winFrame.w = screenFrame.w / 2
	winFrame.h = screenFrame.h / 2
	win:setFrame(winFrame, 0)
end)
hotkey.bind(windowResizeLeader, "j", function()
	local win = window.focusedWindow()
	local winFrame = win:frame()
	local screen = win:screen()
	local screenFrame = screen:frame()

	winFrame.x = screenFrame.x
	winFrame.y = screenFrame.y + (screenFrame.h / 2)
	winFrame.w = screenFrame.w / 2
	winFrame.h = screenFrame.h / 2
	win:setFrame(winFrame, 0)
end)
hotkey.bind(windowResizeLeader, "i", function()
	local win = window.focusedWindow()
	local winFrame = win:frame()
	local screen = win:screen()
	local screenFrame = screen:frame()

	winFrame.x = screenFrame.x + (screenFrame.w / 2)
	winFrame.y = screenFrame.y
	winFrame.w = screenFrame.w / 2
	winFrame.h = screenFrame.h / 2
	win:setFrame(winFrame, 0)
end)
hotkey.bind(windowResizeLeader, "k", function()
	local win = window.focusedWindow()
	local winFrame = win:frame()
	local screen = win:screen()
	local screenFrame = screen:frame()

	winFrame.x = screenFrame.x + (screenFrame.w / 2)
	winFrame.y = screenFrame.y + (screenFrame.h / 2)
	winFrame.w = screenFrame.w / 2
	winFrame.h = screenFrame.h / 2
	win:setFrame(winFrame, 0)
end)
