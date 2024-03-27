SCREENS = {}

for k, v in ipairs(hs.screen.allScreens()) do
  if string.find(v:name(), "Retina", 1, true) then
    SCREENS.LAPTOP = v
  end

  -- personal
  -- if string.find(v:name(), "U2518D", 1, true) then
  --   SCREENS.HORIZONTAL = v
  -- end
  -- if string.find(v:name(), "U2515H", 1, true) then
  --   SCREENS.VERTICAL = v
  -- end

  -- work
  -- if string.find(v:name(), "BFP100-27", 1, true) and string.find(v:name(), "(2)", 1, true) then
  --   SCREENS.HORIZONTAL = v
  -- end
  -- if string.find(v:name(), "BFP100-27", 1, true) and string.find(v:name(), "(1)", 1, true) then
  --   SCREENS.VERTICAL = v
  -- end

  -- trying this out
  x, y = v:position()
  if x == 0 and y == -1 then
    SCREENS.HORIZONTAL = v
  end
  if x == 1 and y == -1 then
    SCREENS.VERTICAL = v
  end
end

local screens = {}
screens.SCREENS = SCREENS

function screens.placeWindow(window, screen, ratios)
  local screenObj = screens.SCREENS[screen]
  if screenObj == nil then
    return
  end
  window:moveToScreen(SCREENS[screen])
  screen_height = screenObj:frame().h
  screen_width = screenObj:frame().w

  top = screen_height * ratios.top
  left = screen_width * ratios.left
  height = screen_height * ratios.height
  width = screen_width * ratios.width

  window:setTopLeft(screenObj:localToAbsolute(hs.geometry.point(left, top)))
  window:setSize(hs.geometry.size(width, height))
end

return screens
