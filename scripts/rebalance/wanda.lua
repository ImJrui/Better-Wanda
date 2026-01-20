local AddPrefabPostInit = AddPrefabPostInit
local AddPrefabPostInitAny = AddPrefabPostInitAny

GLOBAL.setmetatable(env, {__index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end })

UPGRADETYPES.POCKETWATCH_WEAPON = "pocketwatch_weapon"

local function CanBeUpgraded(inst, item)
    return not inst.components.equippable:IsEquipped()
end

local function OnUpgraded(inst, upgrader, item)
    local weapon = SpawnPrefab("pocketwatch_weapon_charged")
	weapon.components.fueled:SetPercent(inst.components.fueled:GetPercent())

    local container = inst.components.inventoryitem:GetContainer()
    if container ~= nil then
        local slot = inst.components.inventoryitem:GetSlotNum()
        inst:Remove()
        container:GiveItem(weapon, slot)
    else
        local x, y, z = inst.Transform:GetWorldPosition()
        inst:Remove()
        weapon.Transform:SetPosition(x, y, z)
    end
end

AddPrefabPostInit("pocketwatch_weapon", function(inst)
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("upgradeable")
    inst.components.upgradeable.upgradetype = UPGRADETYPES.POCKETWATCH_WEAPON
    inst.components.upgradeable:SetOnUpgradeFn(OnUpgraded)
    inst.components.upgradeable:SetCanUpgradeFn(CanBeUpgraded)
end)

AddPrefabPostInit("shadowheart_infused", function(inst)
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("upgrader")
    inst.components.upgrader.upgradetype = UPGRADETYPES.POCKETWATCH_WEAPON
end)

AddPrefabPostInit("wanda", function(inst)
    inst:AddTag(UPGRADETYPES.POCKETWATCH_WEAPON.."_upgradeuser")
    if not inst.components.planardefense then
        inst:AddComponent("planardefense")
    end
    inst.components.planardefense:AddBonus(inst, 5, "wanda")

    if not inst.components.damagetyperesist then
        inst:AddComponent("damagetyperesist")
    end
    inst.components.damagetyperesist:AddResist("lunaraligned_planarentity", inst, 0.9, "wanda_allegiance")
end)

AddPrefabPostInitAny(function(inst)
    if inst:HasTag("lunar_aligned") and inst.components.planardamage then
        inst:AddTag("lunaraligned_planarentity")
    end

    if not TheWorld.ismastersim then
        return
    end
end)

