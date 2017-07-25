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
                action = "fill",
                fillColor = { alpha = 0.8, red = 1 },
                type = "rectangle",
                frame = { x = "0%", y = "0%", h = "100%", w = "100%" },
                roundedRectRadii = { xRadius = 5, yRadius = 5 }
            })
        end
        audio.muteStatusCanvas:show()
    end
end

-- Start the mute status watcher
audio.updateMuteWatcher()
-- And check every 30 seconds in case the default input changed
audio.muteWatcherTimer = hs.timer.doEvery(30, audio.updateMuteWatcher)

return audio
