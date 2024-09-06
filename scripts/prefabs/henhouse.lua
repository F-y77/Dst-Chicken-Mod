-- henhouse.lua

require "prefabutil"
require "recipe"
require "modutil"

local assets = {
    Asset("ANIM", "anim/henhouse.zip"),
    Asset("ATLAS", "images/inventoryimages/henhouse.xml"),
    Asset("IMAGE", "images/inventoryimages/henhouse.tex"),
}

local prefabs = {
    "chicken"  -- 假设存在一个 chicken prefab
}

----------------------------------

local function SpawnChickens(inst)
    if not inst:HasTag("burnt") then
        local num_chickens = math.random(1, 3)  -- 随机生成1到3只
        for i = 1, num_chickens do
            local chicken = SpawnPrefab("chicken")
            local x, y, z = inst.Transform:GetWorldPosition()
            chicken.Transform:SetPosition(x + math.random() * 2 - 1, y, z + math.random() * 2 - 1)
        end
    end
end

local function OnDayComplete(inst)
    inst:DoTaskInTime(5, SpawnChickens)  -- 在新的一天开始时2秒钟后生成小鸡
end

----------------------------------

local function onhammered(inst, worker)
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("wood")
    inst:Remove()
end

local function onhit(inst, worker)
    inst.AnimState:PlayAnimation("hit")
    inst.AnimState:PushAnimation("idle", false)
end

----------------------------------

local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, 0.6)

    inst:AddTag("structure")

    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon("henhouse.tex")

    inst.AnimState:SetBank("henhouse")
    inst.AnimState:SetBuild("henhouse")
    inst.AnimState:PlayAnimation("idle")

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("lootdropper")
    inst:AddComponent("inspectable")
    inst:AddComponent("workable")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)

    inst:WatchWorldState("startday", OnDayComplete)

    return inst
end

return Prefab("common/henhouse", fn, assets, prefabs),
       MakePlacer("common/henhouse_placer", "henhouse", "henhouse", "idle")
