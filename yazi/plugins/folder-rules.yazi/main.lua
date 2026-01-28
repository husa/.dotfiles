local function setup()
  ps.sub("ind-sort", function(opt)
    local cwd = cx.active.current.cwd
    if cwd:ends_with("Downloads") then
      opt.by, opt.reverse = "mtime", true
    else
      opt.by, opt.reverse = "natural", false
    end
    return opt
  end)
end

return { setup = setup }
