
SMODS.Joker{ --Kahrl Mahrx
    key = "kahrl_mahrx",
    config = {
        extra = {
        }
    },

    pos = {
        x = 1,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },

    cost = 4,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },
    
    calculate = function(self, card, context)
        if context.final_scoring_step  then
            return {
                balance = true
            }
        end
    end
}