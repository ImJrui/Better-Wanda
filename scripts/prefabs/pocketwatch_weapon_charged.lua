local assets =
{
    Asset("ANIM", "anim/pocketwatch_weapon.zip"),
}

local prefabs = 
{
	"pocketwatch_weapon_fx",
}

local PlanardamageMultiplier = 0.20
local PlanardamageBonus = PlanardamageMultiplier * 100
local PlanarBonus_OldAge = 60
local PlanarBonus_DecayTime = 3

local function TryStartFx(inst, owner)
	owner = owner
			or inst.components.equippable:IsEquipped() and inst.components.inventoryitem.owner
			or nil

	if owner == nil then
		return
	end

	if not inst.components.fueled:IsEmpty() then
		if inst._vfx_fx_inst ~= nil and inst._vfx_fx_inst.entity:GetParent() ~= owner then
			inst._vfx_fx_inst:Remove()
			inst._vfx_fx_inst = nil
		end

		if inst._vfx_fx_inst == nil then
			inst._vfx_fx_inst = SpawnPrefab("pocketwatch_weapon_fx")
			inst._vfx_fx_inst.entity:AddFollower()
			inst._vfx_fx_inst.entity:SetParent(owner.entity)
			inst._vfx_fx_inst.Follower:FollowSymbol(owner.GUID, "swap_object", 15, 70, 0)
		end
	end
end

local function StopFx(inst)
    if inst._vfx_fx_inst ~= nil then
        inst._vfx_fx_inst:Remove()
        inst._vfx_fx_inst = nil
    end
end

-------------------------------------------------------------------------------
local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "pocketwatch_weapon", "swap_object")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")

	TryStartFx(inst, owner)
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")

	StopFx(inst)
end

local function onequiptomodel(inst, owner, from_ground)
    StopFx(inst)
end

local function RemoveBonus(inst, source, key)
	if inst.components.planardamage.externalbonuses:HasModifier(source, key) then
		inst.components.planardamage:RemoveBonus(source, key)
		inst._hasbuff = false
		inst._hitcount = 0
	end
end

local function OnDurabilityChanged(inst)
	if inst._hasbuff then
		inst.components.inventoryitem:ChangeImageName("pocketwatch_weapon_charged_buff")
	else
		inst.components.inventoryitem:ChangeImageName("pocketwatch_weapon_charged")
	end
end

local function resetbuff(inst)
	if inst.decaystacktask ~= nil then
		inst.decaystacktask:Cancel()
		inst.decaystacktask = nil
	end

	inst._hitcount = 0

	RemoveBonus(inst, inst, "PlanarBonus_ChargedAlarm")
	OnDurabilityChanged(inst)
end

local function applybuff(inst)
	if inst.decaystacktask ~= nil then
		inst.decaystacktask:Cancel()
	end
	inst.decaystacktask = inst:DoTaskInTime(PlanarBonus_DecayTime, resetbuff)

	if inst._hasbuff then
		resetbuff(inst)
	else
		inst._hitcount = inst._hitcount + 1
	end

	if inst._hitcount >= 2 then
		inst.components.planardamage:AddBonus(inst, PlanarBonus_OldAge, "PlanarBonus_ChargedAlarm")
		inst._hasbuff = true
	end
end

local function OldAgeBonus(inst, attacker, target)
	local IsOld = attacker ~= nil and attacker.age_state and attacker.age_state == "old"
	local IsPlanarentity = target and target.components.planarentity and target.components.health
	if inst._hasbuff or inst.components.fueled:IsEmpty() or not IsOld then
		resetbuff(inst)
	elseif IsPlanarentity then
		applybuff(inst)
	end

	OnDurabilityChanged(inst)
	-- TheNet:Announce(inst._hitcount)
end

local function onattack(inst, attacker, target)
	if not inst.components.fueled:IsEmpty() then
		inst.components.fueled:DoDelta(inst._hasbuff and (-TUNING.TINY_FUEL * 2) or -TUNING.TINY_FUEL)
		if attacker == nil or attacker.age_state == nil or attacker.age_state == "young" then
			inst.SoundEmitter:PlaySound("wanda2/characters/wanda/watch/weapon/shadow_attack")
		else
			-- fx will handle sounds
		end
	else
        inst.SoundEmitter:PlaySound("wanda2/characters/wanda/watch/weapon/attack")
	end
	OldAgeBonus(inst, attacker, target)
end

