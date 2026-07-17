SMODS.Joker {
    key = "mahrllion",
    unlocked = false,
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    pos = { x = 5, y = 10 },
    config = { extra = { mult = 2, dollars = 5 } },

    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },


    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.dollars, card.ability.extra.mult * math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars) } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult *
                    math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars)
            }
        end
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 2 } }
    end
}