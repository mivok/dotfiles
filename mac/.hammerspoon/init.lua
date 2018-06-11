---- Hammerspoon config ----

---- Load modules ----

audio = require("audio")
layouts = require("layouts")
zoom_detect = require("zoom_detect")

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

-- Blank keys - workaround for crappy discord hotkey binding
hs.hotkey.bind({}, "F19", function() end)
hs.hotkey.bind({}, "F20", function() end)

---- Automatically reload the config ----
pw1 = hs.pathwatcher.new(os.getenv("HOME") ..
    "/.hammerspoon/", hs.reload):start()
-- I manage my dotfiles in a different dir and symlink to ~/.hammerspoon
pw2 = hs.pathwatcher.new(os.getenv("HOME") ..
    ".dotfiles/dotfiles-laptop/home/.hammerspoon/", hs.reload):start()
hs.notify.show("Hammerspoon",  "", "config loaded", "")

-- Force garbage collection early to quickly detect any issues caused by use
-- of local variables and garbage collection.
hs.timer.doAfter(5, collectgarbage)
