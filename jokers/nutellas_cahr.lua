SMODS.Joker {
    key = "nutellas_cahr",

    pos = {
        x = 5,
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
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahr_mahr_jokers"] = true },

    cost = 7,
    rarity = 3,

    config = {
        extra = {
            dollars = 10
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