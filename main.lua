SMODS.Atlas({
    key = "modicon", 
    path = "ModIcon.png", 
    px = 34,
    py = 34,
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "balatro", 
    path = "balatro.png", 
    px = 333,
    py = 216,
    prefix_config = { key = false },
    atlas_table = "ASSET_ATLAS"
})


SMODS.Atlas({
    key = "CustomJokers", 
    path = "CustomJokers.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "CustomConsumables", 
    path = "CustomConsumables.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "CustomSeals", 
    path = "CustomSeals.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
}):register()

local NFS = require("nativefs")
to_big = to_big or function(a) return a end
lenient_bignum = lenient_bignum or function(a) return a end
-- this function is used to load everything within a folder.-- Jokerforge doesnt use it because it doesnt make loading order easy
local function load_folder(path)
    local files = NFS.getDirectoryItemsInfo(SMODS.current_mod.path .. "/" .. path)
    for i = 1, #files do
        local file_name = files[i].name
        if file_name:sub(-4) == ".lua" then
            assert(SMODS.load_file(path .. file_name))()
        end
    end
end

load_folder("jokers/")
load_folder("consumables/")
load_folder("rarities/")
load_folder("seals/")
load_folder("common/")
load_folder('ui/')
load_folder('util/')
load_folder('achievements/')


SMODS.ObjectType({
    key = "mahrlatr_food",
    cards = {
        ["j_gros_michel"] = true,
        ["j_egg"] = true,
        ["j_ice_cream"] = true,
        ["j_cavendish"] = true,
        ["j_turtle_bean"] = true,
        ["j_diet_cola"] = true,
        ["j_popcorn"] = true,
        ["j_ramen"] = true,
        ["j_selzer"] = true
    },
})

SMODS.ObjectType({
    key = "mahrlatr_mahrlatr_jokers",
    cards = {
        ["j_mahrlatr_themahr"] = true,
        ["j_mahrlatr_mahrfiamember"] = true,
        ["j_mahrlatr_wildcat"] = true,
        ["j_mahrlatr_lehospital"] = true,
        ["j_mahrlatr_thedoctor"] = true
    },
})


SMODS.current_mod.optional_features = function()
    return {
        cardareas = {} 
    }
end

SMODS.Sound {
    key = "nutella_easy",
    path = "sfx/nutella_easy.ogg",
    pitch = 1.0
}

SMODS.Sound({
    key = "music1",
    pitch = 1.0,
    path = "music/mahrlatro_1.ogg",
    replace = "music1"
})

SMODS.Sound({
    key = "music2",
    pitch = 1.0,
    path = "music/mahrlatro_2.ogg",
    replace = "music2"
})

SMODS.Sound({
    key = "music3",
    pitch = 1.0,
    path = "music/mahrlatro_3.ogg",
    replace = "music3"
})

SMODS.Sound({
    key = "music4",
    pitch = 1.0,
    path = "music/mahrlatro_4.ogg",
    replace = "music4"
})

SMODS.Sound({
    key = "music5",
    pitch = 1.0,
    path = "music/mahrlatro_5.ogg",
    replace = "music5"
})