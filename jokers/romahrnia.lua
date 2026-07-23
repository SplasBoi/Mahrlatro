
SMODS.Joker{ 
    key = "romahrnia",
    config = {
        extra = {
            chips = 67,
            dollars = 5,
            xmult = 3.75
        }
    },

    pos = {
        x = 4,
        y = 9
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },

    cost = 4,
    rarity = 'mahrlatr_krejsi_rarity',
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["modprefix_mahrlatr_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.chips,
                localize('$'),
                card.ability.extra.dollars
            }
        }
    end,


    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                chips = card.ability.extra.chips,
                extra = {
                    
                    func = function()
                        
                        local current_dollars = G.GAME.dollars
                        local target_dollars = G.GAME.dollars + card.ability.extra.dollars
                        local dollar_value = target_dollars - current_dollars
                        ease_dollars(dollar_value)
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(5), colour = G.C.MONEY})
                        return true
                    end,
                    colour = G.C.MONEY,
                    extra = {
                        Xmult = card.ability.extra.xmult
                    }
                }
            }
        end
    end
}