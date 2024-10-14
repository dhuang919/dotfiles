local wezterm = require("wezterm")
local act = wezterm.action
local c = wezterm.config_builder()
c.adjust_window_size_when_changing_font_size = false
c.colors = { cursor_bg = "#fff" }
c.default_cursor_style = "SteadyBar"
c.enable_scroll_bar = true
c.hide_tab_bar_if_only_one_tab = true
c.initial_cols = 120
c.initial_rows = 35
c.use_dead_keys = false
c.window_close_confirmation = "NeverPrompt"
c.window_decorations = "TITLE | RESIZE | MACOS_FORCE_DISABLE_SHADOW"
c.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1500 }
c.keys = {
  {
    key = "w",
    mods = "CMD",
    action = act.CloseCurrentTab({ confirm = false }),
  },
  {
    key = "k",
    mods = "CMD",
    action = act.ClearScrollback("ScrollbackAndViewport"),
  },
  {
    mods = "LEADER",
    key = "-",
    action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    mods = "LEADER",
    key = "_",
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  { mods = "CTRL", key = "h", action = act.ActivatePaneDirection("Left") },
  { mods = "CTRL", key = "l", action = act.ActivatePaneDirection("Right") },
  { mods = "CTRL", key = "k", action = act.ActivatePaneDirection("Up") },
  { mods = "CTRL", key = "j", action = act.ActivatePaneDirection("Down") },
  { mods = "LEADER", key = "p", action = act.ActivateTabRelative(-1) },
  { mods = "LEADER", key = "n", action = act.ActivateTabRelative(1) },
  { mods = "LEADER", key = "x", action = act.CloseCurrentPane({ confirm = false }) },
  { mods = "LEADER", key = "+", action = act.TogglePaneZoomState },
  {
    key = "H",
    mods = "LEADER",
    action = act.AdjustPaneSize({ "Left", 10 }),
  },
  {
    key = "J",
    mods = "LEADER",
    action = act.AdjustPaneSize({ "Down", 10 }),
  },
  {
    key = "K",
    mods = "LEADER",
    action = act.AdjustPaneSize({ "Up", 10 }),
  },
  {
    key = "L",
    mods = "LEADER",
    action = act.AdjustPaneSize({ "Right", 10 }),
  },
}

-- LEADER + number to activate that tab
for i = 1, 9 do
  table.insert(c.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = wezterm.action.ActivateTab(i - 1),
  })
end

if string.find(wezterm.home_dir, "derek", 1, true) then
  c.default_cwd = wezterm.home_dir .. "/dev"
elseif string.find(wezterm.home_dir, "dhuang295", 1, true) then
  c.default_cwd = wezterm.home_dir .. "/Projects/tssr"
end

return c
