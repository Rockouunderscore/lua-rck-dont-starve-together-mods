name = "BetterNightVision V18"
description = [[Removes Moggles Black/Red effect and add nightvision with the selected Hotkey	(Default = X)
The nightvision DOESN'T protect you from charlie (Unless you play in a world without caves(and you are host))

Thanks to Fuzzy Waffle and Tony
The snippets of code they've contributed to are shown in the mod's 'modmain.lua' file]]

author = "Rockou_ With Help From the Community"
version = "18"
api_version_dst = 10

dst_compatible = true
all_clients_require_mod = false
client_only_mod = true

local string = ""
local keys = {
    "A","B","C","D","E","F",
    "G","H","I","J","K","L",
    "M","N","O","P","Q","R",
    "S","T","U","V","W","X",
    "Y","Z",
    "F1","F2","F3","F4","F5",
    "F6","F7","F8","F9","F10",
    "F11","F12",
    "LAlt","RAlt",
    "LCtrl","RCtrl",
    "LShift","RShift",
    "Tab","Capslock","Space",
    "Minus","Equals","Backspace","Insert","Home","Delete","End","Pageup","Pagedown",
    "Print","Scrollock","Pause",
    "Period","Slash","Semicolon","Leftbracket","Rightbracket","Backslash",
    "Up","Down","Left","Right"
}
local keylist = {}
for i = 1, #keys do
    keylist[i] = {description = keys[i], data = "KEY_"..string.upper(keys[i])}
end
keylist[#keylist + 1] = {description = "Disabled", data = false}

configuration_options = {
    {
        label = "Night vision Toggle Key",
        hover = "The key that will toggle night vision",
        name = "NIGHTVISION_TOGGLE_KEY",
        options = keylist,
        default = "KEY_X",
    },
    {
        label = "Enable Color Cubes Override",
        hover = "Whether to override color cubes or not",
        name = "NIGHTVISION_OVERRIDE_COLOR_CUBES",
        options = {
            {
                description = "Enabled",
                data = true
            },
            {
                description = "Disabled",
                data = false
            }
        },
        default = true
    },
    {
        label = "Color Cubes Override Value",
        hover = "Color Cubes to use",
        name = "NIGHTVISION_USE_COLORCUBES",
        options = {
            { description = "Default",         data = "",                                                  hover = "Keep what would be the current filter, without moggle vision"},
            { description = "Identity",        data = "images/colour_cubes/identity_colourcube.tex",       hover = "Default \"Identity\" filter"},
            { description = "Autumn Day",      data = "images/colour_cubes/day05_cc.tex",                  hover = "Autumn Day Filter"},
            { description = "Winter Day",      data = "images/colour_cubes/snow_cc.tex",                   hover = "Winter Day Filter"},
            { description = "Winter Night",    data = "images/colour_cubes/night04_cc.tex",                hover = "Winter Night Filter"},
            { description = "Spring Day",      data = "images/colour_cubes/spring_day_cc.tex",             hover = "Spring Day Filter"},
            { description = "Spring Dusk",     data = "images/colour_cubes/spring_dusk_cc.tex",            hover = "Spring Dusk Filter"},
            { description = "Summer Day",      data = "images/colour_cubes/summer_day_cc.tex",             hover = "Summer Day Filter"},
            { description = "Summer Dusk",     data = "images/colour_cubes/summer_dusk_cc.tex",            hover = "Summer Dusk Filter"},
            { description = "Summer Night",    data = "images/colour_cubes/summer_night_cc.tex",           hover = "Summer Night Filter"},
            { description = "Caves",           data = "images/colour_cubes/caves_default.tex",             hover = "Caves Filter"},
            { description = "Ruins Calm",      data = "images/colour_cubes/ruins_dark_cc.tex",             hover = "DST: Ruins Calm Phase Filter"},
            { description = "Ruins Warning",   data = "images/colour_cubes/ruins_dim_cc.tex",              hover = "DST: Ruins Warning Phase Filter"},
            { description = "Ruins Wild",      data = "images/colour_cubes/ruins_light_cc.tex",            hover = "DST: Ruins Wild Phase Filter"},
            { description = "Were Form",       data = "images/colour_cubes/beaver_vision_cc.tex",          hover = "Woodie's Were Form Filter"},
            { description = "Fungus",          data = "images/colour_cubes/fungus_cc.tex",                 hover = "DST: Fungus Forest Filter"},
            { description = "Moon Storm",      data = "images/colour_cubes/moonstorm_cc.tex",              hover = "Moon Storm Filter"},
            { description = "Full Moon",       data = "images/colour_cubes/purple_moon_cc.tex",            hover = "Full Moon Filter"},
            { description = "Lunacy",          data = "images/colour_cubes/lunacy_regular_cc.tex",         hover = "DST: Lunacy Filter"},
            { description = "Ghost",           data = "images/colour_cubes/ghost_cc.tex",                  hover = "DST: Ghost Filter"}
            --[[
            {
                description = "CC Name",
                data = "CC Directory Path",
                hover = "CC Config Tip - Not Required"
            },
            ]]
        },
        default = ""
    }
    --,
    --{
    --    label = "CC table override Toggle Key",
    --    hover = "The key that will toggle color cube table override",
    --    name = "cck",
    --    options = keylist,
    --    default = "KEY_X",
    --}
}