local function GetStatus(inst, viewer)
	return (viewer:HasTag("pocketwatchcaster") and inst.components.fueled:IsEmpty()) and "DEPLETED"
			or nil
end

local function OnFuelChanged(inst, data)
    if data and data.percent then
        if data.percent > 0 then
            if not inst:HasTag("shadow_item") then
                inst:AddTag("shadow_item")
			    inst.components.weapon:SetDamage(TUNING.POCKETWATCH_SHADOW_DAMAGE * (1 - PlanardamageMultiplier))
				inst.components.planardamage:SetBaseDamage(TUNING.POCKETWATCH_SHADOW_DAMAGE * PlanardamageMultiplier + PlanardamageBonus)
				TryStartFx(inst)
            end
        else
            inst:RemoveTag("shadow_item")
		    inst.components.weapon:SetDamage(TUNING.POCKETWATCH_DEPLETED_DAMAGE)
			inst.components.planardamage:SetBaseDamage(0)
			StopFx(inst)
        end
    end
end

local function CLIENT_PlayFuelSound(inst)
	local parent = inst.entity:GetParent()
	local container = parent ~= nil and (parent.replica.inventory or parent.replica.container) or nil
	if container ~= nil and container:IsOpenedBy(ThePlayer) then
		TheFocalPoint.SoundEmitter:PlaySound("dontstarve/common/nightmareAddFuel")
	end
end

local function SERVER_PlayFuelSound(inst)
	local owner = inst.components.inventoryitem.owner
	if owner == nil then
		inst.SoundEmitter:PlaySound("dontstarve/common/nightmareAddFuel")
	elseif inst.components.equippable:IsEquipped() and owner.SoundEmitter ~= nil then
		owner.SoundEmitter:PlaySound("dontstarve/common/nightmareAddFuel")
	else
		inst.playfuelsound:push()
		--Dedicated server does not need to trigger sfx
		if not TheNet:IsDedicated() then
			CLIENT_PlayFuelSound(inst)
		end
	end
end


local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

	inst:AddTag("pocketwatch")

    inst.AnimState:SetBank("pocketwatch_weapon")
    inst.AnimState:SetBuild("pocketwatch_weapon")
    inst.AnimState:PlayAnimation("idle", true)

    MakeInventoryFloatable(inst, "small", 0.05, {1.2, 0.75, 1.2})

	inst.playfuelsound = net_event(inst.GUID, "pocketwatch_weapon.playfuelsound")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
		--delayed because we don't want any old events
		inst:DoTaskInTime(0, inst.ListenForEvent, "pocketwatch_weapon.playfuelsound", CLIENT_PlayFuelSound)

        return inst
    end

	inst._hitcount = 0
	inst._hasbuff = false

    inst.scrapbook_fueled_rate = TUNING.TINY_FUEL
    inst.scrapbook_fueled_uses = true

    inst:AddComponent("inventoryitem")

    inst:AddComponent("lootdropper")
	
    inst:AddComponent("inspectable")
	inst.components.inspectable.getstatus = GetStatus
	inst.components.inspectable:SetNameOverride("pocketwatch_weapon")
	
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    inst.components.equippable:SetOnEquipToModel(onequiptomodel)
	inst.components.equippable.restrictedtag = "pocketwatchcaster"

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(TUNING.POCKETWATCH_SHADOW_DAMAGE * (1 - PlanardamageMultiplier))
    inst.components.weapon:SetRange(TUNING.WHIP_RANGE)
    inst.components.weapon:SetOnAttack(onattack)

	inst:AddComponent("planardamage")
	inst.components.planardamage:SetBaseDamage(TUNING.POCKETWATCH_SHADOW_DAMAGE * PlanardamageMultiplier + PlanardamageBonus)

    inst:AddComponent("fueled")
    inst.components.fueled.fueltype = FUELTYPE.NIGHTMARE
    inst.components.fueled:InitializeFuelLevel(4 * TUNING.LARGE_FUEL)
    inst.components.fueled.accepting = true
	inst.components.fueled:SetTakeFuelFn(SERVER_PlayFuelSound)

    inst:ListenForEvent("percentusedchange", OnFuelChanged)
	
    inst:DoTaskInTime(0, function()
        OnFuelChanged(inst, { percent = inst.components.fueled:GetPercent() })

		resetbuff(inst)
    end)

    MakeHauntableLaunch(inst)

    return inst
end

--------------------------------------------------------------------------------

return Prefab("pocketwatch_weapon_charged", fn, assets, prefabs)
