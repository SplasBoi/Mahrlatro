
SMODS.Joker {
    key = "dutch_plus_ratio",

    config = {
        extra = {
            mult = 3
        }
    },

    pos = {
        x = 5,
        y = 5
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    
    cost = 5,
    rarity = 'mahrlatr_krejsi_rarity',
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
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