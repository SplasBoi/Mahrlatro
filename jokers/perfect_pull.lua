SMODS.Joker {
    key = "perfect_pull",

    pos = {
        x = 1,
        y = 16
    },

    soul_pos = {
        x = 2,
        y = 16
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = false,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    cost = 7,
    rarity = 2,

    config = {
        extra = {
            dollars = 5,
            trigger_count = 0
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.dollars
            }
        }
    end,

    calculate = function(self, card, context)
        local e = card.ability.extra

        if context.after and SMODS.last_hand_oneshot then
            local sound = (e.trigger_count <= 0) and "mahrlatr_splas_perfect" or "mahrlatr_splas_perfect_again"
            e.trigger_count = e.trigger_count + 1

            return {
                func = function()
                    local dollar_amount = e.dollars

                    G.E_MANAGER:add_event(Event({
                        trigger = "immediate",
                        func = function()
                            play_sound(sound)
                            return true
                        end
                    }))
                    
                    ease_dollars(dollar_amount)
                    card_eval_status_text(
                        context.blueprint_card or card, 'extra', nil, nil, nil, {
                            message = "+" .. localize('$') .. dollar_amount,
                            colour = G.C.MONEY
                        }
                    )

                    return true
                end
            }
        end
    end,

    check_for_unlock = function(self, args)
        return args and args.oneshot
    end
}