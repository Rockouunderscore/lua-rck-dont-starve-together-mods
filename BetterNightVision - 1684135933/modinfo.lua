name = "BetterNightVision V16"
description = [[Removes Moggles Black/Red effect and add nightvision with the selected Hotkey	(Default = X)
The nightvision DOESN'T protect you from charlie (Unless you play in a world without caves(and you are host))

Thanks to Fuzzy Waffle and Tony
The snippets of code they've contributed to are shown in the mod's 'modmain.lua' file]]

author = "Rockou_ With Help From the Community"
version = "16"
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
        name = "nvk",
        options = keylist,
        default = "KEY_X",
    }--,
    --{
    --    label = "CC table override Toggle Key",
    --    hover = "The key that will toggle color cube table override",
    --    name = "cck",
    --    options = keylist,
    --    default = "KEY_X",
    --}
}
