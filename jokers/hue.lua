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
    end,

    joker_display_def = function(JokerDisplay)
        ---@type JDJokerDefinition
    
        return {
            text = {
                { text = "+" },
                { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
            },

            text_config = { colour = G.C.MULT },

            calc_function = function(card)
                local e = card.ability.extra

                local scored_suits = {}
                card.joker_display_values.mult = 0

                local in_blind = G.GAME.blind and G.GAME.blind.in_blind or G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.HAND_PLAYED or G.STATE == G.STATES.DRAW_TO_HAND
                local hand = in_blind and G.hand.highlighted or {}

                local text, _, scoring_hand = JokerDisplay.evaluate_hand()

                if text == "Unknown" then return 0 end

                for _, playing_card in pairs(scoring_hand) do
                    local scored_suit = playing_card.base.suit
                    local is_wild = SMODS.has_enhancement(playing_card, 'm_wild')

                    if not TableUtility.contains_individual(scored_suit, scored_suits) or is_wild then
                        if is_wild then
                            table.insert(scored_suits, "Wild")
                            -- Wilds if retriggered can be counted as different suits each time.
                            card.joker_display_values.mult = card.joker_display_values.mult + e.mult * JokerDisplay.calculate_card_triggers(playing_card, hand)
                        else
                            table.insert(scored_suits, scored_suit)
                            -- Non-wilds cannot do that.
                            card.joker_display_values.mult = card.joker_display_values.mult + e.mult
                        end

                        -- All of this here is a very cheap solution. Been having a lot of trouble here.
                        -- This joker isn't supposed to go over 20 anyway
                        -- (even with retriggers) because it is logically impossible to score
                        -- more than 4 suits. I invite any of you to find a better solution.
                        if card.joker_display_values.mult > 20 then
                            card.joker_display_values.mult = 20
                        end
                    end
                end
            end
        }
    end
}