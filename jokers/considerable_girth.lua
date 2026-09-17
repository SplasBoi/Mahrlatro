local function should_score(context)
    return context and not context.end_of_round and context.individual and context.cardarea == G.hand and context.other_card.facing == "front"
end

SMODS.Joker {
    key = "considerable_girth",

    pos = {
        x = 5,
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

    calculate = function(self, card, context)
        if should_score(context) then
            local held_card = context.other_card

            return {
                chips = held_card.base.nominal
            }
        end
    end,

    joker_display_def = function(JokerDisplay)
        ---@type JDJokerDefinition
        return {
            text = {
                {
                    text = '+'
                },
                {
                    ref_table = "card.joker_display_values",
                    ref_value = "chips",
                }
            },
            text_config = { colour = G.C.CHIPS },

            calc_function = function(card)
                local chips = 0
                local hand = G.hand.cards

                for _, deck_card in ipairs(hand) do
                    if not deck_card.highlighted
                    and not SMODS.has_no_rank(deck_card)
                    and not deck_card.debuff
                    and deck_card.facing == "front" then
                        chips = chips + deck_card.base.nominal * JokerDisplay.calculate_card_triggers(deck_card, hand)
                    end
                end

                card.joker_display_values.chips = chips
            end
        }
    end
}