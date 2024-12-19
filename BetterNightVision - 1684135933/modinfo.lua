name = "BetterNightVision V25"
description = [[Removes Moggles Black/Red effect and add nightvision with the selected Hotkey	(Default = X)
The nightvision DOESN'T protect you from charlie (Unless you play in a world without caves(and you are host))

Thanks to Fuzzy Waffle and Tony
The snippets of code they've contributed to are shown in the mod's 'modmain.lua' file]]

author = "Rockou_ With Help From the Community"
version = "25"
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

---@param title string
---@return table
local function Title(title)
    return {
        name=title,
        hover = "",
        options={{description = "", data = 0}},
        default = 0,
    }
end

configuration_options = {
    Title("Main settings"),
    {
        label = "Night vision toggle Key",
        hover = "The key that will toggle night vision",
        name = "NIGHTVISION_TOGGLE_KEY",
        options = keylist,
        default = "KEY_X",
    },
    {
        label = "Notify",
        hover = "Make the character say the night vision status (Only when changed)",
        name = "NIGHTVISION_NOTIFY_ENABLE",
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
        label = "Darkness Alert",
        hover = "Shows an indicator when in darkness and the night vision is active",
        name = "NIGHTVISION_ALERT_ENABLE",
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
        label = "Allow actions in darkness",
        hover = "Allows you to perform actions as if you really had moggles on, some things will be blocked server side",
        name = "NIGHTVISION_DARKNESS_ACTION_ENABLE",
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

    Title("Game behavior edits"),

    {
        label = "Delete Moggle color cubes",
        hover = "Completely disables the moggle color cubes, can avoid some weird interactions",
        name = "NIGHTVISION_MOGGLE_DELETE_ENABLED",
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
        default = false
    },

    {
        label = "Night Vision Strength",
        hover = "How bright should the night vision be",
        name = "NIGHTVISION_STRENGTH",
        options = {
            {
                description = "Disabled",
                data = false
            },
            {
                description = "0%",
                data = 0.0
            },
            {
                description = "10%",
                data = 0.1
            },
            {
                description = "20%",
                data = 0.2
            },
            {
                description = "25%",
                data = 0.25
            },
            {
                description = "30%",
                data = 0.3
            },
            {
                description = "40%",
                data = 0.4
            },
            {
                description = "50%",
                data = 0.5
            },
            {
                description = "60%",
                data = 0.6
            },
            {
                description = "70%",
                data = 0.7
            },
            {
                description = "75%",
                data = 0.75
            },
            {
                description = "80%",
                data = 0.8
            },
            {
                description = "90%",
                data = 0.9
            },
            {
                description = "100%",
                data = 1
            }
        },
        default = false,
    },
}
