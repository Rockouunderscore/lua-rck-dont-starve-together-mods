
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

---@type boolean
local NIGHTVISION_ALERT_ENABLE = GetModConfigData("NIGHTVISION_ALERT_ENABLE")

---@type number
local NIGHTVISION_ALERT_FREQUENCY = 0.5


---@type boolean
local nightvision_active = false

-- Thanks to Tony - Can be found in the mod's comments
---@return boolean
local function InGame()

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

-- do the vision thing
local function ToggleNightVision()

    nightvision_active = not nightvision_active

    if NIGHTVISION_ALERT_ENABLE then
        GLOBAL.ThePlayer:PushEvent("nightvision", nightvision_active)
        GLOBAL.ThePlayer:PushEvent("ccoverrides", nil)
        GLOBAL.ThePlayer:PushEvent("ccphasefn", nil)
    else
        local nv_strength = Point(NIGHTVISION_STRENGTH, NIGHTVISION_STRENGTH, NIGHTVISION_STRENGTH)
        GLOBAL.TheWorld:PushEvent("overrideambientlighting", nightvision_active and nv_strength or nil)
    end

    if NIGHTVISION_NOTIFY_ENABLE then
        GLOBAL.ThePlayer.components.talker:Say("Night Vision: "..tostring(nightvision_active))
    end

end

-- detect when the toggle key is pressed
GLOBAL.TheInput:AddKeyUpHandler(NIGHTVISION_TOGGLE_KEY, function ()
    if not InGame() then return end --Thanks to Tony - Can be found in the mod's comments
    ToggleNightVision()
end)

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
    
    for i=0,8 do
        inst:DoTaskInTime(GLOBAL.FRAMES*i, function(inst)
            inst.AnimState:SetScale(i/8, i/8)
        end)
        inst:DoTaskInTime(GLOBAL.FRAMES*(i+9), function(inst)
            inst.AnimState:SetScale(1-i/8, 1-i/8)
        end)
    end

    inst:DoTaskInTime(0.5, function(inst)
        inst:Remove()
    end)

end

-- spawn alert periodically
AddPlayerPostInit(function(inst)
    inst:DoTaskInTime(0.25, function()
        if inst == GLOBAL.ThePlayer and inst.LightWatcher ~= nil and NIGHTVISION_ALERT_ENABLE then
            inst:DoPeriodicTask(0.5, function(inst)
                if inst.LightWatcher and not inst.LightWatcher:IsInLight() and nightvision_active then
                    SpawnDarknessAlert(inst)
                end
            end)
        end
    end)
end)

