local Brain = require "brains/brain"

local ChickenBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

function ChickenBrain:OnStart()
    local root = PriorityNode(
    {
        WhileNode(function() return self.inst.components.health:IsDead() end, "IsDead",
            DoNothing()),

        WhileNode(function() return self.inst.components.sleeper:IsAsleep() end, "IsAsleep",
            DoNothing()),

        WhileNode(function() return self.inst.components.combat.target ~= nil end, "HasTarget",
            AttackWall(self.inst)),

        WhileNode(function() return self.inst.components.hunger:GetPercent() < 0.5 end, "IsHungry",
            FindFood(self.inst)),

        WhileNode(function() return TheWorld.state.isnight end, "IsNight",
            Panic(self.inst)),

        Wander(self.inst)
    }, 1)

    self.bt = BT(self.inst, root)
end

return ChickenBrain
