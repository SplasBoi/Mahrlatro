SMODS.Joker {
    key = "fish",

    config = {
        extra = {
            chips = 75,
            valid_suits = {
                "Spades",
                "Clubs"
            }
        }
    },

    pos = {
        x = 2,
        y = 2
    },

    display_size = {
        w = 71,
        h = 95
    },

    cost = 3,
    rarity = 1,
    blueprint_compat = true,
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
        local e = card.ability.extra or self.ability.extra

        if context.final_scoring_step and SuitHelpers.has_suit_in_hand(context.scoring_hand, e.valid_suits) then
            return {
                chips = e.chips
            }
        end
    end,

    joker_display_def = function(JokerDisplay)
        return {
            text = {
                { text = "+" },
                {
                    ref_table = "card.joker_display_values",
                    ref_value = "chips"
                }
            },
            text_config = { colour = G.C.CHIPS },

            calc_function = function(card)
                local e = card.ability.extra

                local _, _, scoring_hand = JokerDisplay.evaluate_hand()

                if SuitHelpers.has_suit_in_hand(scoring_hand, e.valid_suits) then
                    card.joker_display_values.chips = e.chips
                else
                    card.joker_display_values.chips = 0
                end
            end
        }
    end
}