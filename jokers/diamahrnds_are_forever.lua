
SMODS.Joker { --Epic Weed
    key = "diamahrnds",

    config = {
        extra = {
            mult = 3
        }
    },

    pos = {
        x = 2,
        y = 3
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:is_suit("Diamonds") then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}