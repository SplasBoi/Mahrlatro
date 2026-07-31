SMODS.Joker {
    key = "mahrs_keyboard",

    pos = {
        x = -1,
        y = -1
    },
    
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    cost = 5,
    rarity = 1,

    config = {
        extra = {
            repetitions = 1
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                
            }
        }
    end,
    
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and not context.other_card:is_face() then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
    end
}