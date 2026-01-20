GLOBAL.setmetatable(env, {__index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end })

local function OnNamedByWriteable(inst, name)
    if inst.components.named ~= nil then
        inst.components.named:SetName(name)
    end
end

local function OnUsedOnWatch(inst, target, user)
    if user:HasTag("pocketwatchcaster") then
        target.components.writeable:BeginWriting(user)
        target._writer = user
        inst.components.stackable:Get():Remove()
    end
end

local function OnWritingEnded(inst)
    if not inst.components.writeable:IsWritten() then
        local writer = inst._writer
        if writer and writer.components.inventory then
            writer.components.inventory:GiveItem(SpawnPrefab("featherpencil"))
        else
            SpawnPrefab("featherpencil").Transform:SetPosition(inst.Transform:GetWorldPosition())
        end
        inst._writer = nil
    end
end

--------------------------------------------------------

local function renamewatch(inst)
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("named")
    inst:AddComponent("writeable")
    inst.components.writeable:SetDefaultWriteable(false)
    inst.components.writeable:SetAutomaticDescriptionEnabled(false)
    inst.components.writeable:SetWriteableDistance(TUNING.BEEFALO_NAMING_DIST)
    inst.components.writeable:SetOnWrittenFn(OnNamedByWriteable)
    inst.components.writeable:SetOnWritingEndedFn(OnWritingEnded)
end

AddPrefabPostInit("pocketwatch_recall", renamewatch)
AddPrefabPostInit("pocketwatch_portal", renamewatch)

AddPrefabPostInit("featherpencil", function(inst)
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("useabletargeteditem")
    inst:AddTag("pocketwatch_recall_targeter")
    inst:AddTag("pocketwatch_portal_targeter")
    -- inst.components.useabletargeteditem:SetTargetPrefab("pocketwatch_recall")
    inst.components.useabletargeteditem:SetOnUseFn(OnUsedOnWatch)
    inst.components.useabletargeteditem:SetInventoryDisable(true)
end)

AddComponentPostInit("recallmark", function(inst)
	local _Copy = inst.Copy
	function inst:Copy(rhs)
		_Copy(self, rhs)
		if (self.inst.prefab == "pocketwatch_recall" or self.inst.prefab == "pocketwatch_portal")
            and rhs.components.named and rhs.components.named.name ~= nil
        then
			self.inst.components.named:SetName(rhs.components.named.name)
		end
	end
end)
