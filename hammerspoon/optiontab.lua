-- use Option+Tab to cycle through windows of the focused application
hs.hotkey.bind("option", "tab", function()
  local focusedWindow = hs.window.focusedWindow()
  local app = focusedWindow:application()
  local visibleWindows = app:visibleWindows()
  -- if there are no other visible windows, do nothing
  if #visibleWindows <= 1 then
    return
  end
  -- if there are other visible windows, cycle through them
  local currentIndex = 1
  for i, window in ipairs(visibleWindows) do
    if window == focusedWindow then
      currentIndex = i
      break
    end
  end
  local nextIndex = (currentIndex % #visibleWindows) + 1
  local nextWindow = visibleWindows[nextIndex]
  nextWindow:focus()
end)
