local s = require("screens")
local external_connected = s.screens["HORIZONTAL"] ~= nil or s.screens["VERTICAL"] ~= nil

local ratios = {
  bbvpn = { top = 0.647, left = 0.008, height = 0.341, width = 0.160 },
  calendar = { top = 0.046, left = 0.603, height = 0.378, width = 0.383 },
  chrome_lptp = { top = 0, left = 0.1, height = 1, width = 0.8 },
  chrome_ext_lptp = { top = 0.078, left = 0.506, height = 0.786, width = 0.472 },
  chrome_horiz = { top = 0.043, left = 0.342, height = 0.864, width = 0.613 },
  wezterm = {
    top = external_connected and 0.568 or 0,
    left = 0,
    height = external_connected and 0.432 or 0.65,
    width = external_connected and 1 or 0.58,
  },
  slack_lptp = { top = 0.063, left = 0.02, height = 0.85, width = 0.85 },
  slack_horizontal = { top = 0.037, left = 0.028, height = 0.871, width = 0.459 },
  spotify = { top = 0.463, left = 0.013, height = 0.500, width = 0.426 },
  obsidian_lptp = { top = 0.145, left = 0.17, height = 0.82, width = 0.8 },
  obsidian_lptp_ext = { top = 0.042, left = 0.007, height = 0.941, width = 0.978 },
  messages = { top = 0.452, left = 0.448, height = 0.535, width = 0.543 },
  citrix = {
    msg = { top = 0.078, left = 0.007, height = 0.656, width = 0.486 },
    appt = { top = 0.078, left = 0.5, height = 0.578, width = 0.489 },
    ib = { top = 0.333, left = 0.504, height = 0.656, width = 0.481 },
  },
}

local bind_keys = { "alt", "cmd" }

hs.hotkey.bind(bind_keys, "w", function()
  s.moveIfOpen("Spotify", "HORIZONTAL", ratios.spotify)
  s.moveIfOpen("bbvpn2", "HORIZONTAL", ratios.bbvpn)
  s.moveIfOpen("Calendar", "HORIZONTAL", ratios.calendar)
  s.moveIfOpen("Slack", "HORIZONTAL", ratios.slack_horizontal)
  s.moveIfOpen("Messages", "LAPTOP", ratios.messages)
  s.moveIfOpen("WezTerm", "VERTICAL", nil, true, true)
  s.moveIfOpen(
    "Google Chrome",
    external_connected and "HORIZONTAL" or "LAPTOP",
    external_connected and ratios.chrome_horiz or ratios.chrome_ext_lptp,
    false,
    true
  )
end)

hs.hotkey.bind(bind_keys, "r", function()
  hs.reload()
  hs.alert.show("Hammerspoon config reloaded")
end)

-- Secondary chrome window
hs.hotkey.bind(bind_keys, "c", function()
  s.moveIfOpen("Google Chrome", "LAPTOP", ratios.chrome_lptp, false, true)
end)

-- Fullscreen terminal for text editing on external monitor
hs.hotkey.bind(bind_keys, "s", function()
  s.moveIfOpen("WezTerm", "VERTICAL", nil, true, true)
end)

-- Print app name and top/left/height/width of the focused window to console
hs.hotkey.bind(bind_keys, "x", function()
  s.printFocusedWindowRatios()
end)

-- Size and place window with MSG
hs.hotkey.bind(bind_keys, "m", function()
  s.moveIfOpen("Citrix Viewer", "HORIZONTAL", ratios.citrix.msg, false, false)
end)

-- Size and place window with APPT
hs.hotkey.bind(bind_keys, "a", function()
  s.moveIfOpen("Citrix Viewer", "HORIZONTAL", ratios.citrix.appt, false, false)
end)

-- Size and place window with IB
hs.hotkey.bind(bind_keys, "i", function()
  s.moveIfOpen("Citrix Viewer", "HORIZONTAL", ratios.citrix.ib, false, false)
end)

hs.hotkey.bind(bind_keys, "g", function()
  hs.grid.show()
end)
