SMODS.Joker {
    key = "black_metahrl",

    pos = {
        x = 1,
        y = 4
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
            denominator = 8
        }
    },

    loc_vars = function(self, info_queue, card)
        local num, denom = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator)

        return {
            vars = {
                colours = { HEX('000000') },

                num,
                denom
            }
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SuitHelpers.is_black_card(context.other_card) then
            if SMODS.pseudorandom_probability(card, 'j_mahrlatr_black_metahrl', card.ability.extra.numerator, card.ability.extra.denominator) then
                return {
                    extra = {
                        message = localize('k_plus_tarot'),
                        message_card = card,
                        func = (function()
                            G.E_MANAGER:add_event(Event({
                                func = (function()
                                    if #G.consumeables.cards < G.consumeables.config.card_limit then
                                        SMODS.add_card {
                                            set = 'Tarot',
                                            key_append = 'j_mahrlatr_black_metahrl'
                                        }
                                    end
                                    
                                    return true
                                end)
                            }))
                        end)
                    }
                }
            end
        end
    end
}