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
    local files = NFS.getDirectoryItemsInfo(mod_path .. "/" .. path)
    for i = 1, #files do
        local file_name = files[i].name
        if file_name:sub(-4) == ".lua" then
            assert(SMODS.load_file(path .. file_name))()
        end
    end
end

-- load the jokers
local jokers_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. "jokers")
for _, file in ipairs(jokers_src) do
    assert(SMODS.load_file("jokers/" .. file))()
end

-- load the consumables
assert(SMODS.load_file("consumables/mahrmentioned.lua"))()

-- load the seals
assert(SMODS.load_file("seals/mahrseal.lua"))()

function SMODS.current_mod.reset_game_globals(run_start)
    local jokerPool = {}
    for k, v in pairs(G.P_CENTERS) do
        if v.set == 'Joker' then
            if (not v.mod) then
                G.GAME.banned_keys[k] = true
            end
        end
    end
end

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