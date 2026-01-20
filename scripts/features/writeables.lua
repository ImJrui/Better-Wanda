local SignGenerator = require"signgenerator"

local writeables = require("writeables")

local kinds = {}

kinds["pocketwatch_recall"] = {
    prompt = "Write on the watch",
    animbank = "ui_board_5x3",
    animbuild = "ui_board_5x3",
    menuoffset = Vector3(6, -70, 0),
    maxcharacters = TUNING.BEEFALO_NAMING_MAX_LENGTH,

    cancelbtn = { text = STRINGS.SIGNS.MENU.CANCEL, cb = nil, control = CONTROL_CANCEL },
    middlebtn = { text = STRINGS.SIGNS.MENU.RANDOM, cb = function(inst, doer, widget)
            widget:OverrideText( SignGenerator(inst, doer) )
        end, control = CONTROL_MENU_MISC_2 },
    acceptbtn = { text = STRINGS.SIGNS.MENU.ACCEPT, cb = nil, control = CONTROL_ACCEPT },

    --defaulttext = SignGenerator,
}

kinds["pocketwatch_portal"] = kinds["pocketwatch_recall"]

for name,layout in pairs(kinds) do
    writeables.AddLayout(name,layout)
end
