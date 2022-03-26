local function GetKeyFromConfig(config)
	local key = GetModConfigData(config)
	return key and (type(key) == "number" and key or GLOBAL[key])
end

--Thanks to Tony			Can be found in the mod's comments
local function InGame()
	return GLOBAL.ThePlayer and GLOBAL.ThePlayer.HUD and not GLOBAL.ThePlayer.HUD:HasInputFocus()
end


GLOBAL.TheInput:AddKeyUpHandler(GetKeyFromConfig("nv"), function ()
	if not InGame() then return end																	--Thanks to Tony			Can be found in the mod's comments
		if GLOBAL.ThePlayer == nil then return else													--Thanks to Fuzzy Waffle	Can be found in the mod's Discusions "Bugs / Crashs"
			nvk = not nvk
				GLOBAL.ThePlayer.components.playervision:ForceNightVision(nvk)
				GLOBAL.ThePlayer.components.talker:Say("Night Vision: "..tostring(nvk))
		end
end
)

	
	
