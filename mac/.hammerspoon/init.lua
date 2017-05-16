---- Hammerspoon config ----

---- Load modules ----

-- Audio device watchers
local audio = require("audio")
local layouts = require("layouts")
local zoom_detect = require("zoom_detect")

---- Hotkeys ----

-- Pause key for spotify
hs.hotkey.bind({}, "F15", function()
    hs.alert.show("Spotify play/pause")
    hs.spotify.playpause()
end)

-- Lock screen
hs.hotkey.bind({"cmd", "alt"}, "L", function()
    hs.alert.show("Sleep screen")
    hs.task.new("/usr/bin/pmset", nil, {"displaysleepnow"}):start()
end)

-- Microphone
hs.hotkey.bind({}, "F14", function()
    level = 80
    ad = hs.audiodevice.defaultInputDevice()
    if ad ~= nil then
        ad:setInputVolume(level)
        hs.alert.show("Input volume reset to " .. level .. "%")
    else
        hs.alert.show("No input device found")
    end
end)

---- Automatically reload the config ----
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", hs.reload):start()
-- I manage my dotfiles in a different dir and symlink to ~/.hammerspoon
hs.pathwatcher.new(os.getenv("HOME") ..
    ".dotfiles/dotfiles-laptop/home/.hammerspoon/", hs.reload):start()
hs.notify.show("Hammerspoon",  "", "config loaded", "")
