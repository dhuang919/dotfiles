local S = { screens = {} }

-- home horizontal U2518D
-- home vertical U2515H
local personal = {
  horizontal = "U2518D",
  vertical = "U2515H",
}

-- work horizontal BFP100-27 (1)
-- work vertical BFP100-27 (2)
local work = {
  horizontal = "BFP100-27.*%(1%)",
  vertical = "BFP100-27.*%(2%)",
}

for _, screen in ipairs(hs.screen.allScreens()) do
  local name = screen:name()
  if name:find("Retina") then
    S.screens.LAPTOP = screen
  end
  if name:find(personal.horizontal) then
    S.screens.HORIZONTAL = screen
  elseif name:find(work.horizontal) then
    S.screens.HORIZONTAL = screen
  end
  if name:find(personal.vertical) then
    S.screens.VERTICAL = screen
  elseif name:find(work.vertical) then
    S.screens.VERTICAL = screen
  end
end

function S.placeWindow(window, screenKey, ratios, fullscreen)
  local screenObj = S.screens[screenKey]
  if not screenObj or not window then
    return
  end

  if window:isFullScreen() then
    window:setFullScreen(false)
    hs.timer.doAfter(0.5, function()
      S._moveWindow(window, screenObj, ratios, fullscreen)
    end)
  else
    S._moveWindow(window, screenObj, ratios, fullscreen)
  end
end

function S._moveWindow(window, screenObj, ratios, fullscreen)
  if fullscreen then
    window:setFullScreen(true)
    return
  end
  local screenFrame = screenObj:fullFrame()
  local f = hs.geometry.rect(
    screenFrame.x + screenFrame.w * ratios.left,
    screenFrame.y + screenFrame.h * ratios.top,
    screenFrame.w * ratios.width,
    screenFrame.h * ratios.height
  )
  window:move(f, screenObj, false)
end

function S.moveIfOpen(appName, screenKey, ratios, fullscreen)
  local app = hs.application.get(appName)
  if not app then
    return false
  end
  app:activate()
  local win = app:focusedWindow()
  if not win then
    return false
  end
  S.placeWindow(win, screenKey, ratios, fullscreen)
  return true
end

function S.debugScreens()
  for _, screen in ipairs(hs.screen.allScreens()) do
    print("Name: " .. screen:name())
    print("UUID: " .. screen:getUUID())
    local pos = screen:position()
    print(string.format("Position: x=%d, y=%d", pos.x, pos.y))
  end
end

return S
