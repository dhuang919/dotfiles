local wezterm = require("wezterm")
local act = wezterm.action
local c = {}

c.colors = {
  cursor_bg = "#fff",
}

c.adjust_window_size_when_changing_font_size = false

if string.find(wezterm.home_dir, "derek", 1, true) then
  c.default_cwd = wezterm.home_dir .. "/dev"
elseif string.find(wezterm.home_dir, "dhuang295", 1, true) then
  c.default_cwd = wezterm.home_dir .. "/Projects/tssr"
end

c.default_cursor_style = "SteadyBar"
c.enable_scroll_bar = true
c.hide_tab_bar_if_only_one_tab = true
c.initial_cols = 120
c.initial_rows = 35
c.keys = {
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
}

c.use_dead_keys = false
c.window_close_confirmation = "NeverPrompt"
c.window_decorations = "TITLE | RESIZE | MACOS_FORCE_DISABLE_SHADOW"

return c
