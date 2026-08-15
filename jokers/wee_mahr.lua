
SMODS.Joker { --Wee Mahr
    key = "wee_mahr",

    config = {
        extra = {
            chips = 0
        }
    },

    pos = {
        x = 6,
        y = 0
    },

    display_size = {
        w = 71 * 0.7, 
        h = 95 * 0.7
    },

    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips
            }
        }
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if context.other_card:get_id() == 2 then
                card.ability.extra.chips = card.ability.extra.chips + 8
            end
        end
        
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}