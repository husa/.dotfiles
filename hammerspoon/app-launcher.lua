local hotkey = require("hs.hotkey")
local application = require("hs.application")
local canvas = require("hs.canvas")

-- helper functions
local setImmediate = function(fn)
  hs.timer.doAfter(0, function()
    fn()
  end)
end

-- configuration
local catpuccinPalette = {
  rosewater = "#f5e0dc",
  flamingo = "#f2cdcd",
  pink = "#f5c2e7",
  mauve = "#cba6f7",
  red = "#f38ba8",
  maroon = "#eba0ac",
  peach = "#fab387",
  yellow = "#f9e2af",
  green = "#a6e3a1",
  teal = "#94e2d5",
  sky = "#89dceb",
  sapphire = "#74c7ec",
  blue = "#89b4fa",
  lavender = "#b4befe",
  text = "#cdd6f4",
  subtext1 = "#bac2de",
  subtext0 = "#a6adc8",
  overlay2 = "#9399b2",
  overlay1 = "#7f849c",
  overlay0 = "#6c7086",
  surface2 = "#585b70",
  surface1 = "#45475a",
  surface0 = "#313244",
  base = "#1e1e2e",
  mantle = "#181825",
  crust = "#11111b",
}

local apps = {
  -- { key = "a", app = "Arc", desc = " Arc", color = { hex = catpuccinPalette.rosewater } },
  { key = "b", app = "Bitwarden", desc = " Bitwarden", color = { hex = catpuccinPalette.blue } },
  { key = "c", app = "Google Chrome Beta", desc = " Chrome Beta", color = { hex = catpuccinPalette.yellow } },
  {
    key = "c",
    modifier = "shift",
    app = "Google Chrome",
    desc = " Chrome",
    keySymbol = "C",
    color = { hex = catpuccinPalette.yellow },
  },
  { key = "f", app = "Fork", desc = " Fork", color = { hex = catpuccinPalette.teal } },
  { key = "m", app = "YouTube Music", desc = " YouTube Music", color = { hex = catpuccinPalette.red } },
  { key = "n", app = "Neovide", desc = " Neovide", color = { hex = catpuccinPalette.green } },
  {
    key = "o",
    app = "Obsidian",
    desc = "󰠮 Obsidian",
    color = { hex = catpuccinPalette.mauve },
  },
  {
    key = "o",
    modifier = "shift",
    app = "Microsoft Outlook",
    desc = "󰴢 Outlook",
    keySymbol = "O",
    color = { hex = catpuccinPalette.sky },
  },
  { key = "s", app = "Slack", desc = " Slack", color = { hex = catpuccinPalette.maroon } },
  { key = "t", app = "Microsoft Teams", desc = "󰊻 Teams", color = { hex = catpuccinPalette.mauve } },
  { key = "w", app = "Wezterm", desc = " Wezterm", color = { hex = catpuccinPalette.lavender } },
  { key = "z", app = "Zen Browser", desc = " Zen Browser", color = { hex = catpuccinPalette.mauve } },
  {
    key = "space",
    app = "Alfred 5",
    keySymbol = "󱁐",
    desc = "󰮤 Alfred",
    color = { hex = catpuccinPalette.pink },
  },
  {
    key = "1",
    modifier = "shift",
    app = "Admin By Request",
    keySymbol = "!",
    desc = "󱥡 Admin By Request",
    color = { hex = catpuccinPalette.peach },
  },
}

local NUMBER_OF_COLUMNS = 2
local OVERLAY_WIDTH_FRACTION = 5
local FONT_SIZE = 18
local LINE_HEIGHT = 28
local PADDING_Y = 8
local PADDING_X = 16

-- TODO: handle display size change

