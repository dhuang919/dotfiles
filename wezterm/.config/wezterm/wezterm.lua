local wezterm = require("wezterm")
local act = wezterm.action
local c = {}

if wezterm.config_builder then
  c = wezterm.config_builder()
end

c.keys = {
  {
    key = "w",
    mods = "CMD",
    action = act.CloseCurrentTab({ confirm = false }),
  },
}

c.adjust_window_size_when_changing_font_size = false
c.colors = { cursor_bg = "#fff" }
c.default_cursor_style = "SteadyBar"
c.enable_scroll_bar = true
c.font = wezterm.font("0xProto")
c.font_size = 13
c.hide_tab_bar_if_only_one_tab = true
c.hyperlink_rules = wezterm.default_hyperlink_rules()
c.initial_cols = 120
c.initial_rows = 35
c.scrollback_lines = 10000
c.tab_bar_at_bottom = true
c.term = "wezterm"
c.use_dead_keys = false
c.window_close_confirmation = "NeverPrompt"
c.window_decorations = "TITLE | RESIZE | MACOS_FORCE_DISABLE_SHADOW"

if string.find(wezterm.home_dir, "derek", 1, true) then
  c.default_cwd = wezterm.home_dir .. "/dev"
elseif string.find(wezterm.home_dir, "dhuang295", 1, true) then
  c.default_cwd = wezterm.home_dir .. "/Projects/bbenv"
end

return c
