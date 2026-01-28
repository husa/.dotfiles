function Linemode:custom_mtime()
  local time = math.floor(self._file.cha.mtime or 0)
  if time == 0 then
    time = ""
  elseif os.date("%Y", time) == os.date("%Y") then
    time = os.date("%d/%m %H:%M", time)
  else
    time = os.date("%d/%m/%y", time)
  end

  -- local size = self._file:size()
  -- return string.format("%s %s", size and ya.readable_size(size) or "-", time)
  return time
end

function Linemode:custom_sizemtime()
  local mtime = Linemode.custom_mtime(self)
  local size = self._file:size()
  return string.format("%s %s", mtime, size and ya.readable_size(size) or "-")
end

require("folder-rules"):setup()