local rowsPerColumn = math.floor(#apps / NUMBER_OF_COLUMNS)
local remainingRows = #apps - rowsPerColumn * NUMBER_OF_COLUMNS

local maxRowsInCol = rowsPerColumn + remainingRows
local screenFrame = hs.screen.mainScreen():frame()

-- overlay canvas
local overlayWidth = screenFrame.w / OVERLAY_WIDTH_FRACTION
local overlayHeight = LINE_HEIGHT * maxRowsInCol + 2 * PADDING_Y
local MENUBAR_HEIGHT = 25
local overlay = canvas.new({
  x = screenFrame.w / 2 - overlayWidth / 2,
  y = screenFrame.h - overlayHeight + MENUBAR_HEIGHT,
  w = overlayWidth,
  h = overlayHeight,
})

-- overlay background
overlay:insertElement({
  type = "rectangle",
  id = "overlay",
  action = "fill",
  fillColor = { hex = catpuccinPalette.base, alpha = 0.9 },
  roundedRectRadii = { xRadius = 8.0, yRadius = 8.0 },
  withShadow = false,
})

-- determine size of columns
local columnFrames = {}
local columnWidth = (overlayWidth - PADDING_X * (NUMBER_OF_COLUMNS - 1) - PADDING_X * 2) / NUMBER_OF_COLUMNS
for i = 1, NUMBER_OF_COLUMNS do
  columnFrames[i] = {
    x = PADDING_X + (i - 1) * (columnWidth + PADDING_X),
    y = PADDING_Y,
    w = columnWidth,
    h = overlayHeight - PADDING_Y * 2,
  }
end

local takeList = function(list, start, len)
  local subList = {}
  for i = start, start + len - 1 do
    table.insert(subList, list[i])
  end
  return subList
end

local generateRowContent = function(appConfig)
  local keySymbol = appConfig.keySymbol
  if keySymbol == nil then
    keySymbol = appConfig.key
  end
  local appDescription = appConfig.desc
  if appDescription == nil then
    appDescription = appConfig.app
  end
  return keySymbol .. " -> " .. appDescription
end

local offsetRect = function(rect1, rect2)
  return {
    x = rect1.x + rect2.x,
    y = rect1.y + rect2.y,
    w = rect2.w,
    h = rect2.h,
  }
end

local appStartIndex = 1
for i = 1, NUMBER_OF_COLUMNS do
  local numberOfRowsInCurrentColumn = rowsPerColumn
  -- TODO:distribute remaining rows more evenly(ie. 11 = 4 + 4 +3, now 11 = 5, 3, 3)
  --
  -- if this is first column, add all remaining rows
  if i == 1 then
    numberOfRowsInCurrentColumn = rowsPerColumn + remainingRows
  end

  local appsInColumn = takeList(apps, appStartIndex, numberOfRowsInCurrentColumn)
  appStartIndex = appStartIndex + numberOfRowsInCurrentColumn
  local columnCanvas = overlay:insertElement({
    type = "canvas",
    frame = columnFrames[i],
  })
  -- render rows
  for j = 1, #appsInColumn do
    columnCanvas:insertElement({
      type = "text",
      frame = offsetRect(columnFrames[i], {
        x = 0,
        y = (j - 1) * LINE_HEIGHT,
        w = "100%",
        h = LINE_HEIGHT,
      }),
      absolutePosition = false,
      absoluteSize = false,
      text = hs.styledtext(generateRowContent(appsInColumn[j]), {
        color = (appsInColumn[j].color == nil and { hex = catpuccinPalette.text, alpha = 1 }) or appsInColumn[j].color,
        shadow = { blurRadius = 5, offset = { h = -1, w = 1 }, color = { hex = catpuccinPalette.mantle, alpha = 0.5 } },
        font = {
          name = "firacode nerd font",
          size = FONT_SIZE,
        },
      }),
    })
  end
end

-- register modal key
local hyper = { "cmd", "alt", "ctrl", "shift" }
local modal = hotkey.modal.new(hyper, "space")
function modal:entered()
  setImmediate(function()
    overlay:show()
  end)
end
function modal:exited()
  overlay:hide()
end

modal:bind("", "escape", function()
  print("<Esc> pressed. Exiting mode...")
  modal:exit()
end)

-- register app keys inside modal
for i = 1, #apps do
  local appConfig = apps[i]
  local modifier = appConfig.modifier
  if modifier == nil then
    modifier = ""
  end
  modal:bind(modifier, appConfig.key, nil, function()
    modal:exit()
    setImmediate(function()
      if type(appConfig.app) == "function" then
        appConfig.app()
      elseif type(appConfig.app) == "string" then
        application.launchOrFocus(appConfig.app)
      else
        print('Invalid app type: "' .. type(appConfig.app) .. '". App name must be a string or function.')
      end
    end)
  end)
end
