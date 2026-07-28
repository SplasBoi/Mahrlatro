SMODS.Joker {
    key = "evil_scary_face",
    blueprint_compat = true,
    rarity = 1,
    cost = 4,
    pos = { x = 6, y = 14 },
    config = { extra = { chips = 30 } },

    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_face() then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}