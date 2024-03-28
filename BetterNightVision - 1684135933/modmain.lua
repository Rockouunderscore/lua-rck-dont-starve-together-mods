
local function GetKeyFromConfig(config)
    local key = GetModConfigData(config)
    return key and (type(key) == "number" and key or GLOBAL[key])
end

-- day05_cc is fall day
-- dusk03_cc is fall night
-- night03_cc is fall night
-- purple_moon_cc is fullmoon
-- ruins_light_cc is danger time in ruins

local NEW_NIGHTVISION_COLOURCUBES =
{
    day = "images/colour_cubes/day05_cc.tex",
    dusk = "images/colour_cubes/day05_cc.tex",
    night = "images/colour_cubes/day05_cc.tex",
    full_moon = "images/colour_cubes/day05_cc.tex",
}

--Thanks to Tony - Can be found in the mod's comments
local function InGame()
    return GLOBAL.ThePlayer and GLOBAL.ThePlayer.HUD and not GLOBAL.ThePlayer.HUD:HasInputFocus()
end
-- end of block

local function ToggleNightVision()

    local playervision = GLOBAL.ThePlayer.components.playervision

    local newNightVisionActive = not playervision:HasNightVision()

    playervision:ForceNightVision(newNightVisionActive)

    -- if
    -- active   => NIGHTVISION_COLOURCUBES
    -- else     => nil
    playervision:SetCustomCCTable(newNightVisionActive and NEW_NIGHTVISION_COLOURCUBES or nil)

    GLOBAL.ThePlayer.components.talker:Say("Night Vision: "..tostring(newNightVisionActive))

end

GLOBAL.TheInput:AddKeyUpHandler(GetKeyFromConfig("nvk"), function ()
    if not InGame() then return end --Thanks to Tony - Can be found in the mod's comments
        if GLOBAL.ThePlayer == nil then return else --Thanks to Fuzzy Waffle - Can be found in the mod's Discusions "Bugs / Crashs"
            ToggleNightVision()
        end
end
)