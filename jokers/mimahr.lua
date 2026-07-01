
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
        if context.repetition and context.cardarea == G.play then
            if context.other_card.seal == "mahrlatr_mahr" then
                return {
                    repetitions = card.ability.extra.repetitions,
                    message = localize('k_again_ex')
                }
            end
        end
    end
}