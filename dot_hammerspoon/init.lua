local s = require("screens")
local external_connected = s.screens["HORIZONTAL"] ~= nil or s.screens["VERTICAL"] ~= nil

local ratios = {
  bbvpn = { top = 0.5, left = 0.005, height = 0.4, width = 0.25 },
  calendar = { top = 0.07, left = 0.33, height = 0.6, width = 0.62 },
  chrome_lptp = { top = 0, left = 0.1, height = 1, width = 0.8 },
  chrome_ext = { top = 0.19, left = 0, height = 0.378, width = 1 },
  wezterm = {
    top = external_connected and 0.568 or 0,
    left = 0,
    height = external_connected and 0.432 or 0.65,
    width = external_connected and 1 or 0.58,
  },
  mail = { top = 0.03, left = 0.004, height = 0.77, width = 0.8 },
  slack = { top = 0.063, left = 0.02, height = 0.85, width = 0.85 },
  spotify = { top = 0.21, left = 0.01, height = 0.77, width = 0.7 },
  obsidian = { top = 0.145, left = 0.17, height = 0.82, width = 0.8 },
  messages = { top = 0.08, left = 0.017, height = 0.535, width = 0.544 },
}

hs.hotkey.bind({ "alt", "cmd" }, "w", function()
  s.moveIfOpen("Spotify", "LAPTOP", ratios.spotify)
  s.moveIfOpen("bbvpn2", "LAPTOP", ratios.bbvpn)
  s.moveIfOpen("Calendar", "LAPTOP", ratios.calendar)
  s.moveIfOpen("Obsidian", "LAPTOP", ratios.obsidian)
  s.moveIfOpen("Messages", "LAPTOP", ratios.messages)
  s.moveIfOpen("Slack", "LAPTOP", ratios.slack)
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
    external_connected and ratios.chrome_ext or ratios.chrome_lptp,
    false,
    true
  )
end)

hs.hotkey.bind({ "alt", "cmd" }, "r", function()
  hs.reload()
  hs.alert.show("Hammerspoon config reloaded")
end)

hs.hotkey.bind({ "alt", "cmd" }, "c", function()
  s.moveIfOpen("Google Chrome", "LAPTOP", ratios.chrome_lptp, false, true)
end)

hs.hotkey.bind({ "alt", "cmd" }, "o", function()
  s.moveIfOpen("WezTerm", "LAPTOP", ratios.obsidian)
end)

hs.hotkey.bind({ "alt", "cmd" }, "s", function()
  s.moveIfOpen("WezTerm", "HORIZONTAL", nil, true, true)
end)

hs.hotkey.bind({ "alt", "cmd" }, "x", function()
  s.printFocusedWindowRatios()
end)
