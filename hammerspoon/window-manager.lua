hs.window.animationDuration = 0

-- move between windows
local windowNavLeader = { "alt", "ctrl" }
hs.hotkey.bind(windowNavLeader, "left", function()
	local win = hs.window.focusedWindow()
	win:focusWindowWest()
end)
hs.hotkey.bind(windowNavLeader, "down", function()
	local win = hs.window.focusedWindow()
	win:focusWindowSouth()
end)
hs.hotkey.bind(windowNavLeader, "up", function()
	local win = hs.window.focusedWindow()
	win:focusWindowNorth()
end)
hs.hotkey.bind(windowNavLeader, "right", function()
	local win = hs.window.focusedWindow()
	win:focusWindowEast()
end)

-- resize windows
local windowResizeLeader = { "alt", "ctrl", "shift" }
-- fullscreen
-- TODO: this map will grow infinitely, memory leak!!!
local windowSizeBeforeFullscreen = {}

local eqWithTolerance = function(tolerance)
	return function(a, b)
		return math.abs(a - b) <= tolerance
	end
end
local eq = eqWithTolerance(2)
hs.hotkey.bind(windowResizeLeader, "return", function()
	local win = hs.window.focusedWindow()
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
-- halves
hs.hotkey.bind(windowResizeLeader, "left", function()
	local win = hs.window.focusedWindow()
	local winFrame = win:frame()
	local screen = win:screen()
	local screenFrame = screen:frame()

	winFrame.x = screenFrame.x
	winFrame.y = screenFrame.y
	winFrame.w = screenFrame.w / 2
	winFrame.h = screenFrame.h
	win:setFrame(winFrame, 0)
end)
hs.hotkey.bind(windowResizeLeader, "down", function()
	local win = hs.window.focusedWindow()
	local winFrame = win:frame()
	local screen = win:screen()
	local screenFrame = screen:frame()

	winFrame.x = screenFrame.x
	winFrame.y = screenFrame.y + (screenFrame.h / 2)
	winFrame.w = screenFrame.w
	winFrame.h = screenFrame.h / 2
	win:setFrame(winFrame, 0)
end)
hs.hotkey.bind(windowResizeLeader, "up", function()
	local win = hs.window.focusedWindow()
	local winFrame = win:frame()
	local screen = win:screen()
	local screenFrame = screen:frame()

	winFrame.x = screenFrame.x
	winFrame.y = screenFrame.y
	winFrame.w = screenFrame.w
	winFrame.h = screenFrame.h / 2
	win:setFrame(winFrame, 0)
end)
hs.hotkey.bind(windowResizeLeader, "right", function()
	local win = hs.window.focusedWindow()
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
hs.hotkey.bind(windowResizeLeader, "u", function()
	local win = hs.window.focusedWindow()
	local winFrame = win:frame()
	local screen = win:screen()
	local screenFrame = screen:frame()

	winFrame.x = screenFrame.x
	winFrame.y = screenFrame.y
	winFrame.w = screenFrame.w / 2
	winFrame.h = screenFrame.h / 2
	win:setFrame(winFrame, 0)
end)
hs.hotkey.bind(windowResizeLeader, "j", function()
	local win = hs.window.focusedWindow()
	local winFrame = win:frame()
	local screen = win:screen()
	local screenFrame = screen:frame()

	winFrame.x = screenFrame.x
	winFrame.y = screenFrame.y + (screenFrame.h / 2)
	winFrame.w = screenFrame.w / 2
	winFrame.h = screenFrame.h / 2
	win:setFrame(winFrame, 0)
end)
hs.hotkey.bind(windowResizeLeader, "i", function()
	local win = hs.window.focusedWindow()
	local winFrame = win:frame()
	local screen = win:screen()
	local screenFrame = screen:frame()

	winFrame.x = screenFrame.x + (screenFrame.w / 2)
	winFrame.y = screenFrame.y
	winFrame.w = screenFrame.w / 2
	winFrame.h = screenFrame.h / 2
	win:setFrame(winFrame, 0)
end)
hs.hotkey.bind(windowResizeLeader, "k", function()
	local win = hs.window.focusedWindow()
	local winFrame = win:frame()
	local screen = win:screen()
	local screenFrame = screen:frame()

	winFrame.x = screenFrame.x + (screenFrame.w / 2)
	winFrame.y = screenFrame.y + (screenFrame.h / 2)
	winFrame.w = screenFrame.w / 2
	winFrame.h = screenFrame.h / 2
	win:setFrame(winFrame, 0)
end)
