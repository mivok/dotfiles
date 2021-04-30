---- Hotkeys ----

-- Pause key for music
function hotkey_pause_music()
    -- We can use media keys for spotify and chrome now, and it does the right
    -- thing
    hs.eventtap.event.newSystemKeyEvent("PLAY", true):post();
    hs.eventtap.event.newSystemKeyEvent("PLAY", false):post();
end

-- Lock screen
function hotkey_sleep_screen()
    hs.alert.show("Sleep screen")
    hs.task.new("/usr/bin/pmset", nil, {"displaysleepnow"}):start()
end

function hotkey_reset_mic_volume()
    level = 80
    ad = hs.audiodevice.defaultInputDevice()
    if ad ~= nil then
        oldvol = math.floor(ad:inputVolume())
        ad:setInputVolume(level)
        hs.alert.show("Input volume reset from " .. oldvol .. "% to " .. level .. "%")
    else
        hs.alert.show("No input device found")
    end
end

-- Away/back
function hotkey_away()
    hs.alert.show("Away")
    hs.task.new(os.getenv("HOME") .. "/bin/awayback.sh", nil, {"away"}):start()
end

function hotkey_back()
    hs.alert.show("Back")
    hs.task.new(os.getenv("HOME") .. "/bin/awayback.sh", nil, {"back"}):start()
end

-- White noise controls
function hotkey_noise_toggle()
    hs.alert.show("Noise play/pause")
    hs.task.new("/usr/local/bin/mpc", nil,
        {"-h", "officenoise.local", "toggle"}):start()
end

function hotkey_noise_voldown()
    hs.alert.show("Noise volume down")
    hs.task.new("/usr/local/bin/mpc", nil,
        {"-h", "officenoise.local", "volume", "-2"}):start()
end

function hotkey_noise_volup()
    hs.alert.show("Noise volume up")
    hs.task.new("/usr/local/bin/mpc", nil,
        {"-h", "officenoise.local", "volume", "+2"}):start()
end

function switch_default_audio_devices(output, input)
    outdev = hs.audiodevice.findOutputByName(output)
    indev = hs.audiodevice.findInputByName(input)
    if outdev == nil then
        hs.alert.show("Unable to find output device: " .. output)
        return
    end
    if indev == nil then
        hs.alert.show("Unable to find input device: " .. input)
        return
    end
    outdev:setDefaultOutputDevice()
    outdev:setDefaultEffectDevice()
    indev:setDefaultInputDevice()
    hs.alert.show("Audio devices switched to " .. output .. ", ".. input)
end

function hotkey_audio_headset()
    switch_default_audio_devices(
        "CalDigit Thunderbolt 3 Audio",
        "Antlion USB Microphone"
    )
end

function hotkey_audio_speaker()
    -- Switch audio to speakers
    switch_default_audio_devices(
        "CalDigit Thunderbolt 3 Audio",
        "MacBook Pro Microphone"
    )
end

-- Normal hotkeys
hs.hotkey.bind({"cmd", "alt"}, "L", hotkey_sleep_screen)

-- Launchpad hotkeys (Keys are mapped from F13-F20)
-- hs.hotkey.bind({}, "F13", ...) -- F13 is used for shush
hs.hotkey.bind({}, "F14", hotkey_reset_mic_volume)
hs.hotkey.bind({}, "F15", hotkey_pause_music)
--hs.hotkey.bind({}, "F16", hotkey_noise_toggle)
hs.hotkey.bind({}, "F17", hotkey_away)
hs.hotkey.bind({}, "F18", hotkey_back)
hs.hotkey.bind({}, "F19", hotkey_audio_headset)
hs.hotkey.bind({}, "F20", hotkey_audio_speaker)

-- Hyper key (caps lock) bindings
function hyper_bind(key, callback)
    hs.hotkey.bind({'ctrl', 'alt', 'cmd', 'shift'}, key, callback)
end

hyper_bind("A", hotkey_away)
hyper_bind("B", hotkey_back)
hyper_bind("L", hotkey_sleep_screen)
hyper_bind("N", hotkey_noise_toggle)
hyper_bind("Up", hotkey_noise_volup)
hyper_bind("Down", hotkey_noise_voldown)
hyper_bind("P", hotkey_pause_music)
hyper_bind("H", hotkey_audio_headset)
hyper_bind("S", hotkey_audio_speaker)
