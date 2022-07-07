local wezterm = require 'wezterm';

-- Resize the window (called by event handlers)
function resize_window(window, pane, cols, rows)
  local overrides = window:get_config_overrides() or {}
  overrides.initial_cols = cols
  overrides.initial_rows = rows
  window:set_config_overrides(overrides)
  window:perform_action(wezterm.action.ResetFontAndWindowSize, pane)
end

-- Split either horizontal or vertical as appropriate
wezterm.on("split-auto", function(window, pane)
  local dimensions = pane:get_dimensions()
  -- Hack until I can get actual pixel dimensions of a pane
  local char_width = 8
  local char_height = 14
  if dimensions.cols * char_width > dimensions.viewport_rows * char_height then
    window:perform_action(wezterm.action.SplitHorizontal, pane)
  else
    window:perform_action(wezterm.action.SplitVertical, pane)
  end
end)

-- Search current window for biggest pane, then split it appropriately and
-- activate it (i.e. give me a new pane in the best place)
-- TODO - this needs features that are only in nightly - it needs testing
-- and fixing once the features are in a released version.
wezterm.on("new-pane-auto", function(window, pane)
  -- Get the MuxTab object for the active tab, so we can go through the
  -- panes one by one
  local mux_window = window:mux_window()
  local active_tab 
  for i, t in pairs(mux_window:tables_with_info()) do
    if t.is_active then
      active_tab = t.tab
    end
  end

  -- Identify the largest pane (and also which direction to split it in)
  local largest_pane
  local largest_dimension = 0
  local direction
  for i, p in pairs(active_tab:panes()) do
    if p.width > largest_dimension then
      largest_dimension = p.width
      largest_pane = p.pane
      direction = "Right"
    end
    if p.height > largest_dimension then
      largest_dimension = p.height
      largest_pane = p.pane
      direction = "Bottom"
    end
  end

  -- Actually split the pane
  pane:split{direction=direction}
end)

return {
  -- I don't want the update pop ups
  check_for_updates = false,

  -- Font config
  font = wezterm.font_with_fallback({
    "Hack", -- The main font I want to use
    "Apple Color Emoji" -- I prefer apple emoji if they're present
  }),
  font_size = 12,
  cell_width = 1.1,

  color_scheme = "Builtin Tango Dark",
  window_background_opacity = 0.8,
  initial_cols = 169,
  initial_rows = 49,

  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0
  },

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

  -- Set CTRL-A as the LEADER modification
  leader = {key = "a", mods = "CTRL", timeout_milliseconds = 1000},
  keys = {
    -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
    {
      key="a",
      mods="LEADER|CTRL",
      action=wezterm.action.SendString("\x01")
    }, {
      key = "|",
      mods = "LEADER|SHIFT",
      action = wezterm.action.SplitHorizontal
    }, {
      key = "-",
      mods = "LEADER",
      action = wezterm.action.SplitVertical
    }, {
      key = "Enter",
      mods = "LEADER",
      action = wezterm.action.EmitEvent("split-auto")
    }, {
      key = "=",
      mods = "LEADER",
      action = wezterm.action.EmitEvent("new-pane-auto")
    }, {
      key = "LeftArrow",
      mods = "LEADER",
      action = wezterm.action.ActivatePaneDirection("Left")
    }, {
      key = "RightArrow",
      mods = "LEADER",
      action = wezterm.action.ActivatePaneDirection("Right")
    }, {
      key = "UpArrow",
      mods = "LEADER",
      action = wezterm.action.ActivatePaneDirection("Up")
    }, {
      key = "DownArrow",
      mods = "LEADER",
      action = wezterm.action.ActivatePaneDirection("Down")
    }, {
      key = "0",
      mods = "LEADER",
      action = "ResetFontAndWindowSize"
    }, {
      key = "1",
      mods = "LEADER",
      action = wezterm.action_callback(function(window, pane)
        resize_window(window, pane, 169, 49)
      end)
    }, {
      key = "2",
      mods = "LEADER",
      action = wezterm.action_callback(function(window, pane)
        resize_window(window, pane, 201, 49)
      end)
    }, {
      key = "?",
      mods = "LEADER|SHIFT",
      action = wezterm.action.SpawnCommandInNewTab {
        args={"sh", "-c", "wezterm show-keys | less"}
      }
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
