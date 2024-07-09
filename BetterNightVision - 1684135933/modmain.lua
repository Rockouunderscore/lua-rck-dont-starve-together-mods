
local function GetKeyFromConfig(config)
    local key = GetModConfigData(config)
    return key and (type(key) == "number" and key or GLOBAL[key])
end

---@type number
local NIGHTVISION_TOGGLE_KEY = GetKeyFromConfig("NIGHTVISION_TOGGLE_KEY")

---@type boolean
local NIGHTVISION_NOTIFY_ENABLE = GetModConfigData("NIGHTVISION_NOTIFY_ENABLE")

---@type number
local NIGHTVISION_STRENGTH = GetModConfigData("NIGHTVISION_STRENGTH")

local nightvision_active = false

-- Thanks to Tony - Can be found in the mod's comments
local function InGame()
    return GLOBAL.ThePlayer and GLOBAL.ThePlayer.HUD and not GLOBAL.ThePlayer.HUD:HasInputFocus()
end
-- end of thanks

-- do the vision thing
local function ToggleNightVision()

    nightvision_active = not nightvision_active

    local nv_strength = Point(NIGHTVISION_STRENGTH, NIGHTVISION_STRENGTH, NIGHTVISION_STRENGTH)
    GLOBAL.TheWorld:PushEvent("overrideambientlighting", nightvision_active and nv_strength or nil)

    if NIGHTVISION_NOTIFY_ENABLE then
        GLOBAL.ThePlayer.components.talker:Say("Night Vision: "..tostring(nightvision_active))
    end

end

GLOBAL.TheInput:AddKeyUpHandler(NIGHTVISION_TOGGLE_KEY, function ()
    if not InGame() then return end --Thanks to Tony - Can be found in the mod's comments
    ToggleNightVision()
end
)
