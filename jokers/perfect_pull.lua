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
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    cost = 7,
    rarity = 2,

    config = {
        extra = {
            dollars = 5,
            has_triggered = false
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
        if context.after and SMODS.last_hand_oneshot then
            return {
                func = function()
                    local amount = card.ability.extra.dollars

                    if card.ability.extra.has_triggered then
                        play_sound('mahrlatr_splas_perfect_again') else
                            play_sound("mahrlatr_splas_perfect")
                    end

                    card.ability.extra.has_triggered = true

                    
                    
                    ease_dollars(amount)
                    card_eval_status_text(
                        context.blueprint_card or card,
                        'extra',
                        nil,
                        nil,
                        nil,
                        {
                            message = "+$".. amount,
                            colour = G.C.MONEY
                        }
                    )
                    return true
                end
            }
        end
    end
}