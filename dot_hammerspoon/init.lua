local s = require("screens")
local external_connected = s.screens["HORIZONTAL"] ~= nil or s.screens["VERTICAL"] ~= nil

local ratios = {
  bbvpn = { top = 0.647, left = 0.008, height = 0.341, width = 0.160 },
  calendar = { top = 0.046, left = 0.603, height = 0.378, width = 0.383 },
  chrome_horizontal = { top = 0.078, left = 0.506, height = 0.786, width = 0.472 },
  chrome_vertical = { top = 0.19, left = 0, height = 0.378, width = 1 },
  wezterm = {
    top = external_connected and 0.568 or 0,
    left = 0,
    height = external_connected and 0.432 or 0.65,
    width = external_connected and 1 or 0.58,
  },
  mail = { top = 0.03, left = 0.004, height = 0.77, width = 0.8 },
  slack_horizontal = { top = 0.038, left = 0.020, height = 0.871, width = 0.467 },
  spotify = { top = 0.463, left = 0.013, height = 0.500, width = 0.426 },
  obsidian = { top = 0.431, left = 0.500, height = 0.552, width = 0.483 },
  messages = { top = 0.595, left = 0.668, height = 0.365, width = 0.321 },
}

hs.hotkey.bind({ "alt", "cmd" }, "w", function()
  s.moveIfOpen("Spotify", "HORIZONTAL", ratios.spotify)
  s.moveIfOpen("bbvpn2", "HORIZONTAL", ratios.bbvpn)
  s.moveIfOpen("Calendar", "HORIZONTAL", ratios.calendar)
  s.moveIfOpen("Obsidian", "HORIZONTAL", ratios.obsidian)
  s.moveIfOpen("Messages", "HORIZONTAL", ratios.messages)
  s.moveIfOpen("Slack", "HORIZONTAL", ratios.slack_horizontal)
  s.moveIfOpen(
    "WezTerm",
    external_connected and "VERTICAL" or "LAPTOP",
    ratios.wezterm,
    false,
    true
  )
  s.moveIfOpen(
    "Google Chrome",
    external_connected and "VERTICAL" or "LAPTOP",
    external_connected and ratios.chrome_vertical or ratios.chrome_horizontal,
    false,
    true
  )
end)

hs.hotkey.bind({ "alt", "cmd" }, "r", function()
  hs.reload()
  hs.alert.show("Hammerspoon config reloaded")
end)

hs.hotkey.bind({ "alt", "cmd" }, "c", function()
  s.moveIfOpen("Google Chrome", "HORIZONTAL", ratios.chrome_horizontal, false, true)
end)

hs.hotkey.bind({ "alt", "cmd" }, "o", function()
  s.moveIfOpen("WezTerm", "HORIZONTAL", ratios.obsidian)
end)

hs.hotkey.bind({ "alt", "cmd" }, "s", function()
  s.moveIfOpen("WezTerm", "HORIZONTAL", nil, true, true)
end)

hs.hotkey.bind({ "alt", "cmd" }, "x", function()
  s.printFocusedWindowRatios()
end)
