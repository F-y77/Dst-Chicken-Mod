local assets = {
    Asset("ANIM", "anim/chicken_feather.zip"), -- 确保有对应的动画与贴图文件
    Asset("ATLAS", "images/inventoryimages/chicken_feather.xml"),
    Asset("IMAGE", "images/inventoryimages/chicken_feather.tex"),
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("chicken_feather")
    inst.AnimState:SetBuild("chicken_feather")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("chicken_feather")

    if not TheWorld.ismastersim then
        return inst
    end

    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon( "chicken_feather.tex" )

    inst.entity:SetPristine()

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/chicken_feather.xml"

    inst:AddComponent("tradable")
    inst.components.tradable.goldvalue = 1

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    return inst
end

return Prefab("chicken_feather", fn, assets)
