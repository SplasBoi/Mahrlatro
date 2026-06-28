
SMODS.Joker { --Le Hospital
    key = "lehospital",

    config = {
        extra = {
            dollars = 1000
        }
    },

    pos = {
        x = 4,
        y = 0
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },

    cost = 5,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },
    
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over and context.main_eval  then
            return {
                func = function()
                    ease_dollars(-math.abs(card.ability.extra.dollars))
                    card_eval_status_text(
                        context.blueprint_card or card,
                        'extra',
                        nil,
                        nil,
                        nil,
                        {
                            message = "Medical Debt",
                            colour = G.C.MONEY
                        }
                    )
                    return true
                end,
                extra = {
                    saved = true,
                    message = "Le Hospital Saved You..",
                    colour = G.C.RED,
                    extra = {
                        func = function()
                            local target_joker = card
                            
                            if target_joker then
                                target_joker.getting_sliced = true
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                                        return true
                                    end
                                }))
                                card_eval_status_text(
                                    context.blueprint_card or card,
                                    'extra', nil, nil, nil,
                                    {
                                        message = "Destroyed!",
                                        colour = G.C.RED
                                    }
                                )
                            end
                        end
                    }
                }
            }
        end
    end
}