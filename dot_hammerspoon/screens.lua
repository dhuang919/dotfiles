local S = { screens = {}, locked = {} }

for _, screen in ipairs(hs.screen.allScreens()) do
  local x, y = screen:position()
  if x == 0 and y == 0 then
    S.screens.LAPTOP = screen
  end
  if x == 0 and y == -1 then
    S.screens.HORIZONTAL = screen
  end
  if x == 1 and (y == -1 or y == 0) then
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
    window:moveToScreen(screenObj)
    hs.timer.doAfter(0.2, function()
      window:setFullScreen(true)
    end)
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

function S.moveIfOpen(appName, screenKey, ratios, fullscreen, lock)
  lock = lock or false
  local app = hs.application.get(appName)
  if not app then
    return false
  end
  app:activate()
  local win = app:focusedWindow()
  if not win then
    hs.alert.show("Window for app " .. appName .. " not found")
    return false
  end
  if S.isLocked(win) then
    hs.alert.show(appName .. " window locked")
    return false
  end
  if lock then
    S.locked[win:id()] = true
  end
  S.placeWindow(win, screenKey, ratios, fullscreen)
  return true
end

function S.isLocked(win)
  return win and S.locked[win:id()]
end

function S.printFocusedWindowRatios()
  local win = hs.window.focusedWindow()
  if not win then
    hs.alert.show("No focused window")
    return
  end
  local screenFrame = win:screen():fullFrame()
  local winFrame = win:frame()
  local top = (winFrame.y - screenFrame.y) / screenFrame.h
  local left = (winFrame.x - screenFrame.x) / screenFrame.w
  local height = winFrame.h / screenFrame.h
  local width = winFrame.w / screenFrame.w
  local msg =
    string.format("top = %.3f, left = %.3f, height = %.3f, width = %.3f", top, left, height, width)
  print(msg)
  hs.alert.show("Ratios printed to console")
end

return S
