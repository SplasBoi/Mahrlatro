
SMODS.Joker{ --New Joker
    key = "zoomahr",
    config = {
        extra = {
        }
    },

    pos = {
        x = 2,
        y = 13
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },

    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },
    
    calculate = function(self, card, context)
        local max_default_game_speed = 4
        if context.first_hand_drawn  then
            G.SETTINGS.GAMESPEED = 20
        end
        if context.selling_self  then
            G.SETTINGS.GAMESPEED = max_default_game_speed
        end
    end
}