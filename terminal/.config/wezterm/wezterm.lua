local wezterm = require 'wezterm';

-- Create a new tab, split into 4 equal sized panes, 2x2
wezterm.on("new-4up-tab", function(window, pane)
  window:perform_action(wezterm.action{SpawnTab="CurrentPaneDomain"}, pane)
  window:perform_action(wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}, pane)
  window:perform_action(wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}, pane)
  window:perform_action(wezterm.action {ActivatePaneDirection = "Left"}, pane)
  window:perform_action(wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}, pane)
  window:perform_action(wezterm.action {ActivatePaneDirection = "Up"}, pane)
end)

return {
  font = wezterm.font_with_fallback({
    "Hack Nerd Font", -- The main font I want to use
    "Menlo", -- This has the check mark and cross symbols
    "Apple Color Emoji" -- I prefer apple emoji to google emoji
  }, {weight="Medium"}),
  font_size = 14,
  -- This looks a bit better to me than Normal
  freetype_load_target = "HorizontalLcd",
  color_scheme = "Builtin Tango Dark",
  window_background_opacity = 0.8,
  initial_cols = 161,
  initial_rows = 49,
  pane_focus_follows_mouse = true,
  -- Don't dim inactive panes
  inactive_pane_hsb = {
    saturation = 1.0,
    brightness = 1.0,
  },
  exit_behavior = "Close",
  -- Enable once https://github.com/wez/wezterm/issues/797 is in a release
  --tab_bar_at_bottom = true,
  -- I like CTRL-A as a terminal prefix, like screen
  leader = {key = "a", mods = "CTRL", timeout_milliseconds = 1000},
  keys = {
    -- Pane splitting, like I had set up with tmux
    {
      key = "|",
      mods = "LEADER|SHIFT",
      action = wezterm.action {SplitHorizontal = {domain = "CurrentPaneDomain"}}
    }, {
      key = "-",
      mods = "LEADER",
      action = wezterm.action {SplitVertical = {domain = "CurrentPaneDomain"}}
    }, {
      key = "LeftArrow",
      mods = "LEADER",
      action = wezterm.action {ActivatePaneDirection = "Left"}
    }, {
      key = "RightArrow",
      mods = "LEADER",
      action = wezterm.action {ActivatePaneDirection = "Right"}
    }, {
      key = "UpArrow",
      mods = "LEADER",
      action = wezterm.action {ActivatePaneDirection = "Up"}
    }, {
      key = "DownArrow",
      mods = "LEADER",
      action = wezterm.action {ActivatePaneDirection = "Down"}
    }, {
      key = "t",
      mods = "LEADER",
      action = wezterm.action {EmitEvent="new-4up-tab"}
    }
  },
  mouse_bindings = {
    -- Allow Cmd click to open links like in iterm2
    {
      event={Up={streak=1, button="Left"}},
      mods="SUPER",
      action="OpenLinkAtMouseCursor",
    },
  }
}
