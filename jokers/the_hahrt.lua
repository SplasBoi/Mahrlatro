
SMODS.Joker { --The Hahrt
    key = "thehahrt",

    config = {
        extra = {
            mult = 3
        }
    },

    pos = {
        x = 3,
        y = 1
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
    discovered = true,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("Hearts") then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}