SMODS.Joker {
    key = "hue",

    pos = {
        x = 1,
        y = 1
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
            mult = 5,
            scored_suits = {}
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,
    
    calculate = function(self, card, context)
        local e = card.ability.extra

        if context.individual and context.cardarea == G.play then
            local scored_suit = context.other_card.base.suit

            if not TableUtility.contains_individual(scored_suit, e.scored_suits) then
                table.insert(e.scored_suits, scored_suit)

                card:juice_up(0.8, 0.8)

                return {
                    mult = card.ability.extra.mult
                }
            end
        end

        if context.joker_main then
            e.scored_suits = {}
        end
    end
}