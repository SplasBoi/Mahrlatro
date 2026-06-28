
SMODS.Joker { --Mimahr
    key = "mimahr",

    config = {
        extra = {
            repetitions = 1
        }
    },

    pos = {
        x = 2,
        y = 1
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },

    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
        if context.repetition and not context.cardarea == G.hand
            and context.end_of_round
            and (next(context.card_effects[1]) or context.card_effects > 1) then
            return {
                repetitions = 1,
                message = 'again!'
            }
        end
    end
}