SMODS.Joker {
    key = "speedrunnahr",
    blueprint_compat = true,
    perishable_compat = false,
    rarity = 1,
    cost = 5,
    pos = { x = 5, y = 13 },
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    config = { extra = { chips = 0, chip_mod = 15 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chip_mod } }
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint and next(context.poker_hands['Straight']) then
            -- See note about SMODS Scaling Manipulation on the wiki
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}