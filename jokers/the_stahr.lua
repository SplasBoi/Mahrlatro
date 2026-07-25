
SMODS.Joker { --The Stahr
    key = "the_stahr",

    config = {
        extra = {
            dollars = 1
        }
    },

    pos = {
        x = 6,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },

    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                localize('$'),
                card.ability.extra.dollars
            }
        }
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local card_id = context.other_card:get_id()
            if (card_id == 6 or card_id == 7) then
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
                                message = "+".. amount,
                                colour = G.C.MONEY
                            }
                        )
                        return true
                    end
                }
            end
        end
    end
}