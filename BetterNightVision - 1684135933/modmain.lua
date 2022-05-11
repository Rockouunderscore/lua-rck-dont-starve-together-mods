
local function GetKeyFromConfig(config)
    local key = GetModConfigData(config)
    return key and (type(key) == "number" and key or GLOBAL[key])
end

-- day05_cc is fall day
-- dusk03_cc is fall night
-- night03_cc is fall night
-- purple_moon_cc is fullmoon
-- ruins_light_cc is danger time in ruins

local togglecc = {
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

GLOBAL.TheInput:AddKeyUpHandler(GetKeyFromConfig("nvk"), function ()
    if not InGame() then return end --Thanks to Tony - Can be found in the mod's comments
        if GLOBAL.ThePlayer == nil then return else --Thanks to Fuzzy Waffle - Can be found in the mod's Discusions "Bugs / Crashs"
            GLOBAL.ThePlayer.components.playervision:ForceNightVision(not GLOBAL.ThePlayer.components.playervision:HasNightVision())
            GLOBAL.ThePlayer.components.talker:Say("Night Vision: "..tostring(GLOBAL.ThePlayer.components.playervision:HasNightVision()))
        end
end
)