local containers = require("containers")
local params = containers.params

local storable = {
	["pocketwatch_dismantler"] = true,
	["pocketwatch_parts"] = true,
}

--------------------------------------------------------------------------
--[[ watch_container ]]
--------------------------------------------------------------------------

params.watch_container =
{
    widget =
    {
        slotpos = {},
        slotbg  = {},
        animbank  = "ui_backpack_2x4",
        animbuild = "ui_backpack_2x4",
        pos = Vector3(75, 195, 0),
        side_align_tip = 160,
    },
    type = "chest",
}

local watch_container_bg = { image = "watch_slot.tex", atlas = "images/watch_slot.xml" }

for y = 0, 3 do
    table.insert(params.watch_container.widget.slotpos, Vector3(-162     , -75 * y + 114, 0))
    table.insert(params.watch_container.widget.slotpos, Vector3(-162 + 75, -75 * y + 114, 0))

    table.insert(params.watch_container.widget.slotbg, watch_container_bg)
    table.insert(params.watch_container.widget.slotbg, watch_container_bg)
end

function params.watch_container.itemtestfn(container, item, slot)
    return  item:HasTag("pocketwatch") or storable[item.prefab] == true
end

--------------------------------------------------------------------------

for k, v in pairs(params) do
    containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end

--------------------------------------------------------------------------


