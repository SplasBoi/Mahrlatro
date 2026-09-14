SMODS.Joker { --Meat
    key = "meat",

    config = {
        extra = {
            mult = 7,
            valid_suits = {
                "Hearts",
                "Diamonds"
            }
        }
    },
    
    pos = {
        x = 1,
        y = 2
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

    cost = 4,
    rarity = 1,
    
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,

    calculate = function(self, card, context)
        local e = card.ability.extra or self.ability.extra

        if context.final_scoring_step and SuitHelpers.has_suit_in_hand(context.scoring_hand, e.valid_suits) then
            return {
                mult = e.mult
            }
        end
    end,

    joker_display_def = function(JokerDisplay)
        return {
            text = {
                { text = "+" },
                {
                    ref_table = "card.joker_display_values",
                    ref_value = "mult"
                }
            },
            text_config = { colour = G.C.MULT },

            calc_function = function(card)
                local e = card.ability.extra

                local _, _, scoring_hand = JokerDisplay.evaluate_hand()

                if SuitHelpers.has_suit_in_hand(scoring_hand, e.valid_suits) then
                    card.joker_display_values.mult = e.mult
                else
                    card.joker_display_values.mult = 0
                end
            end
        }
    end
}