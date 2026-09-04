SMODS.Enhancement {
    key = 'pink_stone',

    pos = { x = 0, y = 0 },
    
    config = {
        mult = 5
    },
    
    badge_colour = HEX('FF7DFE'),

    atlas = 'CustomEnhancements',

    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.mult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            unlock_achievement("ach_mahrlatr_score_pink_stone_card")
        end
    end
}