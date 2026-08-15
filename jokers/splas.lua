
SMODS.Joker { --Splas
    key = "splas",
    config = {
        extra = {
        }
    },

    pos = {
        x = 6,
        y = 2
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },

    cost = 3,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },
    
    calculate = function(self, card, context)
        
        if context.modify_scoring_hand and not context.blueprint then
            return {
                add_to_hand = true
            }
        end
    end
}