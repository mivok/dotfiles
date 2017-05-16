-- Hammerspoon script to automatically update your slack status when in zoom
--
-- To use:
--
-- * Install and set up the slack_status.sh script
-- * Ensure there is a 'zoom' preset (one is created by default during setup)
-- * Update the configuration of the script below
-- * Install hammerspoon (brew cask install hammerspoon)
-- * Copy this file to ~/.hammerspoon
-- * Add the following line to ~/.hammerspoon/init.lua
--      local zoom_detect = require("zoom_detect")

-- Configuration
check_interval=20 -- How often to check if you're in zoom, in seconds

function update_status(status)
    task = hs.execute("slack_status.sh " .. status, true)
end

inzoom = false
timer = hs.timer.doEvery(check_interval, function()
    if hs.application.find("Zoom Meeting ID") ~= nil then
        if inzoom == false then
            inzoom = true
            hs.notify.show("Started zoom meeting", "Updating slack status", "")
            update_status("zoom")
        end
    else
        if inzoom == true then
            inzoom = false
            hs.notify.show("Left zoom meeting", "Updating slack status", "")
            update_status("none")
        end
    end
end)
timer:start()
