local o = require("open")
local s = require("screens")
local home = false
local work = false

if s.SCREENS["HORIZONTAL"] ~= nil then
  if s.SCREENS.HORIZONTAL:name() == "DELL U2518D" then
    home = true
  elseif s.SCREENS.HORIZONTAL:name() == "BFP100-27 (1)" then
    work = true
  end
end

local ratios = {
  bbvpn = {
    top = 0.57,
    left = 0.01,
    height = 0.4,
    width = 0.25,
  },
  calendar = {
    top = 0.07,
    left = 0.33,
    height = 0.6,
    width = 0.62,
  },
  chrome_lptp = {
    top = 0,
    left = 0.1,
    height = 1,
    width = 0.8,
  },
  chrome_hm = {
    top = 0.19,
    left = 0,
    height = 0.378,
    width = 1,
  },
  chrome_wrk = {
    top = 0,
    left = 0,
    height = 0.66,
    width = 0.5,
  },
  iterm = {
    top = home and 0.568 or 0,
    left = home and 0 or 0,
    height = home and 0.44 or 0.8,
    width = home and 1 or 0.6,
  },
  wezterm = {
    top = home and 0.568 or 0,
    left = home and 0 or 0,
    height = home and 0.44 or 0.8,
    width = home and 1 or 0.6,
  },
  mail = {
    top = 0.03,
    left = 0.004,
    height = 0.77,
    width = 0.8,
  },
  slack = {
    top = 0.063,
    left = 0.02,
    height = 0.85,
    width = 0.85,
  },
  spotify = {
    top = 0.24,
    left = 0.01,
    height = 0.77,
    width = 0.7,
  },
  obsidian = {
    top = 0.19,
    left = 0.12,
    height = 0.8,
    width = 0.85,
  },
}

hs.hotkey.bind({ "alt", "cmd", "ctrl" }, "W", function()
  o.moveIfOpen("Slack", "LAPTOP", ratios.slack)
  o.moveIfOpen("Spotify", "LAPTOP", ratios.spotify)
  o.moveIfOpen("bbvpn2", "LAPTOP", ratios.bbvpn)
  o.moveIfOpen("Calendar", "LAPTOP", ratios.calendar)
  o.moveIfOpen("Obsidian", "LAPTOP", ratios.obsidian)

  o.moveIfOpen("iTerm2", home and "VERTICAL" or "LAPTOP", ratios.iterm)
  o.moveIfOpen("WezTerm", home and "VERTICAL" or "LAPTOP", ratios.wezterm)

  if home then
    o.moveIfOpen("Google Chrome", "VERTICAL", ratios.chrome_hm)
  elseif work then
    o.moveIfOpen("Google Chrome", "VERTICAL", ratios.chrome_wrk)
  else
    o.moveIfOpen("Google Chrome", "LAPTOP", ratios.chrome_lptp)
  end
end)

hs.hotkey.bind({ "alt", "cmd", "ctrl" }, "R", function()
  hs.reload()
  hs.notify.new({ title = "Hammerspoon", informativeText = "Config reloaded" }):send()
end)
