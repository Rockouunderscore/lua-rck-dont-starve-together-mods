require "prefabutil"

local assets = {
    Asset("ANIM", "anim/path_light.zip"),
}

local function onhammered(inst, worker)
    SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
    inst:Remove()
    inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
end

local function fuelupdate(inst)
    inst.components.fueled:GetPercent()
end

local function fuelit_update(inst)
    if TheWorld.state.isday
    then 
        inst.Light:Enable(false)
        inst.AnimState:PlayAnimation("idle_off")
        inst.components.fueled:StopConsuming()
        return
    end
    
    local colourSettings = {
        blue  = {{0, 0, 1}, "idle_on_blue"},
        red   = {{1, 0, 0}, "idle_on_red"},
        green = {{0, 1, 0}, "idle_on"},
        white = {{1, 1, 1}, "idle_on"},
    }
    if not inst.components.fueled:IsEmpty() then
        inst.components.fueled:StartConsuming()
        inst.Light:Enable(true)
        inst.Light:SetRadius(lightRadius)
        inst.Light:SetFalloff(.8)
        inst.Light:SetIntensity(.5)
        inst.Light:SetColour(
            colourSettings[lightColour][1][1],
            colourSettings[lightColour][1][2],
            colourSettings[lightColour][1][3]
        )
        inst.AnimState:PlayAnimation(
            colourSettings[lightColour][2]
        )
        fuelupdate(inst)
    end
end

local function takefuel(inst)
    fuelit_update(inst)
end

local function nofuel(inst)
    if inst.components.fueled:IsEmpty() then
    inst.Light:Enable(false)
    inst.AnimState:PlayAnimation("idle_off")
    end
end

local function onbuilt(inst)
    inst.components.fueled:InitializeFuelLevel(TUNING.LARGE_FUEL)
end

local function fn()
    local inst = CreateEntity()
    
    inst:AddTag("structure")

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    inst.entity:AddLight()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("path_light")
    inst.AnimState:SetBuild("path_light")
    inst.AnimState:PlayAnimation("idle_off")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()

    inst:AddComponent("fueled")
    inst.components.fueled:SetSections(4)
    inst.components.fueled.maxfuel = TUNING.FIREPIT_FUEL_MAX
    inst.components.fueled.fueltype = FUELTYPE.BURNABLE
    inst.components.fueled:SetDepletedFn(nofuel)
    inst.components.fueled:SetUpdateFn(fuelit_update)
    inst.components.fueled.ontakefuelfn = takefuel
    inst.components.fueled.accepting = true

    if FueledtLight then inst.components.fueled.rate = .5
        else
        inst.components.fueled.rate = 0
    end

    inst:DoPeriodicTask(2, function() fuelit_update(inst) end)

    fuelit_update(inst)

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(2)
    inst.components.workable:SetOnFinishCallback(onhammered)

    inst:AddComponent("inspectable")

    inst:ListenForEvent("onbuilt", onbuilt)

    return inst
end

return Prefab("common/objects/path_light", fn, assets),
    MakePlacer( "common/path_light_placer", "path_light", "path_light", "idle_off" )