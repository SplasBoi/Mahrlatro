SMODS.Joker {
    key = "hue",

    pos = {
        x = 4,
        y = 15
    },
    
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
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
            local is_wild = SMODS.has_enhancement(context.other_card, 'm_wild')

            if not TableUtility.contains_individual(scored_suit, e.scored_suits) or is_wild then
                if is_wild then
                    table.insert(e.scored_suits, "Wild")
                else
                    table.insert(e.scored_suits, scored_suit)
                end

                card:juice_up(0.8, 0.8)

                -- If hand has 4 scoring cards with different suits + wild, wild will still be added, so the scoring_suits table will imply a hand has five suits, which doesn't make sense. So it also doesn't make sense giving +Mult for a "fifth" suit.
                if #e.scored_suits > 4 then return end

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