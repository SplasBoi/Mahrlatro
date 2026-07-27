SMODS.Joker {
    key = "ratatouille",
    pos = { x = 3, y = 13 },
    rarity = 1,
    blueprint_compat = true,
    cost = 3,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    config = { extra = { t_mult = 8, type = 'Pair' }, },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.t_mult, localize(card.ability.extra.type, 'poker_hands') } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands[card.ability.extra.type]) then
            play_sound('mahrlatr_ratatouille')
            return {
                mult = card.ability.extra.t_mult
            }
        end
    end
}