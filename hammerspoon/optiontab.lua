-- use Option+Tab to cycle through windows of the focused application
hs.hotkey.bind("option", "tab", function()
  local focusedWindow = hs.window.focusedWindow()
  local app = focusedWindow:application()
  -- to get only visible windows of the focused application
  -- local visibleWindows = app:visibleWindows()
  local appWindows = app:allWindows()
  -- if there are no other visible windows, do nothing
  if #appWindows <= 1 then
    return
  end
  -- if there are other visible windows, cycle through them
  table.sort(appWindows, function(a, b)
    return a:id() < b:id()
  end)
  local currentIndex = 1
  for i, window in ipairs(appWindows) do
    if window == focusedWindow then
      currentIndex = i
      break
    end
  end
  local nextIndex = (currentIndex % #appWindows) + 1
  local nextWindow = appWindows[nextIndex]
  nextWindow:focus()
end)
