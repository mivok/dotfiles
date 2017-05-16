-- Monitor changes to audio devices
local audio = {}

local muteStatusCanvas = nil
local muteWatcherDevice = nil

-- Print a message when the default audio device changes
hs.audiodevice.watcher.setCallback(function(e)
    if e == 'dIn ' then
        local d = hs.audiodevice.defaultInputDevice()
        local n = hs.notify.new(nil,
            {
                title="Default audio input device changed",
                informativeText=d:name(),
            }
        )
        n:setIdImage(hs.image.imageFromName("NSMediaBrowserMediaTypeAudio"))
        n:send()
        -- Change the device used for detecting mute/unmute
        audio.updateMuteWatcher()
    elseif e == 'dOut' then
        local d = hs.audiodevice.defaultOutputDevice()
        local n = hs.notify.new(nil,
            {
                title="Default audio output device changed",
                informativeText=d:name(),
            }
        )
        n:setIdImage(hs.image.imageFromName("NSMediaBrowserMediaTypeAudio"))
        n:send()
    end
end)

-- Sets up a watcher to detect when the default input device is muted
-- This should be called whenever the default input device changes
function audio.updateMuteWatcher()
    -- Stop any existing watcher
    if muteWatcherDevice then
        muteWatcherDevice:watcherCallback(nil)
        muteWatcherDevice:watcherStop()
    end
    muteWatcherDevice = hs.audiodevice.defaultInputDevice()
    muteWatcherDevice:watcherCallback(function(dev, event, scope, element)
        -- Note: multiple mute events may be sent, do doing something like a
        -- notification/alert is probably not a good idea here.
        if event == "mute" then
            audio.updateMuteStatus(muteWatcherDevice:muted())
        end
    end)
    muteWatcherDevice:watcherStart()
end

function audio.updateMuteStatus(muted)
    -- Shows or hides the mute indicator
    if muted and muteStatusCanvas then
        muteStatusCanvas:hide()
    end
    if not muted then
        if not muteStatusCanvas then
            local size = 100
            local textsize = 36
            muteStatusCanvas = hs.canvas.new{x=10, y=30,
                h=size*2, w=size*2}
            muteStatusCanvas:appendElements({
                action = "fill",
                fillColor = { alpha = 0.5, red = 1 },
                type = "circle",
                center = { x = size, y = size },
                radius = size
            },
            {
                action = "fill",
                textColor = { alpha = 0.5, white = 1 },
                type = "text",
                textAlignment = "center",
                textSize = textsize,
                frame = {
                    x = 0,
                    y = size - (textsize / 2),
                    h = textsize,
                    w = size * 2
                },
                text = "UNMUTED"
            })
        end
        muteStatusCanvas:show()
    end
end

-- Start the mute status watcher
audio.updateMuteWatcher()
-- Start the audio device change watcher
hs.audiodevice.watcher.start()

return audio
