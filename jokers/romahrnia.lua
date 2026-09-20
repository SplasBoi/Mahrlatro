SMODS.Joker{ 
    key = "romahrnia",
    config = {
        extra = {
            chips = 67,
            dollars = 2,
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
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        local e = card.ability.extra

        return {
            vars = {
                e.xmult,
                e.chips,
                localize('$'),
                e.dollars
            }
        }
    end,


    calculate = function(self, card, context)
        local e = card.ability.extra

        if context.cardarea == G.jokers and context.joker_main  then
            return {
                chips = e.chips,
                
                extra = {
                    func = function()
                        ease_dollars(e.dollars)
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {
                            message = "+" .. e.dollars,
                            colour = G.C.MONEY
                        })
                        return true
                    end,

                    colour = G.C.MONEY,

                    extra = {
                        Xmult = e.xmult
                    }
                }
            }
        end
    end,

    joker_display_def = function(JokerDisplay)
        return {
            text = {
                { -- XMult
                    border_nodes = {
                        { text = "X" },
                        {
                            ref_table = "card.ability.extra",
                            ref_value = "xmult",
                            retrigger_type = "exp"
                        }
                    }
                }
            },

            text_config = { colour = G.C.WHITE },

            extra = {
                { -- Chips
                    {
                        text = "+",
                        colour = G.C.CHIPS
                    },
                    {
                        ref_table = "card.ability.extra",
                        ref_value = "chips",
                        colour = G.C.CHIPS
                    }
                },

                {-- Dollars
                    {
                        text = "+" .. localize("$"),
                        colour = G.C.MONEY
                    },
                    {
                        ref_table = "card.ability.extra",
                        ref_value = "dollars",
                        colour = G.C.MONEY
                    }
                }
            }
        }
    end
}