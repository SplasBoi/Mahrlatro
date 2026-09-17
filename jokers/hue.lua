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
        local e = card.ability.extra or self.config.extra

        if context.initial_scoring_step then
            e.scored_suits = {}
        end

        if context.individual and context.cardarea == G.play then
            local suit = context.other_card.base.suit
            local is_wild = JokerUtility.is_wild_card(context.other_card)
            local scored_suit = (is_wild and "Wild") or suit

            -- register suit
            e.scored_suits[scored_suit] = (e.scored_suits[scored_suit] or 0) + 1

            if e.scored_suits[scored_suit] <= 1 and TableUtility.dict_size(e.scored_suits) <= 4 then
                -- Stop adding mult after having scored each suit
                return {
                    mult = e.mult
                }
            end
        end
    end,

    joker_display_def = function(JokerDisplay)
        ---@type JDJokerDefinition
    
        return {
            text = {
                { text = "+" },
                {
                    ref_table = "card.joker_display_values",
                    ref_value = "mult",
                    retrigger_type = "mult"
                }
            },

            text_config = { colour = G.C.MULT },

            calc_function = function(card)
                local e = card.ability.extra

                local scored_suits = {}
                
                local in_blind = JokerUtility.is_in_blind()
                local hand = in_blind and G.hand.highlighted or {}
                local text, _, scoring_hand = JokerDisplay.evaluate_hand()


                if text == "Unknown" then
                    card.joker_display_values.mult = 0
                    return
                end

                local scored_suits = {}

                for _, playing_card in pairs(scoring_hand) do
                    local is_wild = JokerUtility.is_wild_card(playing_card)
                    local card_suit = (is_wild and "Wild") or playing_card.base.suit
                    scored_suits[card_suit] = (scored_suits[card_suit] or 0) + JokerDisplay.calculate_card_triggers(playing_card, hand)
                end

                local mult_scaling = TableUtility.dict_size(scored_suits)
                if mult_scaling > 4 then
                    mult_scaling = 4
                end

                card.joker_display_values.mult = e.mult * mult_scaling
            end
        }
    end
}