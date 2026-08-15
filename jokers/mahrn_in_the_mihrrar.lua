SMODS.Joker {
    key = "mihrrar",
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    config = { extra = { Xmult = 3 } },
    pos = { x = 5, y = 8 },
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },


    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and G.GAME.hands[context.scoring_name] and G.GAME.hands[context.scoring_name].played_this_round > 1 then
            return {
                xmult = card.ability.extra.Xmult
            }
        end
    end
}