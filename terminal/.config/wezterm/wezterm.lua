local wezterm = require 'wezterm';

-- Resize the window (called by event handlers)
function resize_window(window, pane, cols, rows)
  local overrides = window:get_config_overrides() or {}
  overrides.initial_cols = cols
  overrides.initial_rows = rows
  window:set_config_overrides(overrides)
  window:perform_action("ResetFontAndWindowSize", pane)
end

-- Resize window handlers
wezterm.on("resize-small", function(window, pane)
  resize_window(window, pane, 169, 49)
end)

wezterm.on("resize-large", function(window, pane)
  resize_window(window, pane, 201, 49)
end)

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
  -- I don't want the update pop ups
  check_for_updates = false,

  -- Font config
  font = wezterm.font_with_fallback({
    "Hack", -- The main font I want to use
    "Apple Color Emoji" -- I prefer apple emoji if they're present
  }, {weight="Medium"}),
  font_size = 12,

  -- This looks a bit better to me than Normal
  freetype_load_target = "HorizontalLcd",
  color_scheme = "Builtin Tango Dark",
  window_background_opacity = 0.8,
  initial_cols = 169,
  initial_rows = 49,

  -- Don't dim inactive panes
  inactive_pane_hsb = {
    saturation = 1.0,
    brightness = 1.0,
  },
  exit_behavior = "Close",

  -- Tab bar behavior
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,

  -- I like CTRL-A as a terminal prefix, like screen
  leader = {key = "a", mods = "CTRL", timeout_milliseconds = 1000},
  keys = {
    -- Pane splitting, like I had set up with tmux
    {
      key = "|",
      mods = "LEADER",
      action = wezterm.action {SplitHorizontal = {domain = "CurrentPaneDomain"}}
    }, {
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
    }, {
      key = "0",
      mods = "LEADER",
      action = "ResetFontAndWindowSize"
    }, {
      key = "1",
      mods = "LEADER",
      action = wezterm.action {EmitEvent="resize-small"}
    }, {
      key = "2",
      mods = "LEADER",
      action = wezterm.action {EmitEvent="resize-large"}
    }
  },
  mouse_bindings = {
    -- Allow Cmd or CTRL click to open links like in iterm2
    {
      event={Up={streak=1, button="Left"}},
      mods="SUPER",
      action="OpenLinkAtMouseCursor",
    },
    {
      event={Up={streak=1, button="Left"}},
      mods="CTRL",
      action="OpenLinkAtMouseCursor",
    },
    -- Change the default click behavior so that it only selects
    -- text and doesn't open hyperlinks
    {
      event={Up={streak=1, button="Left"}},
      mods="NONE",
      action=wezterm.action{CompleteSelection="PrimarySelection"},
    },
  }
}
