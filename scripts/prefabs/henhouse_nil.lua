require "prefabutil"
require "recipe"
require "modutil"

local assets = {
    Asset("ANIM", "anim/henhouse.zip"), -- 确保有对应的动画与贴图文件
    Asset("ATLAS", "images/inventoryimages/henhouse.xml"),
}

SetSharedLootTable("henhouse",
{
    {"twigs",       1.00},
    {"twigs",       0.5},

    {"cutgrass",       0.25},
    {"cutgrass",       0.1},

    {"egg",       0.5},

    {"rope",       1.00},

    {"chicken_feather",       0.75},
    {"chicken_feather",       0.25},

})

local prefabs = {
    "chicken", -- 假设已经有这个鸡的 prefab
    "egg",
    "chicken_feather",
}

local function SpawnChicken(inst)-- 生成鸡孩子
    if inst.components.childspawner ~= nil then
        inst.components.childspawner.childname = "chicken"
        inst.components.childspawner:SpawnChild()
    end
end

local function onhammered(inst, worker) -- 处理锤击事件
    inst.components.lootdropper:DropLoot()
    inst:Remove()
end

local function onhit(inst, worker) -- 处理被击事件
    if not inst:HasTag("burnt") then
        inst.AnimState:PlayAnimation("hit")
        inst.AnimState:PushAnimation("idle")
    end
end

local function onbuilt(inst) -- 处理建造事件
    inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("idle", false)
end

--[[local function SpawnEgg(inst) -- 生成鸡蛋
    if inst.components.childspawner ~= nil then
        local egg = inst.components.childspawner:SpawnChild()
        if egg ~= nil then
            egg.Transform:SetPosition(inst.Transform:GetWorldPosition())
        end
    end
end

local function CollectEgg(inst) -- 收集鸡蛋
    if inst.components.container ~= nil then
        local egg = inst.components.container:RemoveItemByName("egg")
        if egg ~= nil then
            egg.Transform:SetPosition(inst.Transform:GetWorldPosition())
            egg:Remove()
        end
    end
end]]

--------------------------------

local function onopen(inst) 
    inst.AnimState:PlayAnimation("hit") 
    inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
end 

local function onclose(inst) 
    inst.AnimState:PlayAnimation("idle") 
    inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")        
end 

----------------------------------

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("henhouse")
    inst.AnimState:SetBuild("henhouse")
    inst.AnimState:PlayAnimation("idle") --播放默认动画

    inst:AddTag("structure")
    inst:AddTag("chest")
    inst:AddTag("animal")

    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon( "henhouse.tex" )

    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()

    inst:AddComponent("inspectable")

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetChanceLootTable("henhouse")

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)

    inst:AddComponent("childspawner")
    inst.components.childspawner.childname = "chicken" --生成鸡
    inst.components.childspawner.allowwater = true --允许在水中生长
    inst.components.childspawner:SetRegenPeriod(200) -- 生成新的鸡的时间间隔，单位为秒
    inst.components.childspawner:SetSpawnPeriod(20) -- 每间隔这么久生成一次鸡
    inst.components.childspawner:SetMaxChildren(2) -- 最大同时存在的鸡的数量
    inst.components.childspawner:StartSpawning()

    inst:AddComponent("container")
    inst.components.container:WidgetSetup("treasurechest")
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose

    inst:ListenForEvent("onbuilt", onbuilt)

    --inst:DoPeriodicTask(60, SpawnEgg) -- 每60秒生成一个鸡蛋

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.canbepickedup = false

    --[[inst:AddComponent("activatable")
    inst.components.activatable.OnActivate = CollectEgg]]

    return inst
end

return Prefab("henhouse", fn, assets, prefabs),
    MakePlacer("henhouse_placer", "henhouse", "henhouse", "idle")
