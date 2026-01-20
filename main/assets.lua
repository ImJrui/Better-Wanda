local RegisterInventoryItemAtlas = RegisterInventoryItemAtlas

PrefabFiles = {
	"pocketwatch_weapon_charged",
	"watch_container",
}

Assets = {
	Asset("ANIM", "anim/watch_container.zip"),

	Asset("IMAGE", "images/watch_container.tex"),
	Asset("ATLAS", "images/watch_container.xml"),
	Asset("IMAGE", "images/watch_container_open.tex"),
	Asset("ATLAS", "images/watch_container_open.xml"),
	Asset("IMAGE", "images/watch_slot.tex"),
	Asset("ATLAS", "images/watch_slot.xml"),
	Asset("IMAGE", "images/pocketwatch_weapon_charged.tex"),
	Asset("ATLAS", "images/pocketwatch_weapon_charged.xml"),
	Asset("IMAGE", "images/pocketwatch_weapon_charged_buff.tex"),
	Asset("ATLAS", "images/pocketwatch_weapon_charged_buff.xml"),
}

GLOBAL.setmetatable(env, {__index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end })

local items = {
	"watch_container",
	"watch_container_open",
	"watch_slot",
	"pocketwatch_weapon_charged",
	"pocketwatch_weapon_charged_buff",
}

for _, imagename in ipairs(items) do
	RegisterInventoryItemAtlas("images/"..imagename..".xml", imagename..".tex")
	RegisterInventoryItemAtlas("images/"..imagename..".xml", hash(imagename..".tex"))
end