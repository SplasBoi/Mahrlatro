SMODS.Joker {
    key = "any_percent",

    pos = {
        x = 3,
        y = 16
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    cost = 4,
    rarity = 1,
    
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = G.GAME.hands[context.scoring_name].level
            }
        end
    end
}