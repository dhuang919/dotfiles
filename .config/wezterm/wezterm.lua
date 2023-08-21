local wezterm = require "wezterm"
local config = {}

config.colors = {
  cursor_bg = "#fff"
}
config.adjust_window_size_when_changing_font_size = false
config.default_cwd = wezterm.home_dir .. "/dev/bradfield/derekhuang"
config.hide_tab_bar_if_only_one_tab = true
config.initial_cols = 120
config.initial_rows = 35
config.use_dead_keys = false
config.window_close_confirmation = "NeverPrompt"

return config
