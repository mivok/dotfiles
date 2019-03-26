---- Hammerspoon config ----

---- Load modules ----

audio = require("audio")
layouts = require("layouts")
-- Disable zoom detection for now until slack gets its act together with
-- others seeing status updates
--zoom_detect = require("zoom_detect")

---- Hotkeys ----

-- Pause key for spotify/itunes
last_paused = hs.spotify -- Default music player
hs.hotkey.bind({}, "F15", function()
    if hs.spotify.isPlaying() then
        hs.alert.show("Pausing spotify")
        hs.spotify.pause()
        last_paused = hs.spotify
    elseif hs.itunes.isPlaying() then
        hs.alert.show("Pausing itunes")
        hs.itunes.pause()
        last_paused = hs.itunes
    else
        hs.alert.show("Playing music")
        last_paused.play()
    end
end)

-- Pause key for browser
hs.hotkey.bind({}, "F16", function()
    hs.alert.show("Browser play/pause")
    -- There's a different hotkey in chrome Streamkeys for pausing, so send it
    -- TODO - fix this so it works
    hs.eventtap.keyStroke({"ctrl", "cmd"}, "P")
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

-- Away/back
hs.hotkey.bind({}, "F17", function()
    hs.alert.show("Away")
    hs.task.new(os.getenv("HOME") .. "/bin/awayback.sh", nil, {"away"}):start()
end)
hs.hotkey.bind({}, "F18", function()
    hs.alert.show("Back")
    hs.task.new(os.getenv("HOME") .. "/bin/awayback.sh", nil, {"back"}):start()
end)

-- Blank keys - workaround for crappy discord hotkey binding
hs.hotkey.bind({}, "F19", function() end)
hs.hotkey.bind({}, "F20", function() end)

-- Alternate shush key
hs.hotkey.bind({"ctrl"}, "space", function()
    hs.eventtap.event.newKeyEvent({}, "F13", true):post()
end,
function()
    hs.eventtap.event.newKeyEvent({}, "F13", false):post()
end)

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
