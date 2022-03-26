name = "  MogglesVisionToggle"
description = [[Toggles Moggles Vision with the selected Hotkey	(Default = X)
The nightvision DOESN'T protect you from charlie (Unless you play in a world without caves(and you are host))

From Fuzzy Waffle-
Line 13> 	modmain.lua if _G.ThePlayer == nil then return else
               
From Tony
Line 6 >	local function InGame()
Line7>		return GLOBAL.ThePlayer and GLOBAL.ThePlayer.HUD and not GLOBAL.ThePlayer.HUD:HasInputFocus()
Line8>		end
Line12>		if not InGame() then return end]]

author = "Rockou_ With Help From the Community"
version = "MVT 1.1.0"
api_version_dst = 10

dst_compatible = true
all_clients_require_mod = false
client_only_mod = true

local string = ""
local keys = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","F1","F2","F3","F4","F5","F6","F7","F8","F9","F10","F11","F12","LAlt","RAlt","LCtrl","RCtrl","LShift","RShift","Tab","Capslock","Space","Minus","Equals","Backspace","Insert","Home","Delete","End","Pageup","Pagedown","Print","Scrollock","Pause","Period","Slash","Semicolon","Leftbracket","Rightbracket","Backslash","Up","Down","Left","Right"}
local keylist = {}
for i = 1, #keys do
    keylist[i] = {description = keys[i], data = "KEY_"..string.upper(keys[i])}
end
keylist[#keylist + 1] = {description = "Disabled", data = false}

local function AddConfig(label, name, options, default, hover)
    return {name = name, label = label, hover = hover or "", options = options, default = default}
end

configuration_options = 
{
    AddConfig("Night vision Toggle Key", "nv", keylist, "KEY_X")
}
