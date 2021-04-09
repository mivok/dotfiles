-- Monitor changes to audio devices
local audio = {}

local log = hs.logger.new('audio', 'debug')
-- Sets up a watcher to detect when the default input device is muted
-- This should be called whenever the default input device changes
function audio.updateMuteWatcher()
    -- Skip if we don't need to update anything
    if audio.muteWatcherDevice == hs.audiodevice.defaultInputDevice() and
        audio.muteWatcherDevice:watcherIsRunning() then
        return
    end
    -- Stop any existing watcher
    if audio.muteWatcherDevice then
        audio.muteWatcherDevice:watcherCallback(nil)
        audio.muteWatcherDevice:watcherStop()
    end
    audio.muteWatcherDevice = hs.audiodevice.defaultInputDevice()
    log.d("Updated muteWatcherDevice to " .. tostring(audio.muteWatcherDevice))
    audio.muteWatcherDevice:watcherCallback(function(dev, event, scope, element)
        -- Note: multiple mute events may be sent, do doing something like a
        -- notification/alert is probably not a good idea here.
        if event == "mute" then
            audio.updateMuteStatus(audio.muteWatcherDevice:muted())
        end
    end)
    audio.muteWatcherDevice:watcherStart()
end

function audio.updateMuteStatus(muted)
    -- Shows or hides the mute indicator
    if muted and audio.muteStatusCanvas then
        audio.muteStatusCanvas:hide()
    end
    if not muted then
        if not audio.muteStatusCanvas then
            local width = 30
            local height = 30
            local textsize = 16
            audio.muteStatusCanvas = hs.canvas.new{x=5, y=25,
                h=height, w=width}
            audio.muteStatusCanvas:appendElements({
                action = "strokeAndFill",
                fillColor = { alpha = 0.8, red = 1 },
                type = "circle",
                radius = "45%", -- <50% to allow room for the border/stroke
            })
            -- Make the icon always on top
            -- See https://www.hammerspoon.org/docs/hs.canvas.html#windowLevels
            -- for a description of levels
            audio.muteStatusCanvas:level(hs.canvas.windowLevels.overlay)
            -- Make window still visible in full screen and on space change
            audio.muteStatusCanvas:behavior("canJoinAllSpaces")
        end
        -- Note: for this to show up above full screen windows (e.g. zoom) we
        -- need to hide the hammerspoon dock icon in hammerspoon preferences.
        audio.muteStatusCanvas:show()
    end
end

-- Start the mute status watcher
audio.updateMuteWatcher()
-- And check every 30 seconds in case the default input changed
audio.muteWatcherTimer = hs.timer.doEvery(30, audio.updateMuteWatcher)

return audio
