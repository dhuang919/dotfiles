local wezterm = require("wezterm")
local act = wezterm.action
local c = {
  adjust_window_size_when_changing_font_size = false,
  colors = { cursor_bg = "#fff" },
  default_cursor_style = "SteadyBar",
  enable_scroll_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  initial_cols = 120,
  initial_rows = 35,
  leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 },
  keys = {
    {
      key = "w",
      mods = "CMD",
      action = wezterm.action.CloseCurrentTab({ confirm = false }),
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
      key = "/",
      action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    { mods = "LEADER", key = "LeftArrow", action = act.ActivatePaneDirection("Left") },
    { mods = "LEADER", key = "h", action = act.ActivatePaneDirection("Left") },
    { mods = "LEADER", key = "RightArrow", action = act.ActivatePaneDirection("Right") },
    { mods = "LEADER", key = "l", action = act.ActivatePaneDirection("Right") },
    { mods = "LEADER", key = "UpArrow", action = act.ActivatePaneDirection("Up") },
    { mods = "LEADER", key = "k", action = act.ActivatePaneDirection("Up") },
    { mods = "LEADER", key = "DownArrow", action = act.ActivatePaneDirection("Down") },
    { mods = "LEADER", key = "j", action = act.ActivatePaneDirection("Down") },
    { mods = "LEADER", key = "p", action = act.ActivateTabRelative(-1) },
    { mods = "LEADER", key = "n", action = act.ActivateTabRelative(1) },
    { mods = "LEADER", key = "x", action = act.CloseCurrentPane({ confirm = false }) },
    { mods = "LEADER", key = "X", action = act.CloseCurrentTab({ confirm = false }) },
    { mods = "LEADER", key = "c", action = act.SpawnTab("CurrentPaneDomain") },
    {
      mods = "LEADER",
      key = "!",
      action = wezterm.action_callback(function(_win, pane)
        local _tab, _ = pane:move_to_new_tab()
      end),
    },
    {
      key = "H",
      mods = "LEADER",
      action = act.AdjustPaneSize({ "Left", 5 }),
    },
    {
      key = "J",
      mods = "LEADER",
      action = act.AdjustPaneSize({ "Down", 5 }),
    },
    {
      key = "K",
      mods = "LEADER",
      action = act.AdjustPaneSize({ "Up", 5 }),
    },
    {
      key = "L",
      mods = "LEADER",
      action = act.AdjustPaneSize({ "Right", 5 }),
    },
  },
  use_dead_keys = false,
  window_close_confirmation = "NeverPrompt",
  window_decorations = "TITLE | RESIZE | MACOS_FORCE_DISABLE_SHADOW",
}

if string.find(wezterm.home_dir, "derek", 1, true) then
  c.default_cwd = wezterm.home_dir .. "/dev"
elseif string.find(wezterm.home_dir, "dhuang295", 1, true) then
  c.default_cwd = wezterm.home_dir .. "/Projects/tssr"
end

return c
