SMODS.Joker {
    key = "footbahrll",
    blueprint_compat = true,
    rarity = 3,
    cost = 8,
    pos = { x = 0, y = 9 },
    config = { extra = { xmult = 1.5 } },

    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.other_joker and context.other_joker:is_rarity("Uncommon") then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}