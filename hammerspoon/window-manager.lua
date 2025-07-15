local hotkey = require("hs.hotkey")
local window = require("hs.window")

window.animationDuration = 0

-- fullscreen
local windowSizeBeforeFullscreen = {}

local leader = { "cmd", "ctrl" }
local padding = 10 -- pixels of padding around windows

-- move window to cell with specified coordinates and size
local function moveToCell(x, y, w, h)
  return function()
    local win = hs.window.focusedWindow()
    local screen = win:screen()
    local screenFrame = screen:frame()
    local halfW = screen:frame().w / 2
    local halfH = screen:frame().h / 2

    local wx = screenFrame.x + (x * halfW) + 1 / (1 + x) * padding
    local wy = screenFrame.y + (y * halfH) + 1 / (1 + y) * padding
    local ww = (w * halfW) - padding - w / 2 * padding
    local wh = (h * halfH) - padding - h / 2 * padding

    win:setFrame(hs.geometry.rect(wx, wy, ww, wh), 0)
  end
end

-- helper
local eqWithTolerance = function(tolerance)
  return function(a, b)
    return math.abs(a - b) <= tolerance
  end
end
local eq = eqWithTolerance(10)

-- toggle window size between target and previous size
local toggleWindow = function(fn)
  return function()
    local win = window.focusedWindow()
    local id = win:id()
    local winFrame = win:frame()
    local targetFrame = fn()
    local isAtTarget = eq(winFrame.w, targetFrame.w) and eq(winFrame.h, targetFrame.h)

    if not isAtTarget then
      -- store current frame for restoration and fullscreen
      windowSizeBeforeFullscreen[id] = winFrame
      win:setFrame(targetFrame, 0)
    else
      -- try to restore frame
      if windowSizeBeforeFullscreen[id] then
        win:setFrame(windowSizeBeforeFullscreen[id], 0)
      end
    end
  end
end

-- clear cached window size on window close
-- NOTE: this "filter" is damn slow to initalize
window.filter.default:subscribe(window.filter.windowDestroyed, function(win)
  local id = win:id()
  if windowSizeBeforeFullscreen[id] then
    windowSizeBeforeFullscreen[id] = nil
  end
end)

hs.hotkey.bind(leader, "h", moveToCell(0, 0, 1, 2)) -- left half
hs.hotkey.bind(leader, "j", moveToCell(0, 1, 2, 1)) -- bottom half
hs.hotkey.bind(leader, "k", moveToCell(0, 0, 2, 1)) -- top half
hs.hotkey.bind(leader, "l", moveToCell(1, 0, 1, 2)) -- right half
hs.hotkey.bind(leader, "n", moveToCell(0, 0, 1, 1)) -- top left
hs.hotkey.bind(leader, "m", moveToCell(0, 1, 1, 1)) -- bottom left
hs.hotkey.bind(leader, ",", moveToCell(1, 1, 1, 1)) -- bottom right
hs.hotkey.bind(leader, ".", moveToCell(1, 0, 1, 1)) -- top right

hotkey.bind(
  leader,
  "return",
  toggleWindow(function()
    local screenFrame = window.focusedWindow():screen():frame()
    return hs.geometry.rect(
      screenFrame.x + padding,
      screenFrame.y + padding,
      screenFrame.w - 2 * padding,
      screenFrame.h - 2 * padding
    )
  end)
)

hotkey.bind(
  leader,
  "c",
  toggleWindow(function()
    local screenFrame = window.focusedWindow():screen():frame()
    local coeff = 1.618
    return hs.geometry.rect(
      screenFrame.x + (screenFrame.w - screenFrame.w / coeff) / 2,
      screenFrame.y + (screenFrame.h - screenFrame.h / coeff) / 2,
      screenFrame.w / coeff,
      screenFrame.h / coeff
    )
  end)
)
