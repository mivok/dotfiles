local wezterm = require 'wezterm';
local config = wezterm.config_builder()

-- Resize the window (called by event handlers)
function resize_window(window, pane, cols, rows)
  local overrides = window:get_config_overrides() or {}
  overrides.initial_cols = cols
  overrides.initial_rows = rows
  window:set_config_overrides(overrides)
  window:perform_action(wezterm.action.ResetFontAndWindowSize, pane)
end

-- Get the pane_info as returned by tab:panes_with_info() from a Pane object
-- This is mostly useful for getting the pixel_width and pixel_height for a
-- pane.
function pane_info(pane)
  for _, p in pairs(pane:tab():panes_with_info()) do
    if p.pane:pane_id() == pane:pane_id() then
      return p
    end
  end
end

-- Split either horizontal or vertical as appropriate
wezterm.on("split-auto", function(window, pane)
  local pane_info = pane_info(pane)
  if pane_info.pixel_width > pane_info.pixel_height then
    window:perform_action(wezterm.action.SplitHorizontal, pane)
  else
    window:perform_action(wezterm.action.SplitVertical, pane)
  end
end)

-- Search current window for biggest pane, then split it appropriately and
-- activate it (i.e. give me a new pane in the best place)
-- Requires wezterm 20220807-113146-c2fee766 or later
wezterm.on("new-pane-auto", function(window, _)
  -- Get the MuxTab object for the active tab, so we can go through the
  -- panes one by one
  local active_tab = window:active_tab()

  -- Identify the largest pane (and also which direction to split it in)
  local largest_pane
  local largest_dimension = 0
  local direction
  local window_dimensions = window:get_dimensions()
  for _, p in pairs(active_tab:panes_with_info()) do
    -- Use the percentage of the window height/width rather than raw pixel
    -- height/width when calculating the largest pane to make the split in.
    -- If we use the raw pixel with, we get the wrong type of split when using
    -- very wide windows. What I'm trying to achieve is alternating
    -- horizontal/vertical splits when splitting a pane up, or rather finding
    -- the pane which has been split up the least and split that appropriately.
    -- Using the percentage is an okish proxy for this.
    -- Note: I'm not taking into account the tab bar height or any window
    -- padding here, so there is still the potential for incorrect behavior.
    width_fraction = p.pixel_width / window_dimensions.pixel_width
    height_fraction = p.pixel_height / window_dimensions.pixel_height
    if width_fraction > largest_dimension then
      largest_dimension = width_fraction
      largest_pane = p.pane
      direction = "Right"
    end
    if height_fraction > largest_dimension then
      largest_dimension = height_fraction
      largest_pane = p.pane
      direction = "Bottom"
    end
  end

  -- Actually split the pane
  largest_pane:split{direction=direction}
end)

-- I don't want the update pop ups
config.check_for_updates = false

-- Font config
config.font = wezterm.font_with_fallback({
  "Hack", -- The main font I want to use
  "Apple Color Emoji" -- I prefer apple emoji if they're present
})
config.font_size = 12
config.cell_width = 1.1

config.color_scheme = "Builtin Tango Dark"
config.window_background_opacity = 0.8
config.initial_cols = 173
config.initial_rows = 49

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0
}

-- Don't dim inactive panes
config.inactive_pane_hsb = {
  saturation = 1.0,
  brightness = 1.0,
}

-- Always close the pane on process exit
config.exit_behavior = "Close"

-- Tab bar behavior
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- Set CTRL-A as the LEADER modification
config.leader = {key = "a", mods = "CTRL", timeout_milliseconds = 1000}
config.keys = {
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
    action = wezterm.action.EmitEvent("new-pane-auto")
  }, {
    key = "=",
    mods = "LEADER",
    action = wezterm.action.EmitEvent("split-auto")
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
      resize_window(window, pane, 173, 49)
    end)
  }, {
    key = "2",
    mods = "LEADER",
    action = wezterm.action_callback(function(window, pane)
      resize_window(window, pane, 201, 49)
    end)
  }, {
    key = "3",
    mods = "LEADER",
    action = wezterm.action_callback(function(window, pane)
      resize_window(window, pane, 110, 35)
    end)
  }, {
    key = "?",
    mods = "LEADER|SHIFT",
    action = wezterm.action.SpawnCommandInNewTab {
      args={"sh", "-c",
        wezterm.procinfo.executable_path_for_pid(wezterm.procinfo.pid()) ..
        " show-keys | less"
      }
    }
  }
}
config.mouse_bindings = {
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

return config
