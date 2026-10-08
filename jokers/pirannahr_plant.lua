SMODS.Joker {
    key = "pirannahr_plant",

    pos = {
        x = 6,
        y = 12
    },

    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    blueprint_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = false,

    config = {
        extra = {
            unique_suits_required = 3,
            x_mult = 3,
            scored_suits = {}
        }
    },

    loc_vars = function(self, info_queue, card)
        local e = card.ability.extra or self.config.extra

        return {
            vars = {
                e.x_mult,
                e.unique_suits_required
            }
        }
    end,

    calculate = function(self, card, context)
        local e = card.ability.extra or self.config.extra

        if context.initial_scoring_step then
            e.scored_suits = {}
        end

        if context.joker_main then
            for _, scored_card in ipairs(context.scoring_hand) do
                local suit = scored_card.base.suit
                e.scored_suits[suit] = (e.scored_suits[suit] or 0) + 1
            end

            if TableUtility.dict_size(e.scored_suits) >= e.unique_suits_required then
                return {
                    x_mult = e.x_mult
                }
            end
        end
    end,

    joker_display_def = function(JokerDisplay)
        return {
            text = {
                {
                    border_nodes = {
                        { text = "X" },
                        {
                            ref_table = "card.joker_display_values",
                            ref_value = "x_mult",
                            retrigger_type = "exp"
                        }
                    }
                }
            },
            text_config = { colour = G.C.WHITE },

            calc_function = function(card)
                local e = card.ability.extra
                scored_suits = {}

                text, _, scoring_hand = JokerDisplay.evaluate_hand()

                for _, scored_card in ipairs(scoring_hand) do
                    local suit = scored_card.base.suit
                    scored_suits[suit] = (scored_suits[suit] or 0) + 1
                end

                if TableUtility.dict_size(scored_suits) >= e.unique_suits_required then
                    card.joker_display_values.x_mult = e.x_mult
                else
                    card.joker_display_values.x_mult = 1
                end
            end
        }
    end
}