SMODS.Atlas {
    key = "modicon", 
    path = "ModIcon.png", 
    px = 34,
    py = 34,
    atlas_table = "ASSET_ATLAS"
}

SMODS.Atlas {
    key = "balatro", 
    path = "balatro.png", 
    px = 333,
    py = 216,
    prefix_config = { key = false },
    atlas_table = "ASSET_ATLAS"
}

SMODS.Atlas{
    key = "shop_sign",
    path = "Mahrket.png",
    px=113,
    py=57,
    atlas_table = 'ANIMATION_ATLAS',
    raw_key = true,
	frames = 4,
    prefix_config = {key = false}
}

SMODS.Atlas {
    key = "CustomJokers", 
    path = "CustomJokers.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
}

SMODS.Atlas {
    key = "CustomConsumables", 
    path = "CustomConsumables.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
}

SMODS.Atlas {
    key = "CustomEnhancements", 
    path = "CustomEnhancements.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
}

SMODS.Atlas {
    key = "CustomPlanets", 
    path = "CustomPlanets.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
}

SMODS.Atlas {
    key = "CustomSpectrals", 
    path = "CustomSpectrals.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
}

SMODS.Atlas {
    key = "CustomBoosters", 
    path = "CustomBoosters.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
}

SMODS.Atlas {
    key = "CustomSeals", 
    path = "CustomSeals.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
}

SMODS.Atlas {
    key = "CustomBacks",
    path = "CustomBack.png",
    px = 71,
    py = 95,
    atlas_table = "ASSET_ATLAS"
}

SMODS.Atlas {
    key = "CustomBlinds",
    path = "CustomBlinds.png",
    px = 34,
    py = 34,
    frames = 21,
    atlas_table = "ANIMATION_ATLAS"
}

SMODS.Atlas {
    key = "Monkey",
    path = "Monkey.png",
    px = 71,
    py = 95,
    frames = 32,
    fps = 20,
    atlas_table = "ANIMATION_ATLAS"
}

SMODS.Atlas {
    key = "Benjamin",
    path = "Benjamin.png",
    px = 71,
    py = 95,
    frames = 30,
    fps = 30,
    atlas_table = "ANIMATION_ATLAS"
}

local NFS = require("nativefs")
to_big = to_big or function(a) return a end
lenient_bignum = lenient_bignum or function(a) return a end

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
load_folder("boosters/")
load_folder("rarities/")
load_folder("seals/")
load_folder("enhancements/")
load_folder("common/")
load_folder('ui/')
load_folder('util/')
load_folder('achievements/')
load_folder('decks/')
load_folder('blinds/')


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

SMODS.ObjectType {
    key = "mahrlatr_food_jokahr",
    cards = {
        ["j_mahrlatr_cheese"] = true,
        ["j_mahrlatr_coca_colahr"] = true,
        ["j_mahrlatr_feijoada"] = true,
        ["j_mahrlatr_fish"] = true,
        ["j_mahrlatr_laugen_geback"] = true,
        ["j_mahrlatr_mahrffin"] = true,
        ["j_mahrlatr_mahrtini"] = true,
        ["j_mahrlatr_meat"] = true,
        ["j_mahrlatr_agg"] = true,
    }
}

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

SMODS.Sound {
    key = "gold",
    path = "sfx/gold.ogg",
}

SMODS.Sound {
    key = "ratatouille",
    path = "sfx/ratatouille.ogg",
}

SMODS.Sound {
    key = "noiflo",
    path = "sfx/noiflo.ogg",
}

SMODS.Sound {
    key = "ratatouille_honk",
    path = "sfx/ratatouille_honk.ogg",
    pitch = 1.0
}

SMODS.Sound {
    key = "star",
    path = "sfx/ratatouille_star.ogg",
    pitch = 1.0
}

SMODS.Sound {
    key = "uh_guys",
    path = "sfx/uh_guys.ogg",
    pitch = 1.0
}

SMODS.Sound {
    key = "mahrio_win",
    path = "sfx/mahrio_win.ogg",
    pitch = 1.0
}

SMODS.Sound {
    key = "try_not_to_get_scared",
    path = "sfx/try_not_to_get_scared.ogg",
    pitch = 1.0
}

