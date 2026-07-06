SMODS.Joker {
    key = "where_mahr",
    blueprint_compat = true,
    rarity = 2,
    cost = 8,
    pos = { x = 4, y = 7 },

    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { G.jokers and math.max(1, (G.jokers.config.card_limit - #G.jokers.cards) + #SMODS.find_card("j_vremade_stencil", true)) or 1 } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = math.max(1,
                    (G.jokers.config.card_limit - #G.jokers.cards) + #SMODS.find_card("j_vremade_stencil", true))
            }
        end
    end
}