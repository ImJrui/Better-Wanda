GLOBAL.setmetatable(env, {__index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end })

DeconstructRecipe("pocketwatch_weapon_charged",
{Ingredient("pocketwatch_parts", 3), Ingredient("marble", 4), Ingredient("nightmarefuel", 8)})

AddRecipe2("watch_container",
{Ingredient("livinglog", 2), Ingredient("goldnugget", 4), Ingredient("honeycomb", 1)},
TECH.MAGIC_THREE,
{builder_tag = "clockmaker"},
{"CHARACTER", "CONTAINERS"})


