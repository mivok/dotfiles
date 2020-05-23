-- Shortcut for binding the hyper key
function hyper_bind(key, callback)
    hs.hotkey.bind({'ctrl', 'alt', 'cmd', 'shift'}, key, callback)
end

-- Move the current window to the given values (unit rect values - between 0
-- and 1) Set values to nil to leave them unchanged, set bottom_right to true
-- to move the bottom right corner of the window rather than top left (so you
-- can specify 1 as x or y to move the window to the bottom or right of the
-- screen). The bottom_right parameter is optional.
function move_window(x, y, w, h, bottom_right)
    window = hs.window.focusedWindow()
    location = window:frame():toUnitRect(window:screen():frame())
    location.x = x or location.x
    location.y = y or location.y
    location.w = w or location.w
    location.h = h or location.h
    -- Allow the x and y location to be relative to the bottom right of the
    -- window
    if bottom_right and x then
        location.x = location.x - location.w
    end
    if bottom_right and y then
        location.y = location.y - location.h
    end
    window:moveToUnit(location)
end

-- Make window fill the width of the screen (for vertical monitor)
hyper_bind("1", function()
    move_window(0, nil, 1, nil)
end)

hyper_bind("up", function()
    move_window(nil, 0, nil, nil)
end)

hyper_bind("left", function()
    move_window(0, nil, nil, nil)
end)

hyper_bind("down", function()
    move_window(nil, 1, nil, nil, true)
end)

hyper_bind("right", function()
    move_window(1, nil, nil, nil, true)
end)
