SMODS.Joker {
    key = "brasil_mentioned",

    pos = {
        x = 0,
        y = 15
    },
    
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    cost = 5,
    rarity = 1,

    config = {
        extra = {
            h_size = 1,
            chips = 75,
            numerator = 1,
            denominator = 4,
        }
    },

    loc_vars = function(self, info_queue, card)
        local e = card.ability.extra
        local num, denom = SMODS.get_probability_vars(card, e.numerator, e.denominator)

        return {
            vars = {
                colours = {
                    HEX('009440'),
                    HEX('FEDF00'),
                    HEX('302681')
                },

                e.h_size,
                e.chips,
                num,
                denom
            }
        }
    end,
    
    -- Feijoada
    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.extra.h_size)
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.h_size)
    end,
    
    calculate = function(self, card, context)
        local e = card.ability.extra

        -- Bossa Nova
        if context.first_hand_drawn then
            if G.GAME.blind and not G.GAME.blind.disabled and G.GAME.blind.boss then
                if SMODS.pseudorandom_probability(card, 'j_mahrlatr_brasil_mentioned', e.numerator, e.denominator) then
                    return {
                        message = localize('ph_boss_disabled'),
                        func = function()
                            G.GAME.blind:disable()
                        end
                    }
                end
            end
        end

        -- Takahrnaka
        if context.joker_main then
            return {
                chips = e.chips
            }
        end
    end
}