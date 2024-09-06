local assets = {
    Asset("ANIM", "anim/egg.zip"), -- 确保有对应的动画与贴图文件
    Asset("ATLAS", "images/inventoryimages/egg.xml"),
    Asset("IMAGE", "images/inventoryimages/egg.tex"),
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("egg")
    inst.AnimState:SetBuild("egg")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("egg")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()

    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon( "egg.tex" )

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/egg.xml"

    inst:AddComponent("edible")
    inst.components.edible.healthvalue = 20
    inst.components.edible.hungervalue = 30
    inst.components.edible.sanityvalue = 10
    inst.components.edible.foodtype = FOODTYPE.MEAT -- 设置食物类型，例如 MEAT, VEGGIE, etc.

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_FAST)
    inst.components.perishable.onperishreplacement = "spoiled_food"

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_LARGEITEM

    return inst
end

return Prefab("egg", fn, assets)
