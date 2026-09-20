
SMODS.Joker { --Mahrbles Trolley
    key = "mahrbles_trolley",

    pos = {
        x = 3,
        y = 2
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

    config = {
        extra = {
            mult = 10,
            chips = 100,
            dollars = 2
        }
    },

    loc_vars = function(self, info_queue, card)
        local e = card.ability.extra or self.config.extra

        return {
            vars = {
                e.mult,
                e.chips,
                localize('$'),
                e.dollars
            }
        }
    end,

    add_to_deck = function(self, card, from_debuff)
        unlock_achievement('ach_mahrlatr_obtain_trolley')
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                mult = card.ability.extra.mult,
                extra = {
                    chips = card.ability.extra.chips,
                    colour = G.C.CHIPS,
                    extra = {
                        func = function()
                            ease_dollars(card.ability.extra.dollars)
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                                {
                                    message = "+".. card.ability.extra.dollars,
                                    colour = G.C.MONEY
                                }
                            )
                            return true
                        end,
                        colour = G.C.MONEY
                    }
                }
            }
        end
    end,

    joker_display_def = function(JokerDisplay)
        -- TODO: 
        return {
            text = { -- Mult
                {
                    text = "+",
                    colour = G.C.MULT
                },
                {
                    ref_table = "card.ability.extra",
                    ref_value = "mult",
                    colour = G.C.MULT
                },
            },

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
                    },
                },

                { -- Dollars
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