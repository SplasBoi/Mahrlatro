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
        local e = self.config.extra or card.ability.extra
        local num, denom = SMODS.get_probability_vars(card, e.numerator, e.denominator)

        return {
            vars = {
                num,
                denom
            }
        }
    end,

    calculate = function(self, card, context)
        local e = self.config.extra or card.ability.extra

        if context.discard and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if not context.other_card:is_face() then return end
            
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
}