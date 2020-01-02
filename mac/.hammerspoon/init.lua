---- Hammerspoon config ----

---- Load modules ----

audio = require("audio")
layouts = require("layouts")
hotkeys = require("hotkeys")
-- Disable zoom detection for now until slack gets its act together with
-- others seeing status updates
--zoom_detect = require("zoom_detect")

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
