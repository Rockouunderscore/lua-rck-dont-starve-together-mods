
local function GetKeyFromConfig(config)
    local key = GetModConfigData(config)
    return key and (type(key) == "number" and key or GLOBAL[key])
end

local NIGHTVISION_TOGGLE_KEY = GetKeyFromConfig("NIGHTVISION_TOGGLE_KEY")
---@type boolean
local NIGHTVISION_OVERRIDE_COLOR_CUBES = GetModConfigData("NIGHTVISION_OVERRIDE_COLOR_CUBES")

---@type string
local NIGHTVISION_USE_COLORCUBES = GetModConfigData("NIGHTVISION_USE_COLORCUBES")

---@type table<string, string>
local OVERRIDE_COLOR_CUBES = {
    day = NIGHTVISION_USE_COLORCUBES,
    dusk = NIGHTVISION_USE_COLORCUBES,
    night = NIGHTVISION_USE_COLORCUBES,
    full_moon = NIGHTVISION_USE_COLORCUBES
}

-- Thanks to Tony - Can be found in the mod's comments
local function InGame()
    return GLOBAL.ThePlayer and GLOBAL.ThePlayer.HUD and not GLOBAL.ThePlayer.HUD:HasInputFocus()
end
-- end of block

local function ToggleNightVision()

    local nightvision_active = not GLOBAL.ThePlayer.components.playervision:HasNightVision()

    -- apply night vision

    GLOBAL.ThePlayer.components.playervision:ForceNightVision(nightvision_active)

    -- GLOBAL.ThePlayer:PushEvent("nightvision", nightvision_active)

    -- apply color cubes

    if NIGHTVISION_OVERRIDE_COLOR_CUBES then

        local active_colour_cubes = nightvision_active and NIGHTVISION_USE_COLORCUBES ~= "" and OVERRIDE_COLOR_CUBES or nil

        -- GLOBAL.ThePlayer.components.playervision:SetCustomCCTable(active_colour_cubes)

        GLOBAL.ThePlayer:PushEvent("ccoverrides", active_colour_cubes)
        GLOBAL.ThePlayer:PushEvent("ccphasefn", nil)
    end

    -- notify through talker

    GLOBAL.ThePlayer.components.talker:Say("Night Vision: "..tostring(nightvision_active))

end


GLOBAL.TheInput:AddKeyUpHandler(NIGHTVISION_TOGGLE_KEY, function ()
    if not InGame() then return end --Thanks to Tony - Can be found in the mod's comments
    if GLOBAL.ThePlayer == nil then return else --Thanks to Fuzzy Waffle - Can be found in the mod's Discusions "Bugs / Crashs"
        ToggleNightVision()
    end
end
)