SMODS.Joker {
    key = "nedahrland",
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    pos = { x = 0, y = 4 },
    config = { extra = { dollars = 1 } },
    atlas = 'CustomJokers',
    pools = { ["modprefix_mahrlatr_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit("Diamonds") then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
            return {
                dollars = card.ability.extra.dollars,
                func = function() -- This is for timing purposes, it runs after the dollar manipulation
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }
        end
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 30, localize('Diamonds', 'suits_singular') } }
    end
}