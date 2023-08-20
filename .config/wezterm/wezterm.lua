local wezterm = require "wezterm"
local config = {}

config.colors = {
  cursor_bg = "#fff"
}
config.default_cwd = wezterm.home_dir .. "/dev/bradfield/derekhuang"
config.font = wezterm.font "Source Code Pro for Powerline"
config.initial_cols = 120
config.initial_rows = 35
config.term = "wezterm"
config.window_close_confirmation = "NeverPrompt"

return config
