-- prefabs/chicken.lua

local assets = {
    Asset("ANIM", "anim/chicken.zip"),
    Asset("SOUND", "sound/chicken_eat/chicken_eat_bank00.fsb"),
}


local brain = require "brains/chickenbrain"
--[[local states = {
    State("idle", "idle", assets),
    State("walk", "walk", assets),
    State("eat", "eat", assets),
    State("death", "death", assets),
}]]

--local stategraph = StateGraph("chicken", states, "idle") way2

--local stategraph = require "stategraphs/SGchicken" way3

--[[SetSharedLootTable("chicken",
{
    {"twigs",       0.5},

    {"cutgrass",       0.25},

    {"egg",       0.5},
    {"egg",       0.2},
    {"egg",       0.1},

    {"small_meat",       1},
    {"small_meat",       0.5},

    {"chicken_feather",       0.5},
    {"chicken_feather",       0.25},
    {"chicken_feather",       0.1},

})]]

local prefabs = {
    "bird_egg",
    "small_meat",
}

local function on_death(inst, data)
    inst.AnimState:PlayAnimation("eat")
    inst.SoundEmitter:PlaySound("chicken_eat_bank00")
    -- 掉落 bird_egg 和 small_meat
    --inst.components.lootdropper:SetChanceLootTable("chicken")
    inst.components.lootdropper:SpawnLootPrefab("egg")
    inst.components.lootdropper:SpawnLootPrefab("chicken_feather")
    inst.components.lootdropper:SpawnLootPrefab("small_meat")
end

local function on_attacked(inst, data)
    inst.AnimState:PlayAnimation("walk")
    -- 当鸡被攻击时，播放声音并逃跑
    inst.SoundEmitter:PlaySound("chicken_eat_bank00")
    inst.components.locomotor:RunInDirection(inst:GetAngleToPoint(data.attacker.Transform:GetWorldPosition()))
end

local function on_wake(inst)
    -- 当鸡醒来时，播放声音
    --inst.SoundEmitter:PlaySound("chicken_wake")
end

local function on_sleep(inst)
    -- 当鸡睡觉时，播放声音
    --inst.SoundEmitter:PlaySound("chicken_sleep")
end

local function on_idle(inst)
    -- 当鸡空闲时，随机移动
    if math.random() < 0.05 then
        local angle = math.random() * 2 * PI
        inst.components.locomotor:WalkInDirection(angle)
        inst.AnimState:PlayAnimation("walk", true)
    else
        inst.AnimState:PlayAnimation("walk", true)
    end
end

--[[local function on_attack(inst, data)
    -- 当鸡攻击时，播放攻击动画和声音
    inst.AnimState:PlayAnimation("eat")
    --inst.SoundEmitter:PlaySound("chicken_attack")

    -- 攻击目标
    local target = data.target
    if target and target.components.combat then
        target.components.combat:GetAttacked(inst, inst.components.combat.defaultdamage)
    end
end]]

local function on_attack_finished(inst)
    -- 攻击动画结束后，回到空闲状态
    inst.AnimState:PlayAnimation("walk", true)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeCharacterPhysics(inst, 1, 0.5)

    inst.AnimState:SetBank("chicken")
    inst.AnimState:SetBuild("chicken")
    inst.AnimState:PlayAnimation("walk")

    inst:AddTag("chicken")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon( "chicken.tex" )

    inst:AddComponent("locomotor")
    inst.components.locomotor.walkspeed = 2
    inst.components.locomotor.runspeed = 3

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(120)

    inst:AddComponent("combat")
    inst.components.combat:SetDefaultDamage(5)
    inst.components.combat:SetAttackPeriod(2)
    inst.components.combat:SetRange(1.5)
    --inst.components.combat:SetOnAttack(on_attack)  -- 确保在添加组件后设置回调函数

    inst:AddComponent("lootdropper")

    inst:AddComponent("knownlocations")

    inst:AddComponent("sleeper")
    inst.components.sleeper:SetWakeTest(function() return true end)
    inst.components.sleeper:SetSleepTest(function() return false end)

    --inst:AddBrain(brain) no way

    --inst:AddStategraph("states/chicken") no way

    inst:ListenForEvent("death", on_death)
    inst:ListenForEvent("attacked", on_attacked)
    inst:ListenForEvent("onwake", on_wake)
    inst:ListenForEvent("onsleep", on_sleep)
    inst:ListenForEvent("attackfinished", on_attack_finished)

    -- 添加空闲时的随机移动
    inst:DoPeriodicTask(1, on_idle)

    return inst
end

return Prefab("chicken", fn, assets, prefabs)
