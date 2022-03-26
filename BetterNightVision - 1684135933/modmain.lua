local function GetKeyFromConfig(config)
    local key = GetModConfigData(config)
    return key and (type(key) == "number" and key or GLOBAL[key])
end

local function InGame() --Thanks to Tony - Can be found in the mod's comments
    return GLOBAL.ThePlayer and GLOBAL.ThePlayer.HUD and not GLOBAL.ThePlayer.HUD:HasInputFocus() --Thanks to Tony - Can be found in the mod's comments
end --Thanks to Tony - Can be found in the mod's comments


GLOBAL.TheInput:AddKeyUpHandler(GetKeyFromConfig("nvk"), function ()
    if not InGame() then return end --Thanks to Tony - Can be found in the mod's comments
        if GLOBAL.ThePlayer == nil then return else --Thanks to Fuzzy Waffle - Can be found in the mod's Discusions "Bugs / Crashs"
            nvt = not nvt
                GLOBAL.ThePlayer.components.talker:Say("Night Vision: "..tostring(nvt))
                GLOBAL.ThePlayer.components.playervision:ForceNightVision(nvt)
        end
end
)
