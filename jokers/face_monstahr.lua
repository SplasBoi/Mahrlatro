SMODS.Joker {
    key = "face_mahrnster",

    pos = {
        x = -1,
        y = -1
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
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    cost = 5,
    rarity = 1,

    config = {
        extra = {
            numerator = 1,
            denominator = 3
        }
    },

    loc_vars = function(self, info_queue, card)
        local num, denom = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator)

        return {
            vars = {
                num,
                denom
            }
        }
    end,

    calculate = function(self, card, context)
        if context.discard and context.other_card:is_face() then
            if SMODS.pseudorandom_probability(card, 'j_mahrlatr_face_mahrnster', card.ability.extra.numerator, card.ability.extra.denominator) then
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
                                            key_append = 'j_mahrlatr_face_mahrnster'
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