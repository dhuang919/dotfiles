local wezterm = require("wezterm")
local act = wezterm.action
local c = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

local function is_vi_proc(pane)
  return pane:get_foreground_process_name():find("n?vim") ~= nil
    or pane:get_title():find("n?vim") ~= nil
end

local function conditional_activate_pane(window, pane, pane_direction, vim_direction)
  if is_vi_proc(pane) then
    -- should match nvim keybinds
    window:perform_action(act.SendKey({ key = vim_direction, mods = "CTRL" }), pane)
  else
    window:perform_action(act.ActivatePaneDirection(pane_direction), pane)
  end
end

wezterm.on("ActivatePaneDirection-right", function(window, pane)
  conditional_activate_pane(window, pane, "Right", "l")
end)
wezterm.on("ActivatePaneDirection-left", function(window, pane)
  conditional_activate_pane(window, pane, "Left", "h")
end)
wezterm.on("ActivatePaneDirection-up", function(window, pane)
  conditional_activate_pane(window, pane, "Up", "k")
end)
wezterm.on("ActivatePaneDirection-down", function(window, pane)
  conditional_activate_pane(window, pane, "Down", "j")
end)

c.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 2000 }
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
    key = "|",
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    mods = "LEADER",
    key = "/",
    action = act.SplitPane({ direction = "Right", size = { Percent = 27 } }),
  },
  { key = "[", mods = "LEADER", action = act.ActivateCopyMode },
  { mods = "CTRL", key = "h", action = act.EmitEvent("ActivatePaneDirection-left") },
  { mods = "CTRL", key = "l", action = act.EmitEvent("ActivatePaneDirection-right") },
  { mods = "CTRL", key = "k", action = act.EmitEvent("ActivatePaneDirection-up") },
  { mods = "CTRL", key = "j", action = act.EmitEvent("ActivatePaneDirection-down") },
  { mods = "LEADER", key = "o", action = act.ActivateLastTab },
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
  {
    key = ",",
    mods = "LEADER",
    action = act.PromptInputLine({
      description = "Tab name:",
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    }),
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

c.adjust_window_size_when_changing_font_size = false
c.colors = { cursor_bg = "#fff" }
c.default_cursor_style = "SteadyBar"
c.enable_scroll_bar = true
c.hide_tab_bar_if_only_one_tab = true
c.initial_cols = 120
c.initial_rows = 35
c.scrollback_lines = 5000
c.use_dead_keys = false
c.window_close_confirmation = "NeverPrompt"
c.window_decorations = "TITLE | RESIZE | MACOS_FORCE_DISABLE_SHADOW"

if string.find(wezterm.home_dir, "derek", 1, true) then
  c.default_cwd = wezterm.home_dir .. "/dev"
elseif string.find(wezterm.home_dir, "dhuang295", 1, true) then
  c.default_cwd = wezterm.home_dir .. "/Projects/tssr"
end

return c
