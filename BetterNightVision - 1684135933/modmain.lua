
--#region Config

local function GetKeyFromConfig(config)
    local key = GetModConfigData(config)
    return key and (type(key) == "number" and key or GLOBAL[key])
end

---@type number
local NIGHTVISION_TOGGLE_KEY = GetKeyFromConfig("NIGHTVISION_TOGGLE_KEY")

---@type boolean
local NIGHTVISION_NOTIFY_ENABLE = GetModConfigData("NIGHTVISION_NOTIFY_ENABLE")

---@type boolean
local NIGHTVISION_ALERT_ENABLE = GetModConfigData("NIGHTVISION_ALERT_ENABLE")

---@type boolean
local NIGHTVISION_DARKNESS_ACTION_ENABLE = GetModConfigData("NIGHTVISION_DARKNESS_ACTION_ENABLE")


---@type boolean
local NIGHTVISION_MOGGLE_DELETE_ENABLED = GetModConfigData("NIGHTVISION_MOGGLE_DELETE_ENABLED")

---@type number|false
local NIGHTVISION_STRENGTH = GetModConfigData("NIGHTVISION_STRENGTH")

--#endregion

---@type boolean
local nightvision_active = false


---@return boolean
local function InGame()
    --[[
        Part of this was recommended by "Tony",
        More can be found in the steam workshop mod's comments
        This is used to fix a crash
            when using the night vision toggle key outside of the game

        Thanks
    ]]

    if GLOBAL.ThePlayer then
        return true
    end

    if GLOBAL.ThePlayer.HUD then
        return true
    end

    if GLOBAL.ThePlayer.HUD:HasInputFocus() then
        return false
    end

    local screen = GLOBAL.TheFrontEnd:GetActiveScreen() and GLOBAL.TheFrontEnd:GetActiveScreen().name or ""
    if screen:find("HUD") == nil then
        return false
    end

    return false

end
-- end of thanks

local nightvision_phasefn = {
    blendtime = 0,
    events = {},
    fn = nil,
}

-- do the vision thing
local function ToggleNightVision()

    nightvision_active = not nightvision_active

    if  GLOBAL.ThePlayer == nil or
        GLOBAL.ThePlayer.components == nil or
        GLOBAL.ThePlayer.components.playervision == nil
    then return end

    --#region enable actions

    if NIGHTVISION_DARKNESS_ACTION_ENABLE then
        -- GLOBAL.ThePlayer.components.playervision.nightvision = nightvision_active
        GLOBAL.ThePlayer.components.playervision.forcenightvision = nightvision_active
    end

    --#endregion

    --#region basic nightvision

    -- must be before ambientlighting override
    -- because ambientlighting listens to nightvision events to set the visual ambientlighting
    GLOBAL.ThePlayer:PushEvent("nightvision", nightvision_active)

    --#endregion

    --#region remove moggles vision

    local old_forcenightvision = GLOBAL.ThePlayer.components.playervision.forcenightvision
    local old_nightvision = GLOBAL.ThePlayer.components.playervision.nightvision

    GLOBAL.ThePlayer.components.playervision.forcenightvision = false
    GLOBAL.ThePlayer.components.playervision.nightvision = false

    GLOBAL.ThePlayer.components.playervision:UpdateCCTable()
    GLOBAL.ThePlayer:PushEvent("ccphasefn", nightvision_phasefn)

    GLOBAL.ThePlayer.components.playervision.forcenightvision = old_forcenightvision
    GLOBAL.ThePlayer.components.playervision.nightvision = old_nightvision

    --#endregion

    --#region night vision brightness

    if NIGHTVISION_STRENGTH ~= false then
        local overrideVisualColor = Point(NIGHTVISION_STRENGTH, NIGHTVISION_STRENGTH, NIGHTVISION_STRENGTH)
        GLOBAL.TheWorld:PushEvent("overridevisualambientlighting", nightvision_active and overrideVisualColor or nil)

        -- breaks lightwatcher and darkness alert
        -- GLOBAL.TheWorld:PushEvent("overrideambientlighting", nightvision_active and overrideVisualColor or nil)
    end

    --#endregion

    --#region enable nightvision if moggles are equiped

    if not nightvision_active and GLOBAL.ThePlayer.components.playervision.nightvision then
        -- GLOBAL.ThePlayer.components.talker:Say(
        --     "nightvision: "..tostring(GLOBAL.ThePlayer.components.playervision.nightvision).."\n"..
        --     "forcenightvision: "..tostring(GLOBAL.ThePlayer.components.playervision.forcenightvision))

        -- must be after ambientlighting override
        -- because ambientlighting listens to nightvision events to set the visual ambientlighting
        GLOBAL.ThePlayer:PushEvent("nightvision", GLOBAL.ThePlayer.components.playervision.nightvision)

        GLOBAL.ThePlayer.components.playervision:UpdateCCTable()
        GLOBAL.ThePlayer:PushEvent("ccphasefn", nightvision_phasefn)
    end

    --#endregion

    --#region tell nightvision status

    if NIGHTVISION_NOTIFY_ENABLE then
        GLOBAL.ThePlayer.components.talker:Say("Night Vision: "..tostring(nightvision_active))
    end
    
    -- GLOBAL.ThePlayer.components.talker:Say(
    --     "ToggleNightVision\n"..
    --     "nightvision: "..tostring(GLOBAL.ThePlayer.components.playervision.nightvision).."\n"..
    --     "forcenightvision: "..tostring(GLOBAL.ThePlayer.components.playervision.forcenightvision))

    --#endregion

end

