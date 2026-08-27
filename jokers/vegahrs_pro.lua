local self_destruct_event = nil
local create_consumable_event = nil

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
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    cost = 8,
    rarity = 3,

    config = {
        extra = {
            numerator = 1,
            denominator = 3
        }
    },
    
    loc_vars = function(self, info_queue, card)
        local e = card.ability.extra
        local numerator, denominator = SMODS.get_probability_vars(card, e.numerator, e.denominator)

        return {
            vars = {
                numerator,
                denominator
            }
        }
    end,

    calculate = function(self, card, context)
        local e = card.ability.extra

        if context.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1

            G.E_MANAGER:add_event(create_consumable_event(context.blueprint_card or card))
            return nil, true
        end

        if context.end_of_round and context.main_eval and not context.game_over then
            if SMODS.pseudorandom_probability(card, 'j_mahrlatr_vegahrs_pro', e.numerator, e.denominator) then
                G.E_MANAGER:add_event(Event({
                    trigger = "immediate",
                    func = function()
                        SMODS.calculate_effect({
                            message = localize('vegahrs_pro_crashed'),
                            colour = G.C.RED },
                            context.blueprint_card or card
                        )

                        G.E_MANAGER:add_event(self_destruct_event(card))
                        return true
                    end
                }))
            else
                SMODS.calculate_effect({
                    message = localize('k_saved_ex'),
                    colour = G.C.RED },
                    context.blueprint_card or card
                )
            end
        end
    end
}

self_destruct_event = function(card)
    return Event({
        trigger = "after",
        delay = 2,
        func = function()
            SMODS.destroy_cards(card, nil, nil, true)
            return true
        end
    })
end

create_consumable_event = function(card)
    return Event({
        trigger = "immediate",
        func = function()
            SMODS.add_card({
                set = "Consumeables"
            })
            G.GAME.consumeable_buffer = 0
            card:juice_up(0.5, 0.5)
            return true
        end
    })
end