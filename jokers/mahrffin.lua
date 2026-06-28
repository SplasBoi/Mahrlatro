SMODS.Joker { --Mahrffin
    key = "mahrffin",
    
    pos = {
        x = 0,
        y = 2
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

    cost = 4,
    rarity = 1,

    config = {
        extra = {
            dollars = 1
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
        if context.before then
            return {
                func = function()
                    ease_dollars(card.ability.extra.dollars)
                    card_eval_status_text(
                        context.blueprint_card or card,
                        'extra',
                        nil,
                        nil,
                        nil,
                        {
                            message = "+$".. card.ability.extra.dollars,
                            colour = G.C.MONEY
                        }
                    )
                    return true
                end
            }
        end
    end
}