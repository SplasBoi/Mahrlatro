SMODS.Joker {
    key = 'vegahrs_pro',

    pos = {
        x = 0,
        y = 8
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
    pools = { ["mahr_mahr_jokers"] = true },

    cost = 8,
    rarity = 3,

    config = {
        extra = {
            numerator = 1,
            denominator = 5
        }
    },
    
    loc_vars = function(self, info_queue, card)
        local num_crash, denom_crash = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator)

        return {
            vars = {
                num_crash,
                denom_crash
            }
        }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            
            G.E_MANAGER:add_event(Event({
                func = (function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card {
                                set = "Consumeables"
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                    SMODS.calculate_effect({ message = localize('vegahrs_pro_edited'), colour = G.C.PURPLE },
                        context.blueprint_card or card)
                    return true
                end)
            }))
            return nil, true

        end

        if context.end_of_round and context.main_eval and not context.game_over then
            if SMODS.pseudorandom_probability(card, 'j_mahrlatr_vegahrs_pro', card.ability.extra.numerator, card.ability.extra.denominator) then
                
                SMODS.calculate_effect({ message = localize('vegahrs_pro_crashed'), colour = G.C.RED }, context.blueprint_card or card)

                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 2, func = function()
                    -- This will crash the game LUL
                    card.ability.extra.vegahrs_pro_stability = card.ability.extra.vegahrs_pro_stability + 1
                
                    return nil
                end }))
            end
        end
    end
}