-- detect when the toggle key is pressed
GLOBAL.TheInput:AddKeyUpHandler(NIGHTVISION_TOGGLE_KEY, function ()
    if not InGame() then return end
    ToggleNightVision()
end)

--#region Darkness Alert

if NIGHTVISION_ALERT_ENABLE then

    -- spawn a single darkness alert on an entity
    local function SpawnDarknessAlert(parent)
        if not parent then
            return
        end
        local inst = GLOBAL.CreateEntity()

        --[[Non-networked entity]]
        inst.entity:SetCanSleep(false)
        inst.persists = false

        inst.entity:AddTransform()
        inst.entity:AddAnimState()

        inst:AddTag("CLASSIFIED")
        inst:AddTag("NOCLICK")
        inst:AddTag("placer")

        inst.AnimState:SetBank("winona_battery_placement")
        inst.AnimState:SetBuild("winona_battery_placement")
        inst.AnimState:PlayAnimation("idle")
        inst.AnimState:SetLightOverride(1)
        inst.AnimState:SetOrientation(GLOBAL.ANIM_ORIENTATION.OnGround)
        inst.AnimState:SetLayer(GLOBAL.LAYER_BACKGROUND)
        inst.AnimState:SetSortOrder(1)
        inst.AnimState:SetScale(0, 0)
        inst.AnimState:SetAddColour(1,0,0,0)
        inst.entity:SetParent(parent.entity)
        
        local invert_scale = 16 -- lower is larger
        local iterations = 8
        for i=0,iterations do
            inst:DoTaskInTime(GLOBAL.FRAMES*i, function(inst)
                inst.AnimState:SetScale(i/invert_scale, i/invert_scale)
            end)
            inst:DoTaskInTime(GLOBAL.FRAMES*(i+iterations+1), function(inst)
                inst.AnimState:SetScale(1-i/invert_scale, 1-i/invert_scale)
            end)
        end

        inst:DoTaskInTime(0.5, function(inst)
            inst:Remove()
        end)

    end

    local function TrySpawnDarknessAlert(inst)

        if not inst.LightWatcher then return end

        -- GLOBAL.ThePlayer.components.talker:Say("LightValue: ".. inst.LightWatcher:GetLightValue())

        if inst.LightWatcher:GetLightValue() < 0.1 and nightvision_active then
            SpawnDarknessAlert(inst)
        end

    end

    -- spawn alert periodically
    AddPlayerPostInit(function(inst)
        inst:DoTaskInTime(0.25, function() -- wait for things to get setup, idk doesnt work without

            if inst ~= GLOBAL.ThePlayer then return end

            inst:DoPeriodicTask(0.5, TrySpawnDarknessAlert)

        end)
    end)

end

--#endregion

local UpvalueHacker = GLOBAL.require("tools/upvaluehacker")
local tablecopy = GLOBAL.require("tools/tablecopy")

if NIGHTVISION_MOGGLE_DELETE_ENABLED then

    -- AddClassPostConstruct("components/playervision", function (self)
    --     UpvalueHacker.SetUpvalue(self.UpdateCCTable, nil, "NIGHTVISION_COLOURCUBES")
    -- end)
    AddComponentPostInit("playervision", function (self)

        local oldUpdateCCTable = self.UpdateCCTable
        local newUpdateCCTable = function (self, override)
            -- override should be true by default


            local old_forcenightvision = self.forcenightvision
            local old_nightvision = self.nightvision

            self.forcenightvision = false
            self.nightvision = false

            oldUpdateCCTable(self)

            self.forcenightvision = old_forcenightvision
            self.nightvision = old_nightvision
    
            -- GLOBAL.ThePlayer.components.talker:Say(
            --     "UpdateCCTable\n"..
            --     "nightvision: "..tostring(self.nightvision).."\n"..
            --     "forcenightvision: "..tostring(self.forcenightvision))

        end
        self.UpdateCCTable = newUpdateCCTable

    end)

end

local function GetColorsFromRGB(rgb)
    return {
        PHASE_COLOURS =
        {
            default =
            {
                day = { colour = rgb, time = 0 },
                dusk = { colour = rgb, time = 0 },
                night = { colour = rgb, time = 0 },
            },
        },
    
        FULL_MOON_COLOUR = { colour = rgb, time = 0 },
        CAVE_COLOUR = { colour = rgb, time = 0 },
    }
end

if NIGHTVISION_STRENGTH ~= false then

    AddClassPostConstruct("components/ambientlighting", function(self)
        -- print("ROCKOU_ AddClassPostConstruct(\"components/ambientlighting\", function(self)")

        local realcolor = UpvalueHacker.GetUpvalue(self.OnUpdate, "_realcolour")

        local overridecolor = UpvalueHacker.GetUpvalue(self.OnUpdate, "_overridecolour")

        local computeTargetColor = UpvalueHacker.GetUpvalue(self.OnUpdate, "DoUpdateFlash", "ComputeTargetColour")
        local pushCurrentColour = UpvalueHacker.GetUpvalue(self.OnUpdate, "PushCurrentColour")
        local normalColors = tablecopy(overridecolor.currentcolourset)

        -- print("ROCKOU_", realcolor, overridecolor, computeTargetColor, pushCurrentColour, normalColors)

        local OverrideVisualAmbiantLighting = function(inst, newVisualColor)
            -- print("ROCKOU_ function(newVisualColor)", inst, newVisualColor)
            overridecolor.currentcolourset = newVisualColor ~= nil and GetColorsFromRGB(newVisualColor) or normalColors

            computeTargetColor(overridecolor, 0)

            pushCurrentColour()
        end
        GLOBAL.TheWorld:ListenForEvent("overridevisualambientlighting", OverrideVisualAmbiantLighting)

    end)

end
