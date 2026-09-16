SMODS.Joker {
    key = "face_monstahr",

    pos = {
        x = 6,
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
    rarity = 2,

    config = {
        extra = {
            numerator = 1,
            denominator = 3
        }
    },

    loc_vars = function(self, info_queue, card)
        local e = card.ability.extra
        local num, denom = SMODS.get_probability_vars(card, e.numerator, e.denominator)

        return {
            vars = {
                num,
                denom
            }
        }
    end,

    calculate = function(self, card, context)
        local e = card.ability.extra

        if context.discard and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if SMODS.pseudorandom_probability(card, 'j_mahrlatr_face_monstahr', card.ability.extra.numerator, card.ability.extra.denominator) and context.other_card:is_face() then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                SMODS.add_card {
                                    set = 'Tarot',
                                    key_append = 'j_mahrlatr_face_monstahr'
                                }
                                G.GAME.consumeable_buffer = 0
                                return true
                            end
                        }))
                        SMODS.calculate_effect({ message = localize('k_plus_tarot'), colour = G.C.PURPLE },
                            context.blueprint_card or card)
                        return true
                    end)
                }))
                return nil, true -- This is for Joker retrigger purposes
            end
        end
    end,

    joker_display_def = function ()
        ---@type JDJokerDefinition
        
        return {
            text = {
                { text = "+" },
                { ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult" },
            },

            text_config = { colour = G.C.SECONDARY_SET.Tarot },

            extra = {
                {
                    { text = "(" },
                    { ref_table = "card.joker_display_values", ref_value = "odds" },
                    { text = ")" },
                }
            },

            extra_config = { colour = G.C.GREEN, scale = 0.3 },

            calc_function = function(card)
                local count = 0
                local in_blind = G.GAME.blind and G.GAME.blind.in_blind or G.STATE == G.STATES.SELECTING_HAND or
                    G.STATE == G.STATES.HAND_PLAYED or G.STATE == G.STATES.DRAW_TO_HAND
                    
                local hand = in_blind and G.hand.highlighted or {}
                for _, playing_card in pairs(hand) do
                    if playing_card.facing and not (playing_card.facing == 'back') and playing_card:is_face() then
                        count = count + 1
                    end
                end

                card.joker_display_values.count = count

                local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator, 'black_metahrl')

                card.joker_display_values.odds = localize { 
                    type = 'variable',
                    key = "jdis_odds",
                    vars = { numerator, denominator }
                }
            end
        }
    end
}