SMODS.Sound {
    key = "bobby_good_job",
    path = "sfx/bobby_good_job.ogg",
    pitch = 1.0
}

SMODS.Sound {
    key = "bobby_try_this_hand",
    path = "sfx/bobby_try_this_hand.ogg",
    pitch = 1.0
}

SMODS.Sound {
    key = "joel_laughing_1",
    path = "sfx/joel_laughing_1.ogg",
    pitch = 1.0
}

SMODS.Sound {
    key = "joel_laughing_2",
    path = "sfx/joel_laughing_2.ogg",
    pitch = 1.0
}

SMODS.Sound {
    key = "joel_laughing_3",
    path = "sfx/joel_laughing_3.ogg",
    pitch = 1.0
}

SMODS.Sound {
    key = "joel_laughing_4",
    path = "sfx/joel_laughing_4.ogg",
    pitch = 1.0
}

SMODS.Sound {
    key = "mahr_no_no_dont",
    path = "sfx/mahr_no_no_dont.ogg",
    pitch = 1.0
}

SMODS.Sound {
    key = "splas_perfect",
    path = "sfx/splas_perfect.ogg",
    pitch = 1.0
}

SMODS.Sound {
    key = "splas_perfect_again",
    path = "sfx/splas_perfect_again.ogg",
    pitch = 1.0
}

SMODS.Sound {
    key = "roffle",
    path = "sfx/roffle.ogg",
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

--custom card art

local ranks = {'2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', "King", "Ace"}

local hearts_atlas = SMODS.Atlas {
    key = 'hearts',
    path = "mahr_card_hearts.png",
    atlas_table = 'ASSET_ATLAS',
    px = 71,
    py = 95,
    disable_mipmap = true,
}
local clubs_atlas = SMODS.Atlas {
    key = 'clubs',
    path = "mahr_card_clubs.png",
    atlas_table = 'ASSET_ATLAS',
    px = 71,
    py = 95,
    disable_mipmap = true,
}
local diamonds_atlas = SMODS.Atlas {
    key = 'diamonds',
    path = "mahr_card_diamonds.png",
    atlas_table = 'ASSET_ATLAS',
    px = 71,
    py = 95,
    disable_mipmap = true,
}
local spades_atlas = SMODS.Atlas {
    key = 'spades',
    path = "mahr_card_spades.png",
    atlas_table = 'ASSET_ATLAS',
    px = 71,
    py = 95,
    disable_mipmap = true,
}


-- Deck Skins
SMODS.DeckSkin {
    key = "skibidi_mahr_cards_hearts",
    suit = "Hearts",
    loc_txt = "Skibidi Mahr Cards",
    palettes = {
        {
            key = 'hc',
            ranks = ranks,
            display_ranks = {"King", "Queen", "Jack"},
            atlas = hearts_atlas.key,
            pos_style = 'suit',
            hc_default = true,
        },
    },
}
SMODS.DeckSkin {
    key = "skibidi_mahr_cards_diamonds",
    suit = "Diamonds",
    loc_txt = "Skibidi Mahr Cards",
    palettes = {
        {
            key = 'hc',
            ranks = ranks,
            display_ranks = {"King", "Queen", "Jack"},
            atlas = diamonds_atlas.key,
            pos_style = 'suit',
            hc_default = true,
        },
    },
}
SMODS.DeckSkin {
    key = "skibidi_mahr_cards_clubs",
    suit = "Clubs",
    loc_txt = "Skibidi Mahr Cards",
    palettes = {
        {
            key = 'hc',
            ranks = ranks,
            display_ranks = {"King", "Queen", "Jack"},
            atlas = clubs_atlas.key,
            pos_style = 'suit',
            hc_default = true,
        },
    },
}
SMODS.DeckSkin {
    key = "skibidi_mahr_cards_spades",
    suit = "Spades",
    loc_txt = "Skibidi Mahr Cards",
    palettes = {
        {
            key = 'hc',
            ranks = ranks,
            display_ranks = {"King", "Queen", "Jack"},
            atlas = spades_atlas.key,
            pos_style = 'suit',
            hc_default = true,
        },
    },
}