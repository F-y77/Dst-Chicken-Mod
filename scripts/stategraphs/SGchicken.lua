
-- This stategraph is used for the chicken entity.  


-- Create the stategraph

--定义状态机
local assets = {
    Asset("ANIM", "anim/chicken.zip"),
}

local states = {
    State{
        name = "idle",
        onenter = function(inst)
            inst.AnimState:PlayAnimation("idle")
        end,
        events = {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
    },

    State{
        name = "walk",
        onenter = function(inst)
            inst.AnimState:PlayAnimation("walk_loop", true)
        end,
        onexit = function(inst)
            inst.components.locomotor:Stop()
        end,
        timeline = {
            TimeEvent(0, function(inst)
                inst.components.locomotor:WalkForward()
            end),
        },
        events = {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("walk")
            end),
        },
    },

    State{
        name = "eat",
        onenter = function(inst)
            inst.AnimState:PlayAnimation("eat")
        end,
        events = {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
    },

    State{
        name = "hit",
        onenter = function(inst)
            inst.AnimState:PlayAnimation("hit")
        end,
        events = {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
    },

    State{
        name = "death",
        onenter = function(inst)
            inst.AnimState:PlayAnimation("death")
            inst:RemoveComponent("locomotor")
            inst.components.health:SetInvincible(true)
            inst.persists = false
        end,
        onexit = function(inst)
            inst.components.health:SetInvincible(false)
        end,
        events = {
            EventHandler("animover", function(inst)
                inst:Remove()
            end),
        },
    },
}

--定义事件机

local events = {
    EventHandler("attacked", function(inst)
        if not inst.components.health:IsDead() then
            return "hit"
        end
    end),

    EventHandler("death", function(inst)
        return "death"
    end),

    EventHandler("locomote", function(inst)
        if inst.components.locomotor:WantsToMoveForward() then
            return "walk"
        else
            return "idle"
        end
    end),
}
local events = {
    EventHandler("attacked", function(inst)
        if not inst.components.health:IsDead() then
            return "hit"
        end
    end),

    EventHandler("death", function(inst)
        return "death"
    end),

    EventHandler("locomote", function(inst)
        if inst.components.locomotor:WantsToMoveForward() then
            return "walk"
        else
            return "idle"
        end
    end),
}

--定义动作处理器

local actionhandlers = {
    ActionHandler(ACTIONS.EAT, "eat"),
}

--创建并返回状态图

local function InitializeStateGraph()
    return StateGraph("chicken", states, events, "idle", actionhandlers)
end

--设置鸡的状态图

local function OnLoad(inst, data)
    inst.sg = InitializeStateGraph()
end

local function OnSave(inst, data)
    -- 保存状态图相关数据
end

local function fn()
    local inst = CreateEntity()

    -- 其他组件和逻辑
    inst:AddComponent("locomotor")
    inst:AddComponent("health")
    inst:AddComponent("stategraph")

    inst.OnLoad = OnLoad
    inst.OnSave = OnSave

    return inst
end

return Prefab("chicken", fn, assets, prefabs)
