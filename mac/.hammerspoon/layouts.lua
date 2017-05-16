-- Window layouts
layouts = {}

-- Geometries
local bottom_height = 0.4
local top_height = 1.0 - bottom_height
-- Top right quadrant
layouts.topright = hs.geometry.rect(0.5, 0, 0.5, top_height)

-- Bottom of the screen split into 3
layouts.bottomright = hs.geometry.rect(0.66, top_height, 0.34, bottom_height)
layouts.bottommiddle = hs.geometry.rect(0.4, top_height, 0.26, bottom_height)
layouts.bottomleft = hs.geometry.rect(0, top_height, 0.4, bottom_height)

layout_main = {
    {"Google Chrome", nil, hs.screen('1,0'), layouts.topright, nil, nil},
    {"Tweetbot", nil, hs.screen('1,0'), layouts.bottomright, nil, nil},
    {"Slack", nil, hs.screen('1,0'), layouts.bottomleft, nil, nil},
    {"Messages", nil, hs.screen('1,0'), layouts.bottommiddle, nil, nil}
}

hs.hotkey.bind({"cmd", "alt"}, "W", function()
    hs.layout.apply(layout_main)
end)

return layouts
