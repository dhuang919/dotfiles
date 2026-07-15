local S = { screens = {}, locked = {} }

-- Disable window animations since they slow down transitions
hs.window.animationDuration = 0

-- Map screens by grid position:
--   LAPTOP     = primary display (0,0)
--   HORIZONTAL = monitor directly above laptop (0,-1)
--   VERTICAL   = monitor to the right, either above or level (1,-1 or 1,0)
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

-- Place a window on the given screen using ratio-based coordinates.
-- If the window is currently fullscreen, exit fullscreen first and
-- wait for macOS to finish the transition before placing.
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

-- Low-level move: either fullscreen the window on the target screen,
-- or compute an absolute frame from screen-relative ratios and apply it.
function S._moveWindow(window, screenObj, ratios, fullscreen)
  if fullscreen then
    window:moveToScreen(screenObj)
    hs.timer.doAfter(0.2, function()
      window:setFullScreen(true)
    end)
    return
  end
  local function set_frame()
    local screenFrame = screenObj:fullFrame()
    local f = hs.geometry.rect(
      screenFrame.x + screenFrame.w * ratios.left,
      screenFrame.y + screenFrame.h * ratios.top,
      screenFrame.w * ratios.width,
      screenFrame.h * ratios.height
    )
    window:move(f, screenObj, false)
  end

  -- Move to screen first and delay resize so macOS can finish the
  -- screen transition; without this the frame often applies partially.
  if window:screen():id() ~= screenObj:id() then
    window:moveToScreen(screenObj)
    hs.timer.doAfter(0.3, set_frame)
  else
    set_frame()
  end
end

-- Find a running app by name, activate it, and place its focused window.
-- If lock=true, the window is marked so subsequent moveIfOpen calls skip it
-- (prevents the same window from being repositioned by later hotkey presses).
-- Locks reset on Hammerspoon reload.
function S.moveIfOpen(appName, screenKey, ratios, fullscreen, lock)
  lock = lock or false
  local app = hs.application.get(appName)
  if not app then
    print("No app found for " .. appName)
    return false
  end
  if type(app.activate) ~= "function" then
    print(appName .. " doesn't have an activate() method")
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

-- Print the focused window's position as screen-relative ratios (0-1)
-- to the Hammerspoon console for easy copy-pasting into the ratios table.
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
  -- Space-padded equals and commas for easy copy pasting into `ratios` dict
  local msg = string.format(
    "app_name = %s top = %.3f, left = %.3f, height = %.3f, width = %.3f",
    win:application():name(),
    top,
    left,
    height,
    width
  )
  print(msg)
  hs.alert.show("Ratios printed to console")
end

return S
